/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_mountain2.gsc
***********************************************/

#include scripts\core_common\compass;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\struct;
#include scripts\mp\mp_mountain2_scripted;
#include scripts\mp_common\load;

#namespace mp_mountain2;

event_handler[level_init] main(eventstruct) {
  load::main();
  screen = spawn("script_model", (2794, -860, 397));

  if(isDefined(screen)) {
    screen setModel(#"p8_screen_tactical_artic_01");
    screen.angles = (0, 360, 0);
  }

  paris = spawn("script_model", (2880, -579, 401));

  if(isDefined(paris)) {
    paris setModel(#"p7_mou_clock_wall");
  }

  parishour = spawn("script_model", (2880, -580, 412.75));

  if(isDefined(parishour)) {
    parishour setModel(#"p7_mou_clock_wall_hour_hand");
    parishour.angles = (270, 0, 0);
  }

  var_371a2ab2 = spawn("script_model", (2880, -580, 412.75));

  if(isDefined(var_371a2ab2)) {
    var_371a2ab2 setModel(#"p7_mou_clock_wall_minute_hand");
    var_371a2ab2.angles = (60.0807, 180, 180);
  }

  var_fffeb20c = spawn("script_model", (2880, -580, 412.75));

  if(isDefined(var_fffeb20c)) {
    var_fffeb20c setModel(#"p7_mou_clock_wall_second_hand");
    var_fffeb20c.angles = (300.14, 180, 180);
  }

  moscow = spawn("script_model", (2912, -579, 401));

  if(isDefined(moscow)) {
    moscow setModel(#"p7_mou_clock_wall");
  }

  moscowhour = spawn("script_model", (2912, -580, 412.75));

  if(isDefined(moscowhour)) {
    moscowhour setModel(#"p7_mou_clock_wall_hour_hand");
    moscowhour.angles = (329.372, 0, 0);
  }

  var_baff123c = spawn("script_model", (2912, -580, 412.75));

  if(isDefined(var_baff123c)) {
    var_baff123c setModel(#"p7_mou_clock_wall_minute_hand");
    var_baff123c.angles = (29.6108, 359.999, -0.000344339);
  }

  var_514f5b9e = spawn("script_model", (2912, -580, 412.75));

  if(isDefined(var_514f5b9e)) {
    var_514f5b9e setModel(#"p7_mou_clock_wall_second_hand");
    var_514f5b9e.angles = (29.9897, 179.999, -180);
  }

  tokyo = spawn("script_model", (2944, -579, 401));

  if(isDefined(tokyo)) {
    tokyo setModel(#"p7_mou_clock_wall");
  }

  var_2a4a4014 = spawn("script_model", (2944, -580, 412.75));

  if(isDefined(var_2a4a4014)) {
    var_2a4a4014 setModel(#"p7_mou_clock_wall_hour_hand");
    var_2a4a4014.angles = (270, 0, 0);
  }

  var_4bdd4662 = spawn("script_model", (2944, -580, 412.75));

  if(isDefined(var_4bdd4662)) {
    var_4bdd4662 setModel(#"p7_mou_clock_wall_minute_hand");
    var_4bdd4662.angles = (29.6108, 359.999, -0.000344339);
  }

  var_342d094f = spawn("script_model", (2944, -580, 412.75));

  if(isDefined(var_342d094f)) {
    var_342d094f setModel(#"p7_mou_clock_wall_second_hand");
    var_342d094f.angles = (60.0097, 179.999, -180);
  }

  newyork = spawn("script_model", (2976, -579, 401));

  if(isDefined(newyork)) {
    newyork setModel(#"p7_mou_clock_wall");
  }

  var_242acc4f = spawn("script_model", (2976, -580, 412.75));

  if(isDefined(var_242acc4f)) {
    var_242acc4f setModel(#"p7_mou_clock_wall_hour_hand");
    var_242acc4f.angles = (29.7827, 180, -180);
  }

  var_46519b3f = spawn("script_model", (2976, -580, 412.75));

  if(isDefined(var_46519b3f)) {
    var_46519b3f setModel(#"p7_mou_clock_wall_minute_hand");
    var_46519b3f.angles = (300.197, 180.003, 179.996);
  }

  var_d2742cd4 = spawn("script_model", (2976, -580, 412.75));

  if(isDefined(var_d2742cd4)) {
    var_d2742cd4 setModel(#"p7_mou_clock_wall_second_hand");
    var_d2742cd4.angles = (360, 179.999, -179.999);
  }

  london = spawn("script_model", (3008, -579, 401));

  if(isDefined(london)) {
    london setModel(#"p7_mou_clock_wall");
  }

  londonhour = spawn("script_model", (3008, -580, 412.75));

  if(isDefined(londonhour)) {
    londonhour setModel(#"p7_mou_clock_wall_hour_hand");
    londonhour.angles = (329.47, 180, 180);
  }

  var_31916926 = spawn("script_model", (3008, -580, 412.75));

  if(isDefined(var_31916926)) {
    var_31916926 setModel(#"p7_mou_clock_wall_minute_hand");
    var_31916926.angles = (29.8036, 359.997, -0.00414518);
  }

  var_263824e8 = spawn("script_model", (3008, -580, 412.75));

  if(isDefined(var_263824e8)) {
    var_263824e8 setModel(#"p7_mou_clock_wall_second_hand");
    var_263824e8.angles = (59.6511, 0.00129378, 0.000693975);
  }

  compass::setupminimap("");
  level.cleandepositpoints = array((1860, -140, 127), (3004, -168, 326), (4008, -888, 327), (3270, -1960, 464), (3875, -1580, 327.75));
  spawncollision("collision_clip_wall_128x128x10", "collider", (2171, -475, 392), (0, 0, 0));
  spawncollision("collision_clip_ramp_64x24", "collider", (2163, -481, 320), (0, 270, 90));
  spawncollision("collision_clip_ramp_64x24", "collider", (2173, -434.5, 232), (0, 249, 94));
  level thread gondola_sway();
  level thread glass_exploder_init();
  glasses = struct::get_array("glass_shatter_on_spawn", "targetname");

  for(i = 0; i < glasses.size; i++) {
    radiusdamage(glasses[i].origin, 32, 101, 100);
    wait 0.05;
  }
}

gondola_sway() {
  level endon(#"gondola_triggered");
  gondola_cab = getent("gondola_cab", "targetname");
  gondola_cab setmovingplatformenabled(1);

  while(true) {
    randomswingangle = randomfloatrange(2, 5);
    randomswingtime = randomfloatrange(2, 3);
    gondola_cab rotateto((randomswingangle * 0.5, randomswingangle * 0.6 + 90, randomswingangle * 0.8), randomswingtime, randomswingtime * 0.3, randomswingtime * 0.3);
    gondola_cab playSound("amb_gondola_swing");
    wait randomswingtime;
    gondola_cab rotateto((randomswingangle * 0.5 * -1, randomswingangle * -1 * 0.6 + 90, randomswingangle * 0.8 * -1), randomswingtime, randomswingtime * 0.3, randomswingtime * 0.3);
    gondola_cab playSound("amb_gondola_swing_back");
    wait randomswingtime;
  }
}

glass_exploder_init() {
  single_exploders = [];

  for(i = 0; i < level.createfxent.size; i++) {
    ent = level.createfxent[i];

    if(!isDefined(ent)) {
      continue;
    }

    if(ent.v[#"type"] != "exploder") {
      continue;
    }

    if(ent.v[#"exploder"] == 201 || ent.v[#"exploder"] == 202) {
      ent thread glass_group_exploder_think();
      continue;
    }

    if(ent.v[#"exploder"] >= 101 && ent.v[#"exploder"] <= 106) {
      single_exploders[single_exploders.size] = ent;
      continue;
    }

    if(ent.v[#"exploder"] == 301 || ent.v[#"exploder"] == 302) {
      single_exploders[single_exploders.size] = ent;
    }
  }

  level thread glass_exploder_think(single_exploders);
}

glass_group_exploder_think() {
  thresholdsq = 25600;
  count = 0;

  for(;;) {
    origin = self;
    level waittill(#"glass_smash", origin);

    if(distancesquared(self.v[#"origin"], origin) < thresholdsq) {
      count++;
    }

    if(count >= 3) {
      exploder::exploder(self.v[#"exploder"]);
      return;
    }
  }
}

glass_exploder_think(exploders) {
  thresholdsq = 25600;

  if(exploders.size <= 0) {
    return;
  }

  for(;;) {
    origin = self;
    closest = 998001;
    closest_exploder = undefined;
    level waittill(#"glass_smash", origin);

    for(i = 0; i < exploders.size; i++) {
      if(!isDefined(exploders[i])) {
        continue;
      }

      if(isDefined(exploders[i].glass_broken)) {
        continue;
      }

      distsq = distancesquared(exploders[i].v[#"origin"], origin);

      if(distsq > thresholdsq) {
        continue;
      }

      if(distsq < closest) {
        closest_exploder = exploders[i];
        closest = distsq;
      }
    }

    if(isDefined(closest_exploder)) {
      closest_exploder.glass_broken = 1;
      exploder::exploder(closest_exploder.v[#"exploder"]);
    }
  }
}