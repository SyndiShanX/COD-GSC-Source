/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_shellshock.gsc
********************************/

main(var_0, var_1, var_2, var_3, var_4, var_5) {
  level thread internalmain(var_0, var_1, var_2, var_3, var_4, var_5);
}

internalmain(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_0))
    var_0 = 12;
  else if(var_0 < 7)
    var_0 = 7;

  if(!isdefined(var_1))
    var_1 = 150;

  if(!isdefined(var_2))
    var_2 = 100;

  if(!isdefined(var_3))
    var_3 = 100;

  if(!isdefined(var_5))
    var_6 = "default";
  else
    var_6 = var_5;

  var_7 = level.player getorigin() + (0, 8, 2);
  var_8 = 320;
  var_9 = var_1 + randomint(var_2);
  var_10 = var_3;
  level.player playsound("weapons_rocket_explosion");
  wait 0.25;
  radiusdamage(var_7, var_8, var_9, var_10);
  earthquake(0.75, 2, var_7, 2250);

  if(isalive(level.player)) {
    level.player allowstand(0);
    level.player allowcrouch(0);
    level.player allowprone(1);
    wait 0.15;
    level.player viewkick(127, level.player.origin);
    level.player shellshock(var_6, var_0);

    if(!isdefined(var_4))
      level.player thread playerhitable(var_0);

    wait 1.5;
    level.player allowstand(1);
    level.player allowcrouch(1);
  }
}

playerhitable(var_0) {
  self.shellshocked = 1;
  self.ignoreme = 1;
  self notify("player is shell shocked");
  self endon("player is shell shocked");
  wait(var_0 - 1);
  self.shellshocked = 0;
  self.ignoreme = 0;
}