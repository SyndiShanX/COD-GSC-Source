/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\green_beam_offhand.gsc
*******************************************************/



#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#namespace green_beam_offhand;

function precache(offhand) {
  level.var_9927cfeb7c54bc37 = spawnStruct();
  level.var_9927cfeb7c54bc37.trace_contents = create_contents(1, 1, 1, 1, 1, 1, 0, 0, 1);
  level.var_9927cfeb7c54bc37.in_use = 0;
  level.var_9927cfeb7c54bc37.used_once = 0;
  level.var_9927cfeb7c54bc37.last_beam_time = 0;
  level.var_9927cfeb7c54bc37.laser_vfx = loadfx("vfx/iw8/level/lab/vfx_green_laser.vfx");
  registeroffhandfirefunc(offhand, &function_50d81dbccc8973ba);
  playeroffhandthread(&function_c1ebe188ea4d6623);
  level.player thread function_77371b0fea36d1();
  precachemodel("misc_vm_handheld_green_laser");
  add_hint_string("offhand_green_beam_detailed", &"EQUIPMENT/OFFHAND_GREEN_BEAM_HINT_FULL");
  add_hint_string("offhand_green_beam_simple", &"EQUIPMENT/OFFHAND_GREEN_BEAM_HINT_SIMPLE");
  add_hint_string("offhand_green_beam_aim", &"EQUIPMENT/OFFHAND_GREEN_BEAM_HINT_AIM", &function_516f86ab845d2622);
  add_hint_string("offhand_green_beam_fire", &"EQUIPMENT/OFFHAND_GREEN_BEAM_HINT_FIRE", &function_bd000a9219ada719);
}

function function_50d81dbccc8973ba(grenade, weapon) {
  grenade delete();

  if(!level.var_9927cfeb7c54bc37.used_once) {
    level.var_9927cfeb7c54bc37.used_once = 1;
  }

  ignorearray = array_add(getaiarray("allies"), level.player);
  trace = ray_trace_detail(level.player getEye(), level.player getEye() + anglesToForward(level.player getplayerangles()) * 9999, ignorearray, level.var_9927cfeb7c54bc37.trace_contents, 1);

  if(getdvarint(@ "hash_4761f0c8cbb15da6")) {
    thread scripts\engine\trace::draw_trace(trace, undefined, 1, 60);
  }

  level notify("green_beam_target", trace["position"]);
  level.var_9927cfeb7c54bc37.last_beam_time = gettime();
}

function function_c1ebe188ea4d6623() {
  while(true) {
    self waittill("grenade_pullback", grenadeweapon);

    if(grenadeweapon.basename == "green_beam_offhand") {
      self notify("green_beam_offhand_raised");
      level.var_9927cfeb7c54bc37.in_use = 1;
      self.var_33fd2e8ba5dc653d show();
      self.var_33fd2e8ba5dc653d delaycall(0.8, &laserforceon);
      self enableslowaim(0.5, 0.5);
      result = waittill_any_return("offhand_end", "grenade_fire", "weapon_switch_pressed");

      if(result == "grenade_fire") {
        wait 1.1;
      }

      self.var_33fd2e8ba5dc653d laserforceoff();
      self.var_33fd2e8ba5dc653d hide();
      level.var_9927cfeb7c54bc37.in_use = 0;
      level.player disableslowaim();
    }
  }
}

function function_77371b0fea36d1() {
  assertex(!isDefined(self.lasertag), "Laser Tag getting created when one exists already!");
  self.var_33fd2e8ba5dc653d = spawn("script_model", self.origin + (0, 0, 0));
  self.var_33fd2e8ba5dc653d setModel("misc_vm_handheld_green_laser");
  temp = makeweapon("iw8_green_beam_ir");
  self.var_33fd2e8ba5dc653d setmoverlaserweapon(temp);
  self.var_33fd2e8ba5dc653d linktoplayerview(self, "TAG_ACCESSORY_LEFT", (0, 0, 0), (0, 0, 0), 1);
  self.var_33fd2e8ba5dc653d hide();
}

function function_516f86ab845d2622() {
  return level.var_9927cfeb7c54bc37.in_use;
}

function function_bd000a9219ada719() {
  return !level.var_9927cfeb7c54bc37.in_use;
}

function function_245baf97b86c8c73() {
  return level.var_9927cfeb7c54bc37.used_once;
}

function function_f38aa88acf3c9285() {
  time = gettime();

  while(level.var_9927cfeb7c54bc37.last_beam_time < time) {
    waitframe();
  }
}

function function_6fc444f3dc4c0984() {
  return isDefined(level.player.offhandweapon) && is_equal(level.player.offhandweapon.basename, "green_beam_offhand");
}

function function_c45bd0c8aed94517() {
  display_hint("offhand_green_beam_detailed", undefined, undefined, level, "green_beam_target");
}

function function_af2638cad53362cd() {
  display_hint("offhand_green_beam_simple", undefined, undefined, level, "green_beam_target");
}

function function_f1a7576aabf68ac2() {
  display_hint("offhand_green_beam_aim", undefined, undefined, level.player, "green_beam_offhand_raised");
  level.player waittill("green_beam_offhand_raised");
  wait 0.6;
  display_hint("offhand_green_beam_fire", undefined, undefined, level, "green_beam_target");
}