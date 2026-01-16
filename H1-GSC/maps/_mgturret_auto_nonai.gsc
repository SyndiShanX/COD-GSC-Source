/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_mgturret_auto_nonai.gsc
*****************************************/

main(var_0, var_1) {
  thread set_up_auto_non_ai_turret(self, var_0, var_1);
}

stop_turret_on_gunner_death(var_0, var_1, var_2) {
  var_1 waittill("death");

  if(!isdefined(var_0)) {
    return;
  }
  if(isremovedentity(var_0)) {
    return;
  }
  var_0 setmode("manual");
  var_0 cleartargetentity();
  var_0 stopfiring();
}

keep_gunner_oriented_with_turret(var_0, var_1) {
  var_1 endon("death");

  for (;;) {
    var_2 = var_0 gettagangles("tag_aim_pivot");
    var_1 orientmode("face angle", var_2[1]);
    wait 0.05;
  }
}

set_up_auto_non_ai_turret(var_0, var_1, var_2) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 setmode("auto_nonai");
  var_1 linkto(var_0, var_2.sittag, (0, 0, 0), (0, 0, 0));
  thread stop_turret_on_gunner_death(var_0, var_1, var_2);
  thread keep_gunner_oriented_with_turret(var_0, var_1);
  var_3 = var_0 gettagorigin(var_2.sittag);
  var_4 = var_0 gettagangles(var_2.sittag);

  for (;;)
    var_0 maps\_vehicle_aianim::animontag(var_1, var_2.sittag, var_2.idle);
}