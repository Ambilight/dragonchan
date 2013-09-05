<?php

$boss_hp_percentage = floor($this->BossHP/$this->BossHP_MAX * 100);
$BossName = $this->BossName;
?>
<!DOCTYPE html>
<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <link rel="stylesheet" type="text/css" href="http://css.ink.sapo.pt/v1/css/ink.css" />


        <title>Dragonchan</title>
        <link href="site.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <a target="_blank" href="https://github.com/Ambilight/dragonchan"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png" alt="Fork me on GitHub"></a>
        <div class="ink-container" style="width:90%;">

        <h2>Dragonchan <span class="small"><a href="http://boards.4chan.org/b/res/<?php echo $this->THREAD_ID; ?>">#<?php echo $this->THREAD_ID; ?></a></span>
            <small><a target="_blank" href="info">version <?php echo $this->_version; ?> (More Info)</a></small>
        </h2>
        <br />
        <div class="ink-row">
            <div class="ink-gutter">
                <div class="ink-l40">
                    <h3><?php echo $BossName; ?></h3>
                    <img style="width:300px;" src="<?php echo $this->BossIMG;?>">
                </div>
                <div class="ink-l60">
                    <div class="hp-bar">
                        <div class="health">
                            <div class="health-remaining <?php
                                // Color the HP bar
                                if($boss_hp_percentage <= 50 && $boss_hp_percentage > 35) { echo "yellow"; }
                                    elseif($boss_hp_percentage <= 35 && $boss_hp_percentage > 15) { echo "orange"; }
                                    elseif($boss_hp_percentage <= 15) {  echo "red"; }
                                ?>" style="width:<?php echo $boss_hp_percentage; ?>%;"></div>
                            <div class="health-total" style="width:<?php echo 100 - ($boss_hp_percentage); ?>%;"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="health-remaining-text">
                            HP: <?php echo number_format($this->BossHP); ?> / <?php echo number_format($this->BossHP_MAX); ?>
                            <div class="boss-element"><img src="images/sprites/rpg/elements/<?php echo $this->BossElement; ?>.png" title="<?php echo $this->BossElement; ?>"> <?php echo $this->BossElement; ?></div>
                        </div>
                    </div>

                    <?php if($this->bossIsDead()) { ?>
                        <table class="ink-table">
                            <tr>
                                <td colspan='4' style='font-size:22px;'>
                                    <span class='ink-label success'>THE <?php echo $BossName; ?> HAS BEEN SLAIN!</span>
                                </td>
                            </tr>
                        </table>

                    <?php }elseif($this->bossIsEnraged()) { ?>

                        <table class="ink-table">
                            <tr>
                                <td colspan='4' style='font-size:22px;'>
                                    <span class='ink-label caution'><?php echo $BossName; ?> HAS ENRAGED!</span> <small>Every roll under <?php echo $this->min_roll; ?> will result in death!!</small>
                                </td>
                            </tr>
                        </table>

                    <?php } ?>
                    <h3>Latest Hit</h3>
                    <table class="ink-table">
                        <?php $_row =  $BATTLE[0]; ?>
                        <?php include('attack_sequence.tpl'); ?>
                    </table>


                </div>
            </div>
        </div>
        <div class="clear ink-vspace"></div>
        <div class="ink-row">
            <div class="ink-gutter">
              <div class="ink-l40">
                <div class="ink-l90">
                  <h4><span class="ink-label warning">NEW!</span> Ranger (beta)!</h4>
                  <p>The new Ranger Class is here!, check your ID for X,Y or Z</p>
                  <p>check the documentation for help on using rangers.</p>
                </div>
              </div>
              <div class="ink-l60">
                <h4>Classes</h4>
                <ul>
                  <?php include("class_rolls.tpl"); ?>
                  <li>Your last 2 digits represent the damage you do</li>
                  <li><a target="_blank" href="info">(see the full rules)</a></li>
                </ul>
              </div>
            </div>
        </div>

        <hr/>

        <?php
        if($this->WINNER){
            $WINNER_praises =  $this->getPostReplies($this->WINNER->no);
            $WINNER_text = $this->WINNER->com;
            $WINNER_text = str_replace("<br>",' ',$WINNER_text);
            $WINNER_text = str_replace("<br/>",' ',$WINNER_text);
            $WINNER_text = html_entity_decode(strip_tags($WINNER_text));
            $WINNER_text = preg_replace('/>>(\d+){9}/i','',$WINNER_text);
            $WINNER_class = $this->WINNER->class;

            echo "<h2 class='hero'>";
            echo "WINRAR!!! Hail the new monster slayer!";
            echo "<br/>";
            echo '<a target="_blank" href="'.$this->WINNER->link.'">';
            echo " &gt;&gt;".$this->WINNER->no;
            echo '</a>';
            echo "&nbsp;&nbsp;";
            echo "<p style='color:#666;'> $WINNER_text &nbsp; - <span class='ink-label class-$WINNER_class' style='font-size:15px;'>";
            echo $this->getNickname($this->WINNER->id);
            echo "</span>";
            echo "</p>";
            echo "</h2>";

            $i = 0;
            if($WINNER_praises){
               echo "<h1>The party praises the new hero!</h1>";
               echo "<div class='ink-row'>";
                echo "<div class='ink-gutter'>";
                foreach($WINNER_praises as $_item){
                    if(empty($_item->text)){
                      continue;
                    }
                    echo "<div class='ink-l20 praise'>";
                     echo "<h4 class='ink-label class-".$_item->class."'>
                     <img src='images/sprites/rpg/armor/" . $_item->sprite . "' />
                     <img src='images/sprites/rpg/weapons/" . $_item->weapon . "' /> ".$this->getNickname($_item->id)." says:</h4>";
                     echo $_item->text;
                    echo "</div>";
                    if($i == 3) { $i = 0; echo "<div class='ink-row ink-vspace'></div>"; } else { $i++; }
                }

                echo "</div>";
               echo "</div>";
               echo "<div class='ink-row ink-vspace'></div>";
            }
        }
        ?>
        <div class="ink-row">
            <div class="ink-gutter">
                <div class="ink-l70">
                    <h3>Battle Log</h3>
                    <table class="ink-table ink-zebra">
                    <?php foreach($BATTLE as $_row){ ?>
                        <?php

                        if($_row['action']=="enrage"){
                          //enrage notice
                            echo "<tr>";
                                echo "<td colspan='4' style='text-align:center; font-size:24px;'>";
                                  echo "<div class='ink-vspace'>";
                                    echo "<span class='ink-label caution'>$BossName HAS ENRAGED!</span>";
                                    echo "<br/><small>Every roll under $this->min_roll will result in death!!</small>";
                                  echo "</div>";
                                echo "</td>";
                            echo "</tr>";
                        } else {
                          //combat log
                          include('attack_sequence.tpl');
                        }

                        ?>
                    <?php } ?>
                    </table>

                </div>
                <div class="ink-gutter ink-l20 sidebar">
                    <h3>Top Damage</h3>
                     <?php foreach($topDamage as $_id => $_damage){
                     echo "<span class='ink-label caution'>".$_damage." HP</span>";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                    <h3>Top Revives</h3>
                     <?php foreach($topRevive as $_id => $_revives){
                     echo "<span class='ink-label success'>".$_revives."</span>";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                    <h3>Top Avengers</h3>
                     <?php foreach($topAvenge as $_id => $_avenges){
                     echo "<span class='ink-label info'>".$_avenges."</span>";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                    <h3>Top Bards</h3>
                     <?php foreach($topBuffs as $_id => $_count){
                     echo "<span class='ink-label caution' style='background-color:#F49D9D'>+".$_count."</span>";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                    <h3>Fallen Soldiers</h3>
                     <?php foreach($this->deadPlayers as $_id){
                     echo "&#x271D;";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                    <h3>Most Deaths</h3>
                     <?php foreach($topDeaths as $_id => $_count){
                     echo " <i>".$_count."</i>";
                     echo "&nbsp;&#x271D;";
                     echo "&nbsp;<span class='ink-label class-".self::getPlayerClass($_id)."'>";
                     echo $this->getNickname($_id);
                     echo "</span>";
                     echo "<br/>";
                     } ?>

                </div>
            </div>
        </div>



        </div>
    </body>
</html>
