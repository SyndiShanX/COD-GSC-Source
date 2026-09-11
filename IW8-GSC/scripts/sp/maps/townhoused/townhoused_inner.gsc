/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\townhoused\townhoused_inner.gsc
***********************************************************/

function backyard_intro() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  scripts\engine\utility::flag_init("skip_intro");
  scripts\engine\utility::flag_init("intro_anim_started");
  hidecinematicletterboxing(0, 0);
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\player::focusdisable();
  level.player setclienttriggeraudiozone("th_intro_bink_only_dx", 0.01);
  level.player setcinematicmotionoverride("disabled");
  var0 = getspawner("kyle", "targetname");
  var1 = scripts\engine\sp\utility::dronespawn_bodyonly(var0);
  var1.animname = "kyle";
  give_kyle_weapon(var1);
  level.kyle = var1;
  hidecinematicletterboxing(0, 0);
  level.cutters = scripts\engine\sp\utility::spawn_anim_model("bolt_cutters");
  level.gatelock = scripts\engine\sp\utility::spawn_anim_model("gate_lock");
  var2 = getEnt("intro_alley_gate", "targetname");
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var3 = level.squads["bravo2"];
  var3 = scripts\engine\utility::array_add(var3, level.price);
  scripts\engine\utility::array_thread(var3, &scripts\engine\sp\utility::name_hide);
  level.player_rig.customnotetrackhandler = &camera_handle_notetracks;
  var4 = [level.player_rig, var2, level.cutters];
  var4 = scripts\engine\utility::array_add(var4, var1);
  var5 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  level.player playerlinktoabsolute(level.player_rig, "tag_player");
  scripts\sp\maps\townhoused\townhoused_code::player_cam_enable(1);
  level.player modifybasefov(32, 0.05);
  level.player lerpfovscalefactor(0, 0);
  var5 thread scripts\common\anim::anim_first_frame_solo(level.gatelock, "backyard_intro_cut_gate");
  scripts\engine\utility::array_call(var3, &invisiblenotsolid);
  scripts\engine\utility::array_call(var4, &hide);
  var5 thread scripts\common\anim::anim_first_frame(var3, "backyard_intro");
  var5 thread scripts\common\anim::anim_first_frame(var4, "backyard_intro");
  wait 0.2;
  scripts\engine\utility::flag_init("intro_sound_delay_done");
  var6 = scripts\engine\utility::array_combine(var3, var4);
  thread skip_intro(var6);
  level.player playSound("dx_vom_pri_backyard_alleyway_10");
  wait 0.5;
  level.player setclienttriggeraudiozone("th_backyard_intro_approach", 0.5);
  wait 1.5;
  scripts\engine\utility::flag_set("intro_sound_delay_done");

  if(!scripts\engine\utility::flag("skip_intro")) {
    thread intro_end();
  }

  var5 thread scripts\common\anim::anim_single_solo(level.gatelock, "backyard_intro_cut_gate");
  scripts\engine\utility::array_call(var3, &visiblesolid);

  foreach(var8 in var4) {
    if(var8 == level.player_rig) {
      continue;
    }

    var8 show();
    LOC_0000025e:
  }

  if(!scripts\engine\utility::flag("skip_intro")) {
    scripts\engine\utility::flag_set("intro_anim_started");
    scripts\engine\utility::array_thread(var3, &backyard_intro_anim, var5);
    var4 = scripts\engine\utility::array_removeundefined(var4);
    var5 scripts\common\anim::anim_single(var4, "backyard_intro");
  }

  scripts\sp\utility::userskip_stop();
  level notify("intro_done");

  if(!istrue(level.demo)) {
    scripts\engine\utility::array_thread(var3, &scripts\engine\sp\utility::name_show);
  }

  level.player_rig.customnotetrackhandler = undefined;
  level.cutters delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function skip_intro(var0) {
  var1 = scripts\sp\utility::userskip_wait();

  if(!var1) {
    return;
  }

  scripts\engine\utility::flag_set("skip_intro");
  scripts\sp\hud_util::fade_out(0);

  if(!scripts\engine\utility::flag("intro_anim_started")) {
    var2 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");

    foreach(var4 in var0) {
      if(isai(var4)) {
        thread backyard_intro_anim(var4);
        continue;
      }

      var2 thread scripts\common\anim::anim_single_solo(var4, "backyard_intro");
    }

    waitframe();
  }

  var6 = "backyard_intro";
  var7 = 1.1;

  foreach(var4 in var0) {
    if(!scripts\engine\utility::flag("intro_sound_delay_done")) {
      level.player setclienttriggeraudiozone("th_backyard_intro_approach", 0.5);

      if(isai(var4)) {
        var4 visiblesolid();
      }
    }

    var9 = getanimlength(var4 scripts\engine\utility::getanim(var6));
    var10 = (var9 - var7) / var9;
    var4 setanimtime(var4 scripts\engine\utility::getanim(var6), var10);
    LOC_00000102:
  }

  if(isDefined(level.gatelock)) {
    level.gatelock delete();
  }

  scripts\engine\utility::delaythread(0.05, &scripts\sp\hud_util::fade_in, 0.05);

  if(isDefined(level.kyle)) {
    level.kyle delete();
  }

  intro_end(1);
}

function backyard_intro_anim(var0) {
  var0 scripts\common\anim::anim_single_solo(self, "backyard_intro");
  thread backyard_alley_move_solo();
}

function give_kyle_weapon() {
  var0 = scripts\sp\maps\townhoused\townhoused_code::get_player_weapons();

  foreach(var2 in self.fake_weapon_models) {
    self detach(var2);
  }

  var4 = getweaponattachmentworldmodels(var0[0]);

  foreach(var2 in var4) {
    self attach(var2);
  }
}

function camera_handle_notetracks(var0, var1, var2) {
  var3 = 32;
  var4 = level.scr_anim[self.animname]["backyard_intro"];

  if(var0 == "fovstart") {
    return;
  }

  if(var0 == "fovlerp_begin") {
    var5 = self getanimtime(var4);
    var6 = getnotetracktimes(var4, "fovlerp_end");
    var7 = getanimlength(var4);
    var8 = var7 * (var6[0] - var5);
    level.player modifybasefov(65, var8);
    return;
  }

  if(var0 == "swap_player") {
    level.cutters show();
    level.player_rig show();
    level.kyle delete();
    scripts\sp\maps\townhoused\townhoused_code::player_cam_enable(0);
    return;
  }
}

function intro_end(var0) {
  level notify("stop_intro_end");
  level endon("stop_intro_end");
  var1 = 1;

  if(!istrue(var0)) {
    var2 = getanimlength(scripts\engine\utility::getanim("backyard_intro"));
    var3 = var2 - var1;
    level.player scripts\engine\utility::delaycall(var3 - var1, &lerpfovscalefactor, 1, var1);
    thread intro_letterbox_removal(level);
    wait var3;
    scripts\sp\utility::userskip_stop();
  } else {
    level.player modifybasefov(65, 0.05);
    level.player lerpfovscalefactor(1, var1);
    thread intro_letterbox_removal(level);
  }

  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  thread restore_player_demeanor();
  level.player clearcinematicmotionoverride();
  setomnvar("ui_hide_hud", 0);
  scripts\sp\maps\townhoused\townhoused_code::setup_player("backyard");
  wait var1;
  level.player unlink();
  level.player_rig hide();
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  scripts\engine\utility::delaythread(2, &scripts\sp\maps\townhoused\townhoused_code::set_objective, "townhouse_entry");
  level.player scripts\engine\utility::delaythread(2, &scripts\sp\player::focusenable);
}

function intro_letterbox_removal(var0) {
  var1 = 2.5;

  if(var0 > 0) {
    var2 = var0 - var1;
    wait var2;
  }

  getrandomnodedestination(var1);
}

function player_intro_speed_lerp() {
  var0 = 5;
  var1 = 1;
  var2 = var1 / var0;
  var3 = length(level.player.intro_velocity);
  var4 = anglesToForward(level.player.angles) * var3;
  level.player.intro_velocity = undefined;

  for(var5 = 0; var5 < var0; var5++) {
    waitframe();
    var1 -= var2;
    var1 = max(var1, 0);
    level.player pushplayervector(var4 * var1);
  }

  level.player pushplayervector(var4 * 0);
}

function player_intro_speed() {
  level.player.intro_velocity = 0;
  var0 = level.player_rig.origin;

  while(isDefined(level.player.intro_velocity)) {
    var1 = level.player_rig.origin - var0;
    level.player.intro_velocity = vectorNormalize(var1) * length(var1) * 20;
    var0 = level.player_rig.origin;
    waitframe();
  }
}

function restore_player_demeanor() {
  thread backyard_player_safe_demeanor_thread();
  scripts\engine\utility::flag_wait("player_in_backyard");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
}

function backyard_player_safe_demeanor_thread() {
  var0 = 0;
  jumpiftrue(isplatformps4()) LOC_0000000b;
  return;
}

function postspawn_backyard_alley_extra() {
  scripts\sp\maps\townhoused\townhoused_code::postpawn_friendly_shared();
  scripts\engine\utility::flag_wait("backyard_alley_extra_move");
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");

  if(self.animname == "bravo2_4") {
    self.animloop_headlook = 1;
  }

  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "backyard_alley_move", undefined, "stop_loop_" + self.animname);
}

function backyard_alley_move_solo() {
  if(!isDefined(level.backyard_ally_counter)) {
    level.backyard_ally_counter = 0;
  }

  level.backyard_ally_counter++;
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  thread backyard_alley_move_thread();
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "backyard_alley_move", undefined, "stop_backyard_alley_loop");
}

function backyard_alley_move_thread() {
  self waittillmatch("single anim", "end");
  level.backyard_ally_counter--;

  if(level.backyard_ally_counter == 0) {
    scripts\engine\utility::flag_set("backyard_alley_ready");
    return;
  }
}

function backyard_door_setup() {
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var1 = getEnt("backyard_door", "targetname");
  add_linkedents(var1);
}

function backyard_door_open() {
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var1 = getEnt("backyard_door", "targetname");
  var1.linkedents[0] connectpaths();
  thread backyard_door_open_rotate();
  var2 = scripts\engine\sp\utility::get_living_ai("bravo2_3", "animname");
  var0 notify("stop_loop_bravo2_3");
  var2.animloop_headlook = 1;
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var2, "backyard_open_gate", undefined, "stop_loop_bravo2_3");
}

function backyard_door_open_rotate() {
  var0 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var0);
  wait 2.7;
  var1 = 0.7;
  var0 rotateYaw(-40, var1, 0, var1 * 0.5);
  var2 = 0.5;
  var0 scripts\engine\utility::delaycall(var1 - 0.05, &rotateyaw, -10, var2, var2 * 0.5, var2 * 0.5);
}

function backyard_move() {
  thread backyard_backup_move();
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var0 notify("stop_backyard_alley_loop");
  var1 = scripts\engine\utility::array_add(level.squads["bravo2"], level.price);
  level.backyard_move_counter = var1.size - 1;
  scripts\engine\utility::array_thread(var1, &backyard_move_thread);
  scripts\engine\utility::flag_wait("backyard_basement_ready");
  scripts\engine\utility::flag_wait("player_near_kitchen");
  backdoor_freeze();
}

function backyard_move_thread(var0) {
  self endon("stop_backyard_move_thread");
  var1 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var2 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  thread backyard_move_rate_thread();
  var1 scripts\common\anim::anim_single_solo(self, "backyard_move");
  self notify("stop_backyard_move_rate");
  var3 = "stop_backyard_move_loop";

  if(self.animname == "bravo2_2") {
    var0 = 1;
    var1 thread scripts\sp\maps\townhoused\townhoused_code::lookat_random_animloop_ender(self, "stop_backyard_move_loop");
  } else if(self.animname == "bravo2_4") {
    var3 = "stop_backyard_move_loop_bravo2_4";
    var1 = var2;
  } else {
    var2 endon("stop_backyard_move_loop");
    var1 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  }

  var1 thread scripts\common\anim::anim_loop_solo(self, "backyard_move_idle", var3);

  if(isDefined(var0)) {
    return;
  }

  level.backyard_move_counter--;

  if(level.backyard_move_counter == 0) {
    scripts\engine\utility::flag_set("backyard_basement_ready");
    return;
  }
}

function backyard_move_rate_thread() {
  self endon("stop_backyard_move_rate");
  var0 = scripts\engine\utility::getanim("backyard_move");
  waitframe();
  scripts\engine\utility::flag_wait("player_near_kitchen");

  if(self getanimtime(var0) < 0.75) {
    self setanimrate(var0, 1.5);

    while(self getanimtime(var0) < 0.95) {
      if(scripts\engine\utility::flag("player_deploying_kitchen_ladder")) {
        break;
      }

      waitframe();
    }

    if(!scripts\engine\utility::flag("player_deploying_kitchen_ladder")) {
      self setanimrate(var0, 1);
    }
  }

  if(scripts\engine\utility::flag("player_deploying_kitchen_ladder")) {
    self setanimrate(var0, 8);
    return;
  }
}

function backdoor_freeze() {
  var0 = scripts\engine\sp\utility::get_living_ai("bravo2_1", "animname");
  var1 = [level.price, var0];
  level.backyard_freeze_counter = var1.size;
  scripts\engine\utility::array_thread(var1, &backdoor_freeze_thread);
  thread backdoor_entry(var1);
}

function backdoor_freeze_thread() {
  var0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var0 notify("stop_backyard_move_loop");
  var0 endon("stop_basement_freeze_loop");
  thread backdoor_freeze_rate_thread();
  var0 scripts\common\anim::anim_single_solo(self, "backdoor_freeze");
  self notify("stop_backdoor_freeze_rate");

  if(level.price == self) {
    scripts\engine\utility::flag_set("basement_freeze_ready");
  }

  if(self == level.price) {
    var0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_freeze_idle", "stop_basement_freeze_price_loop");
    thread backdoor_freeze_nag(var0);
    return;
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_freeze_idle", "stop_basement_freeze_loop");
}

function backdoor_freeze_rate_thread() {
  self endon("stop_backdoor_freeze_rate");
  var0 = scripts\engine\utility::getanim("backdoor_freeze");
  waitframe();
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  self setanimrate(var0, 2);
}

function backdoor_freeze_nag(var0) {
  var0 endon("stop_basement_freeze_loop");
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "dx_vom_pri_kitchen_window_30");
}

function backdoor_entry(var0) {
  scripts\engine\utility::flag_wait("basement_freeze_ready");
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  var1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  var0 = scripts\engine\utility::array_add(var0, var1);
  scripts\engine\utility::array_thread(var0, &backdoor_entry_thread);
}

function backdoor_entry_thread() {
  scripts\engine\utility::flag_set("backdoor_enter");
  var0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var0 notify("stop_basement_freeze_loop");
  var0 notify("stop_basement_freeze_price_loop");
  var0 notify("stop_loop");
  var0 notify("stop_backyard_move_loop");
  var0 notify("stop_backyard_move_loop_bravo2_4");

  if(self == level.price) {
    thread basement_door_enter();
  }

  if(self.animname != "bravo2_4") {
    thread backdoor_enter_hurry(var0);
  }

  var0 scripts\common\anim::anim_single_solo(self, "backdoor_enter");

  if(self.animname == "bravo2_4") {
    self notify("stop_backyard_move_thread");
    scripts\engine\sp\utility::anim_stopanimScripted();
    var0 thread scripts\common\anim::anim_loop_solo(self, "backdoor_enter_idle", "stop_basement_lastguy_loop");
    thread backdoor_lastguy_nag();
    return;
  }

  self.goalradius = 48;
  var1 = undefined;

  if(self.animname == "bravo2_1") {
    var1 = scripts\engine\utility::getStruct("basement_entry_bravo2_1", "targetname");
  } else if(self == level.price) {
    var1 = scripts\engine\utility::getStruct("basement_entry_price", "targetname");
  }

  if(isDefined(var1)) {
    var2 = var1.origin;
  } else {
    var2 = self.origin;
  }

  self setgoalpos(var2);
  self waittill("goal");
  backdoor_enter_done();
}

function backdoor_enter_done() {
  if(!isDefined(level.backdoor_enter_count)) {
    level.backdoor_enter_count = 0;
  }

  level.backdoor_enter_count++;

  if(level.backdoor_enter_count == 2) {
    scripts\engine\utility::flag_set("backdoor_enter_done");
    return;
  }
}

function backdoor_enter_hurry(var0) {
  var0 endon("backdoor_enter");
  var1 = scripts\engine\utility::getanim("backdoor_enter");
  var2 = getEnt("backdoor", "targetname");
  var3 = var2 scripts\engine\utility::getanim("backdoor_enter");
  var4 = 0;

  for(;;) {
    if(!var4 && level.player isonladder()) {
      var4 = 1;
      self setanimrate(var1, 2);
      var2 setanimrate(var3, 2);
    } else if(var4) {
      var4 = 0;
      self setanimrate(var1, 1);
      var2 setanimrate(var3, 1);
    }

    waitframe();
  }
}

function backdoor_lastguy_nag() {
  level endon("player_top_of_ladder");

  if(scripts\engine\utility::flag("player_top_of_ladder")) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_a12_kitchen_window_70");
}

function basement_door_enter() {
  var0 = scripts\engine\utility::getStruct("backdoor_animnode", "targetname");
  var1 = getEnt("backdoor", "targetname");
  var1.linkedents[0] = getEnt(var1.target, "targetname");
  var1.linkedents[0] linkTo(var1);
  var1 scripts\engine\sp\utility::assign_animtree("door");
  var0 scripts\common\anim::anim_single_solo(var1, "backdoor_enter");
}

function backyard_backup_move() {
  scripts\engine\utility::flag_wait("player_in_mid_backyard");
  var0 = scripts\engine\utility::getStruct("backyard_door_animnode", "targetname");
  var0 notify("stop_loop_bravo2_3");
  var0 notify("stop_loop_bravo2_4");
  var1 = scripts\engine\sp\utility::get_living_ai("bravo2_4", "animname");
  thread backyard_move_thread(var1);
  var2 = scripts\engine\sp\utility::get_living_ai("bravo2_3", "animname");
  scripts\engine\utility::flag_set("backyard_playerclip");
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var2, "backyard_move");
}

function backyard_freeze_townhouse(var0) {
  self endon("death");
  self.goalradius = 32;
  self waittill("goal");
  self.goalradius = 4;
  scripts\engine\utility::set_movement_speed(10);
  scripts\common\ai::set_gunpose("ads");
  var1 = create_backyard_aimpath();
  scripts\sp\maps\townhoused\townhoused_code::enable_laser(1);
  var2 = var1[0][0];
  var3 = create_aiment(var2.origin);
  var0.rightdir = anglestoright(var0.angles);
  var4 = 0;

  for(;;) {
    wait randomfloatrange(2, 4);
    var5 = var1[var4];
    var5 = scripts\engine\utility::array_randomize(var5);
    var6 = 1;

    if(isDefined(self.script_count_min)) {
      var6 = randomintrange(self.script_count_min, self.script_count_max);
    }

    for(var7 = 0; var7 < var6; var7++) {
      foreach(var9 in var5) {
        var10 = 5;

        if(isDefined(self.radius)) {
          var10 = self.radius;
        }

        var11 = var9.origin + anglestoright(var9.angles) * randomfloatrange(var10 * -1, var10);
        var12 = randomfloatrange(0.5, 1);
        var3 moveTo(var11, var12, var12 * 0.5, var12 * 0.5);
        var3 waittill("movedone");

        if(randomint(100) > 30) {
          backyard_free_move(var0);
        }

        wait randomfloatrange(1, 2);
      }
    }

    if(randomint(100) > 30) {
      backyard_free_move(var0);
    }

    var4++;

    if(var4 > var1.size - 2) {
      var4 = 0;
    }

    waitframe();
  }
}

function backyard_fail_thread() {
  var0 = getEnt("townhouse_damage_trigger", "targetname");
  thread backyard_fail_damage_thread();

  while(!scripts\engine\utility::flag("player_in_kitchen")) {
    if(scripts\engine\utility::flag("player_is_outside")) {
      var1 = getEntArray("grenade", "classname");

      if(var1.size > 0) {
        foreach(var3 in var1) {
          if(!isDefined(var3.fail)) {
            var3.fail = 1;
            thread backyard_fail_onexplode();
          }
        }
      }
    }

    waitframe();
  }

  var0 delete();
}

function backyard_fail_onexplode() {
  self waittill("explode");
  backyard_force_fail();
}

function backyard_fail_damage_thread() {
  self endon("death");
  self waittill("trigger");
  backyard_force_fail();
}

function backyard_force_fail() {
  var0 = ["dx_vom_pri_backyard_misfire_10", "dx_vom_pri_backyard_misfire_20", "dx_vom_pri_backyard_misfire_30"];
  level.price thread scripts\engine\sp\utility::smart_dialogue(scripts\engine\utility::random(var0));
  scripts\sp\player_death::set_custom_death_quote(13);
  scripts\sp\utility::missionfailedwrapper();
}

function backyard_free_move(var0) {
  var1 = 0;
  var2 = 10;

  for(;;) {
    var3 = randomfloatrange(-30, 30);
    var4 = var0.origin + var0.rightdir * var3;
    var5 = distancesquared(var4, self.origin);

    if(var5 > 10) {
      break;
    }

    var1++;

    if(var1 == 10) {
      var1 = 0;
      waitframe();
    }
  }

  self setgoalpos(var4);
}

function create_backyard_aimpath() {
  var0 = scripts\engine\utility::getStruct("townhouse_window_aimpath", "targetname");
  GscBinSkip1(0x45, 0, [var0]);
}

function ambient_garage_welding() {
  var0 = getEnt("garage_welding_light", "targetname");
  var0.og_intensity = var0 getlightintensity();
  var0 setlightintensity(0);
  var1 = [];
  GscBinSkip0(0x2e, 0, add_welding_alias("emt_amb_weld_short", 0, -2));
}

function add_welding_alias(var0, var1, var2) {
  var3 = spawnStruct();
  var3.alias = var0;
  var3.flickerdelay = var1;
  var3.flickerendtime = var2;
  return var3;
}

function ambient_garage_welding_light(var0) {
  wait var0.flickerdelay;
  var1 = randomfloatrange(0.8, 1.1);
  var2 = gettime() + lookupsoundlength(var0.alias) + var0.flickerendtime * 1000;

  while(gettime() < var2) {
    self setlightintensity(var1 + randomfloatrange(-0.8, 0.5));
    wait randomfloat(0.2);
  }

  self setlightintensity(0);
}

function kitchen_sequence() {
  thread kitchen_dialogue();
  scripts\engine\utility::flag_wait("player_deploying_kitchen_ladder");
  setglobalsoundcontext("climb", "ladder", 0.1);
  thread dining_dialogue_from_kitchen();
  thread lerp_playerspeed_fov_on_ladder();
  thread player_on_ladder_flag();
  var0 = getEnt("top_backyard_ladder", "targetname");

  for(;;) {
    var0 waittill("trigger");
  }

  LOC_0000006c:
    scripts\engine\utility::flag_set("player_top_of_ladder");
  thread kitchen_mantle_thread();
  thread kitchen_player_top_of_ladder_failsafe();
  scripts\engine\utility::flag_wait_either("backdoor_enter_done", "top_of_ladder_failsafe");
  thread kitchen_takedown();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  interior_price_settings();
  level.price waittillmatch("single anim", "end");
  level.price setgoalpos(level.price.origin);
  thread scripts\engine\utility::flag_set_delayed("player_exiting_kitchen", 15);
  scripts\engine\utility::flag_wait("player_exiting_kitchen");
  var1 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var1 notify("stop_loop_price");
  thread stairtrain1_setup();
}

function kitchen_player_clip() {
  scripts\engine\utility::flag_wait("kitchen_takedown_fastforward");
  wait 2;
  var0 = getEnt("kitchen_player_clip", "targetname");
  var0 delete();
}

function kitchen_player_top_of_ladder_failsafe() {
  level endon("backdoor_enter_done");
  var0 = getEnt("top_backyard_ladder_failsafe", "targetname");
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("top_of_ladder_failsafe");
}

function kitchen_player_deployed_ladder() {
  var0 = get_ladder_struct("kitchen_ladder", "script_noteworthy");
  var0.hint waittill("trigger");
  scripts\engine\utility::flag_set("player_deploying_kitchen_ladder");
}

function kitchen_dialogue() {
  scripts\engine\utility::flag_wait("player_near_kitchen");
  level.player waittill("deploying_ladder");
}

function player_on_ladder_flag() {
  while(!level.player isonladder()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("player_on_ladder");
  level.player playSound("thd_vm_tactical_ladder_mount_plr");
}

function interior_price_settings() {
  level.price.ignoreme = 1;
  level.price.ignoreall = 1;
  level.price.script_forcegoal = 1;
  level.price.goalradius = 32;
  level.price.uprightcqbidle = 1;
}

function kitchen_takedown() {
  var0 = scripts\engine\utility::getStruct("price_bravo3_kitchen", "targetname");
  var1 = scripts\sp\maps\townhoused\townhoused_code::get_closest_squad_guy("bravo2", var0.origin);
  var1 forceteleport(var0.origin, var0.angles);
  var2 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var1.animname = "bravo3";
  var2 thread scripts\sp\anim::anim_reach_solo(var1, "kitchen_takedown");
  var3 = 0;
  var4 = var1.origin;
  var5 = scripts\engine\sp\utility::spawn_targetname("hallway_girl", 1);
  var5.team = "neutral";
  var5 scripts\common\ai::gun_remove();
  var5.allowdeath = 1;
  var5.skipdeathanim = 1;
  var5.deathfunction = &kitchen_girl_death;
  var5.ally = var1;
  var5.nofacialfiller = 1;
  var5 scripts\engine\sp\utility::set_deathanim("kitchen_takedown_death_stand");
  var1.kitchen_react = "kitchen_takedown_death_stand";
  thread kitchen_girl_death_dialogue(level);
  thread kitchen_takedown_girl(var5);
  level thread scripts\sp\maps\townhoused\townhoused_anim::stow_halligan(level.price);
  level.price scripts\anim\shared::placeweaponon(level.price.weapon, "right");
  thread kitchen_takedown_door();
  thread kitchen_bravo_death_react(var1, var2);
  var1.animloop_headlook = 1;
  thread kitchen_bravo_combat_thread(var1);
  var2 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var1, "kitchen_takedown", undefined, "stop_kitchen_takedown_bravo");
  thread dining_room_animrate_adjust(level.price, var2);
  var2 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(level.price, "kitchen_takedown", undefined, "stop_loop_price");
  var1 setgoalpos(var1.origin);
  scripts\engine\utility::flag_set("kitchen_done");
  setglobalsoundcontext("climb", "", 0.5);
}

function kitchen_bravo_combat_thread(var0) {
  waitframe();
  self waittill("killanimscript");

  for(;;) {
    self waittill("bulletwhizby", var1);

    if(isDefined(var1) && var1 == level.player) {
      continue;
    }

    break;
  }

  self.combatmode = "ambush";
  var0 notify("stop_kitchen_takedown_bravo");
  var2 = getnode("kitchen_covernode", "targetname");
  self setgoalnode(var2);
  self.goalradius = 32;
  self.usingnode = 1;
  scripts\engine\utility::set_movement_speed(60);
  scripts\engine\sp\utility::anim_stopanimScripted();
}

function kitchen_takedown_girl(var0) {
  var0 endon("death");
  var1 = scripts\engine\sp\utility::spawn_anim_model("cuffs");
  var0.cuffs = var1;
  var2 = [var1, var0];
  var3 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var3 scripts\common\anim::anim_single(var2, "kitchen_takedown");
  var2 = scripts\engine\utility::array_removeundefined(var2);
  var3 thread scripts\common\anim::anim_loop(var2, "kitchen_takedown_loop", "stop_kitchen_takedown_girl");
}

function kitchen_takedown_door() {
  var0 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var0.open_struct scripts\sp\door::remove_open_interact_hint();
  var1 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var1 scripts\sp\maps\townhoused\townhoused_code::anim_door(var0, "kitchen_takedown");
  var0.open_completely = 1;
  scripts\engine\utility::flag_set("kitchen_girl_secured");
}

function kitchen_bravo_death_react(var0, var1) {
  if(!isalive(var1)) {
    return;
  }

  var1 waittill("death");
  var0 notify("stop_kitchen_takedown_girl");

  if(isDefined(self.no_react)) {
    return;
  }

  if(self.kitchen_react == "kitchen_takedown_death_stand") {
    var0 notify("stop_kitchen_takedown_bravo");
    var0 = self;

    if(isDefined(var1.cuffs)) {
      var1.cuffs delete();
    }
  } else if(self.kitchen_react == "kitchen_takedown_death_hold") {
    if(isDefined(var1.cuffs)) {
      var1.cuffs delete();
    }
  }

  if(istrue(self.usingnode)) {
    return;
  }

  if(self.kitchen_react == "kitchen_takedown_death_laying") {
    var0 scripts\common\anim::anim_single_solo(self, self.kitchen_react);
    return;
  }

  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, self.kitchen_react);
}

function kitchen_girl_death() {
  var0 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");

  if(isDefined(self.deathanim)) {
    return 0;
  }

  if(self.kitchen_death_anime == "kitchen_takedown_death_stand") {
    var0 = self;
  }

  if(self.kitchen_death_anime == "kitchen_takedown_death_laying") {
    if(isDefined(self.cuffs)) {
      self.cuffs delete();
    }
  }

  scripts\sp\maps\townhoused\townhoused_code::scripted_deathanim(self.kitchen_death_anime, var0);
}

function kitchen_girl_death_dialogue(var0) {
  var0 waittill("death", var1);
  scripts\engine\utility::flag_set("kitchen_girl_secured");

  if(!isPlayer(var1)) {
    return;
  }

  var2 = scripts\engine\sp\utility::get_living_ai("bravo3", "animname");
  wait 0.2;
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_kitchen_entry_40");
  wait 0.3;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_kitchen_entry_50");
}

function get_ladder_struct(var0, var1) {
  var2 = scripts\engine\utility::getStructArray(var0, var1);

  foreach(var4 in var2) {
    if(var4.targetname == "deployable_ladder") {
      return var4;
    }
  }
}

function lerp_playerspeed_fov_on_ladder() {
  var0 = scripts\engine\utility::getStruct("ladder_lerp", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = 0;
  var3 = 0.846154;
  var4 = 0.666;
  var5 = 1;
  var6 = distance(var0.origin, var1.origin);
  var7 = 0;

  for(;;) {
    var8 = pointonsegmentnearesttopoint(var0.origin, var1.origin, level.player.origin);
    var9 = distance(var8, var0.origin);
    var10 = var9 / var6;

    if(var10 > var7) {
      var7 = var10;
      var11 = scripts\engine\math::factor_value(65, 55, var10);
      level.player modifybasefov(var11, 0.2);
    }

    if(level.player isonladder()) {
      if(!var2) {
        thread scripts\engine\sp\utility::lerp_saveddvar("LOMLPPTKO", 20, 3);
        scripts\sp\maps\townhoused\townhoused_lighting::player_onkitchenladder();
        level.player scripts\engine\sp\utility::player_speed_set(40, 0.5);
        var2 = 1;
      }

      level.player scripts\engine\sp\utility::blend_movespeedscale(1);
    } else {
      if(var2) {
        setsaveddvar("LOMLPPTKO", 85);
        scripts\sp\maps\townhoused\townhoused_lighting::player_offkitchenladder();
        scripts\sp\player::player_movement_state("creep");
        var2 = 0;
      }

      var12 = scripts\engine\math::factor_value(var5, var4, var10);
      level.player scripts\engine\sp\utility::blend_movespeedscale(var12);
    }

    if(var10 == 1) {
      break;
    }

    waitframe();
  }

  level.player modifybasefov(55, 0.2);
  scripts\sp\player::player_movement_state("creep");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.666);
  setsaveddvar("LOMLPPTKO", 85);
}

function kitchen_mantle_thread() {
  var0 = getEnt("kitchen_mantle", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  var3 = "window_mantle";
  var4 = getmovedelta(level.player_rig scripts\engine\utility::getanim(var3), 0, 1);
  var5 = cos(45);
  var6 = anglesToForward(var1.angles);
  var7 = 1;

  for(;;) {
    var0 waittill("trigger");

    while(level.player istouching(var0)) {
      var8 = anglesToForward(level.player.angles);
      var9 = vectordot(var6, var8);
      var10 = 1;

      if(var9 < var5) {
        var10 = 0;
      }

      if(!istrue(level.player_on_ladder_hack) && var10 && !is_player_moving_forward()) {
        var10 = 0;
      }

      if(var10) {
        var11 = spawnStruct();
        var11.origin = pointonsegmentnearesttopoint(var1.origin, var2.origin, level.player.origin);
        var11.angles = (0, level.player.angles[1], 0);
        var11 scripts\common\anim::anim_first_frame_solo(level.player_rig, var3);
        var12 = level.player_rig gettagorigin("tag_player");
        var13 = level.player_rig gettagangles("tag_player");
        level.player.groundrefent = scripts\engine\utility::spawn_tag_origin(var12, var13);
        level.player.groundrefent linkTo(level.player_rig, "tag_camera", (0, 0, 0), (0, 0, 0));
        level.player setstance("stand");
        level.player_rig hide();
        var11.origin -= (0, 0, 60);
        var11 thread scripts\common\anim::anim_single_solo(level.player_rig, var3);
        level.player disableweapons();
        level.player lerpviewangleclamp(0, 0, 0, 180, 180, 180, 180, 1);
        level.player playerlinktoblend(level.player_rig, "tag_player", 0.4, 0.2, 0.2);
        wait 0.4;
        level.player_rig show();
        level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
        level.player lerpviewangleclamp(0.2, 0, 1, 20, 20, 20, 20);
        level.player springcamenabled(0, 5, 5);
        var11 waittill(var3);
        level.player_rig hide();
        level.player enableweapons();
        level.player springcamdisabled(0);
        level.player unlink();
        level.player playersetgroundreferenceent(undefined);
        level.player.groundrefent delete();
        var11 = undefined;
      }

      wait 0.05;
    }
  }
}

function is_player_moving_forward() {
  var0 = level.player getnormalizedmovement();
  return var0[0] > 0;
}

function dining_dialogue_from_kitchen() {
  scripts\engine\utility::flag_wait("player_near_kitchen");
  var0 = scripts\engine\utility::getStruct("dining_fakesound1", "targetname");
  var1 = scripts\engine\utility::spawn_script_origin(var0.origin);
  var0 = scripts\engine\utility::getStruct("dining_fakesound2", "targetname");
  var2 = scripts\engine\utility::spawn_script_origin(var0.origin);
  level.player setsoundsubmix("sp_th_python_scream");
  scripts\engine\utility::flag_wait("player_top_of_ladder");
  playsound_wait(var2, "dx_vom_aq1_kitchen_aq_convo1_10");
  wait 0.8;
  playsound_wait(var1, "dx_vom_aqf1_kitchen_aq_convo1_20");
  playsound_wait(var2, "dx_vom_aq1_kitchen_aq_convo1_30");
  wait 3.2;
  scripts\engine\utility::flag_set("kitchen_intro_vo_done");
  var1 delete();
  var2 delete();
}

function playsound_wait(var0) {
  self playSound(var0, "sounddone");
  self waittill("sounddone");
}

function postspawn_dining_enemy() {
  if(!isDefined(level.dining_enemies)) {
    level.dining_enemies = [];
  }

  thread dining_death_vo();
  thread dining_long_death_vo();
  level.dining_enemies = scripts\engine\utility::array_add(level.dining_enemies, self);
  scripts\sp\anim::anim_react_add_to_alertgroup("dining");
  self.headlook_enabled = 0;
  var0 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  scripts\engine\sp\utility::disable_surprise();

  if(self.animname == "dining_enemy3") {
    var1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "mag_akilo47|1", "ironsdefault_akilo47"]);
    scripts\anim\shared::forceuseweapon(var1, "primary");
    scripts\engine\utility::delaythread(0.1, &scripts\sp\anim::primaryweapon_leave_behind, "tag_weapon_right", 1);
  } else {
    if(self.animname == "dining_enemy1") {
      var1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "front_akilo47", "mag_akilo47|1", "ironsdefault_akilo47", "stockno_akilo47"]);
    } else {
      var1 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["rec_akilo47", "back_akilo47", "front_akilo47", "mag_akilo47", "ironsdefault_akilo47"]);
    }

    scripts\anim\shared::forceuseweapon(var1, "primary");
    scripts\engine\utility::delaythread(0.1, &scripts\sp\anim::primaryweapon_leave_behind, "tag_weapon_right");
  }

  if(self.animname == "dining_enemy1") {
    dining_room_chair_init();
    self.disabledeathdirectionalorient = 1;
    self.anim_react_skip_stopanimscripted = 1;
    thread dining_react_flagwait(var1, self, "dining");
  } else if(self.animname == "dining_enemy2") {
    thread dining_react_flagwait(var1, self, "dining");
    self.disabledeathdirectionalorient = 1;
  } else {
    self attach(scripts\engine\sp\utility::getmodel("cellphone_on"), "tag_accessory_left");
    thread dining_react_flagwait(var1, self, "dining");
  }

  thread dining_death_counter(1);

  if(level.dining_enemies.size == 3) {
    thread dining_dialogue();
    thread dining_price_dialogue();
    thread dining_room_foyer_trigger();
    var2 = getEnt("dining_room_damage_trigger", "targetname");
    thread dining_trigger_damage_thread();
    var2 = getEnt("outer_dining_room_damage_trigger", "targetname");
    thread dining_trigger_damage_thread(var2);
    return;
  }
}

function dining_room_chair_init() {
  var0 = getEnt("dining_room_chair", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("chair");
  thread dining_room_chair_anim_end();
  var0.clip = getEnt("dining_room_chair_clip", "targetname");
  var0.clip linkTo(var0);
  var1 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var1 thread scripts\common\anim::anim_first_frame_solo(var0, "dining_react_high");
  self.animents = [var0];
}

function dining_room_chair_anim_end() {
  self waittillmatch("single anim", "end");

  if(self._lastanime == "dining_react_pain") {
    self.clip delete();
    return;
  }

  self.clip disconnectPaths();
}

function dining_room_foyer_trigger() {
  scripts\engine\sp\utility::trigger_wait_targetname("dining_room_foyer");
  var0 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");
  scripts\engine\sp\utility::array_notify(var0, "react");
}

function dining_room_door_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  scripts\engine\utility::flag_set("player_exiting_kitchen");
  self.fndamage = undefined;
  waitframe();
  var10 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");
  scripts\engine\sp\utility::array_notify(var10, "react");
}

function dining_dialogue() {
  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }

  level endon("dining_room_react");
  scripts\engine\utility::flag_wait_all("player_in_kitchen", "kitchen_intro_vo_done");
  wait 0.85;
  var0 = scripts\engine\sp\utility::get_living_ai("dining_enemy1", "animname");
  var1 = scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname");
  var2 = scripts\engine\sp\utility::get_living_ai("dining_enemy3", "animname");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_10");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_20");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_30");
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_40");
  var1 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_50");
  var3 = lookupsoundlength("dx_vom_aq1_dining_room_aq_convo2_50") / 1000;
  wait max(var3 - 0.8, 0);
  var0 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_60");
  var3 = lookupsoundlength("dx_vom_aq3_dining_room_aq_convo2_60") / 1000;
  wait max(var3 - 1, 0);
  thread scripts\engine\utility::flag_set_delayed("dining_room_drop_em_ready", 1);
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_70");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq3_dining_room_aq_convo2_80");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_100");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_110");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_120");
  wait 0.5;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_130");
  var2 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_dining_room_aq_convo2_140");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_150");
  wait 6;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_160");
  wait 4;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_170");
  wait 8;
  thread dining_enemy2_investigate();
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aq_convo2_180");
  wait 1;
  scripts\engine\utility::flag_set("dining_room_dialogue_finished");
}

function dining_enemy2_investigate() {
  var0 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var1 = scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname");
  var1 notify("stop_anim_react");
  var1 endon("death");

  if(var1 scripts\engine\utility::ent_flag_exist("anim_reacted")) {
    var1 scripts\engine\utility::ent_flag_set("anim_reacted");
  }

  var1.a.movement = "stop";
  var0 notify("stop_anim_loop_" + var1.animname);
  var1 scripts\engine\sp\utility::anim_stopanimScripted();
  var1 scripts\engine\sp\utility::place_weapon_on(var1.sidearm, "right");
  var1.dontattackme = 0;
  var1.fnstealthgotonode = undefined;
  var1.goalradius = 60;
  var2 = scripts\engine\utility::getStruct("dining_enemy_search", "targetname");
  var1 setgoalpos(var2.origin);
  thread dining_enemy2_investigate_react();
  var1 waittill("goal");
  var1.dontattackme = 0;
  var3 = scripts\engine\sp\utility::get_living_ai("bravo3", "animname");

  if(!var1 cansee(level.player)) {
    if(isDefined(var3)) {
      var1 aieventlistenerevent("combat", var3, var3.origin);
      var1 getenemyinfo(var3);
    }
  }

  if(isDefined(var3)) {
    var3 notify("bulletwhizby");
  }

  var1.goalradius = 500;
  dining_delete_clip();
}

function dining_enemy2_investigate_react() {
  self endon("death");
  self waittill("enemy");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_50");
}

function dining_price_dialogue() {
  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }

  var0 = getEnt("dining_room_hallwayview", "targetname");
  scripts\engine\utility::flag_wait("dining_room_player_should_engage");

  if(scripts\engine\utility::flag("dining_room_react")) {
    return;
  }

  level endon("dining_room_react");
  var1 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "dx_vom_pri_dining_room_entry_20");
}

function dining_react_flagwait(var0, var1, var2) {
  var0 endon("death");
  scripts\common\anim::anim_first_frame_solo(var0, var1 + "_intro");

  if(level.start_point == "dining_room") {
    level.scr_anim[var0.animname][var1 + "_intro"] = undefined;
  }

  scripts\engine\utility::flag_wait("player_exiting_kitchen");
  thread scripts\sp\anim::anim_react(var0, var1, var2);
}

function dining_room_is_light_dead() {
  var0 = isDefined(self.anim_react_event) && self.anim_react_event.typeorig == "light_killed";

  if(!var0) {
    var1 = getscriptablearray("dining_light", "targetname");
    var2 = var1[0] getscriptablepartstate("onoff");
    var0 = var2 == "death";
  }

  return var0;
}

function dining_light_death() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("dining_light", "targetname");
  var1 = var0[0];

  if(getdvarint("developer") > 0) {
    scripts\engine\sp\utility::scripter_note("turning off other lights");
  }

  var1 waittill("death");
  level.player.lastenemybulletdamagetime = gettime();
  var2 = getEntArray("102_dinning", "script_noteworthy");

  foreach(var4 in var2) {
    var4 setlightintensity(0);
  }
}

function dining_delete_clip() {
  var0 = getEnt("dining_room_conceal_clip", "targetname");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function dining_enemy_react(var0) {
  if(self.health == 1) {
    var0 = "pain";
  }

  if(var0 == "death") {
    return "death";
  }

  self endon("death");
  self endon("stop_dining_enemy_react");
  self.nofacialfiller = 1;
  var1 = dining_room_is_light_dead();

  if(var1) {
    thread dining_nolight_delay();
  } else {
    thread disable_player_sealth();
  }

  if(self.animname == "dining_enemy1") {
    if(istrue(level.demo) && var1) {
      self notify("stop_dining_enemy_react_special");
      self endon("stop_dining_enemy_react_special");

      if(var0 != "pain" || var0 != "death") {
        slow_react_enemy(var0);
        var0 = self.slow_react_type;
        slow_react_stop_animScripted();
      }
    } else {
      var2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
      var2 notify("stop_anim_loop_" + self.animname);
    }
  }

  self notify("stop_anim_react_death");
  scripts\engine\utility::flag_set("dining_room_react");
  self stopsounds();
  dining_delete_clip();
  var2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var3 = "dining_react_high";

  if(var0 == "too_close" || is_footstep_react()) {
    var3 = "dining_react";
  }

  if(var0 == "friend_reacted") {
    if(isDefined(self.anim_react_event)) {
      if(self.anim_react_event.typeorig == "bulletwhizby") {
        var3 = "dining_react_high";
      }
    }
  } else if(var0 == "friend_pained" || var0 == "friend_died") {
    var3 = "dining_react_high";
    var4 = "dx_vom_aq3_dining_room_frontroom_10";
  }

  if(var0 == "pain") {
    if(self.health == 1) {
      thread dining_react_death(var2);
      return "skip_reaction";
    }

    self notify("stop_dining_enemy_damage");
    return var0;
  } else {
    thread dining_react_death(var2, 1);
  }

  thread dining_drop_phone();
  var5 = var3;

  if(var1) {
    var5 = "dining_react_nolight";
    self notify("stop_dining_enemy_damage");
  }

  self.animreactpain = 1;
  thread dinnig_enemy_react_then_pain();
  thread dining_react_dialogue(var5);
  var2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var2 scripts\sp\anim::anim_single_with_props([self], var3);
  self notify("stop_dining_enemy_damage");

  if(var3 == "dining_react_high" && !var1) {
    if(self.animname == "dining_enemy3") {
      thread dining_engage_enemy(64);
    } else {
      thread dining_engage_enemy();
    }
  }

  return "skip_reaction";
}

function dining_drop_phone() {
  self endon("entitydeleted");

  if(self.animname != "dining_enemy3") {
    return;
  }

  wait 0.3;
  var0 = self gettagorigin("tag_accessory_left");
  var1 = self gettagangles("tag_accessory_left");
  waitframe();
  var2 = self gettagorigin("tag_accessory_left");
  self detach(scripts\engine\sp\utility::getmodel("cellphone_on"), "tag_accessory_left");
  var3 = var2 - var0;
  var4 = scripts\engine\sp\utility::spawn_anim_model("cellphone_on", var0, var1);
  var4 physicslaunchserver(var4.origin, var3);
}

function slow_react_enemy(var0) {
  self.slow_react_type = "pain";
  self endon("damage");
  var1 = scripts\engine\utility::getStruct("dining_animnode", "targetname");
  var1 notify("stop_anim_loop_" + self.animname);
  scripts\engine\sp\utility::anim_stopanimScripted();
  var1 thread scripts\common\anim::anim_single_solo(self, "dining_loop_once");
  var2 = self.health;
  self.gunposeoverride_internal = "disable";
  var3 = [];
  GscBinSkip0(0x2e, var3.size, scripts\engine\sp\utility::get_living_ai("dining_enemy2", "animname"));
}

function slow_react_stop_animScripted() {
  scripts\engine\sp\utility::anim_stopanimScripted();
}

function spot_player_dialogue() {
  self endon("death");
  var0 = scripts\engine\utility::waittill_any_ents_return(self, "weapon_fired", level, "player_location_called") != "player_location_called";

  if(var0) {
    thread callout_player_location();
    return;
  }

  level endon("location_callout_response");
  level waittill("finished_location_callout");
  wait randomfloatrange(0, 0.15);
  thread respond_player_location_dialogue();
}

function respond_player_location_dialogue() {
  level notify("location_callout_response");

  if(self.animname == "dining_enemy1") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_10");
    return;
  }

  if(self.animname == "dining_enemy2") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_20");
    return;
  }

  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_30");
}

function callout_player_location() {
  if(!isDefined(self.lastenemysightpos)) {
    return;
  }

  var0 = self.lastenemysightpos;
  level notify("player_location_called");
  self stopsounds();
  waitframe();

  if(self.animname == "dining_enemy1") {
    var1 = ["dx_vom_aq3_dining_room_frontroom_100", "dx_vom_aq3_dining_room_frontroom_110", "dx_vom_aq3_dining_room_frontroom_120"];
  } else if(self.animname == "dining_enemy2") {
    var1 = ["dx_vom_aq2_dining_room_frontroom_130", "dx_vom_aq2_dining_room_frontroom_140", "dx_vom_aq2_dining_room_frontroom_150"];
  } else {
    var1 = ["dx_vom_aqf1_dining_room_frontroom_160", "dx_vom_aqf1_dining_room_frontroom_170", "dx_vom_aqf1_dining_room_frontroom_180"];
  }

  var2 = getEnt("hallway_trigger", "targetname");
  var3 = getEnt("kitchen_trigger", "targetname");
  var4 = getEnt("front_door_trigger", "targetname");

  if(ispointinvolume(var1, var2)) {
    scripts\engine\sp\utility::smart_dialogue(var1[0]);
  } else if(ispointinvolume(var1, var3)) {
    scripts\engine\sp\utility::smart_dialogue(var1[1]);
  } else if(ispointinvolume(var1, var4)) {
    scripts\engine\sp\utility::smart_dialogue(var1[2]);
  }

  wait 0.35;
  level notify("finished_location_callout");
}

function dining_react_dialogue(var0) {
  self endon("death");
  level endon("player_location_called");
  thread spot_player_dialogue();

  if(var0 == "dining_react_nolight") {
    if(self.animname == "dining_enemy1") {
      var1 = ["dx_vom_aq2_dining_room_aqlight_20", 2.65, "dx_vom_aq2_dining_room_aqlight_60"];
      scripts\sp\maps\townhoused\townhoused_code::say_array(var1);
      return;
    }

    if(self.animname == "dining_enemy2") {
      var1 = ["dx_vom_aq1_dining_room_aqlight_10", 1.5, "dx_vom_aq1_dining_room_aqlight_50", 2, "dx_vom_aq1_dining_room_aqlight_80"];
      scripts\sp\maps\townhoused\townhoused_code::say_array(var1);
      return;
    }

    if(self.animname == "dining_enemy3") {
      var1 = ["dx_vom_aqf1_dining_room_aqlight_30", "dx_vom_aqf1_dining_room_aqlight_40", 1.35, "dx_vom_aqf1_dining_room_aqlight_70"];
      scripts\sp\maps\townhoused\townhoused_code::say_array(var1);
      return;
    }

    return;
  }

  wait 0.1;

  if(self.animname == "dining_enemy1") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_60");
    return;
  }

  if(self.animname == "dining_enemy2") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_50");
    return;
  }

  if(self.animname == "dining_enemy3") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_40");
    return;
  }
}

function dining_nolight_delay() {
  self endon("death");
  var0 = undefined;

  if(isDefined(self.target)) {
    var0 = getEnt(self.target, "targetname");
    self.target = undefined;
  }

  waitframe();

  if(self.animname == "dining_enemy1") {
    thread dining_enemy1_react_lookat();
  }

  self.og_maxsightdistsqrd = self.maxsightdistsqrd;
  var1 = 170;
  self.maxsightdistsqrd = squared(var1);
  level.player.ignoreme = 1;
  self clearenemy();
  self.dontevershoot = 1;
  thread dining_nolight_dist_thread();
  dining_nolight_wait_anim();
  var2 = 0;

  if(self.animname == "dining_enemy3") {
    self.goalradius = 32;
    self setgoalpos(self.origin);
  } else if(isDefined(self.script_linkto)) {
    var2 = 1;
    var3 = scripts\engine\utility::get_linked_nodes();
    self.goalradius = 32;
    self setgoalnode(var3[0]);
  }

  level.player.ignoreme = 0;
  var4 = randomfloatrange(3, 5);
  self.stealth.scriptedinitialinvestigatedelay = var4;
  dining_nolight_wait_time(var4);
  self notify("stop_scaredlook");
  scripts\common\utility::lookatpos(undefined);
  self.maxsightdistsqrd = self.og_maxsightdistsqrd;
  self.dontevershoot = 0;

  if(isDefined(var0)) {
    self setgoalvolumeauto(var0);
    return;
  }
}

function dining_enemy1_react_lookat() {
  self setuplookatfornotetrack();
  scripts\common\utility::lookatentity(level.player, 1);
  wait 0.5;
  scripts\common\utility::lookatentity();
}

function dining_nolight_scaredlook() {
  self endon("death");
  self endon("stop_scaredlook");
  var0 = scripts\engine\utility::getStruct("dining_room_lookat_pos", "targetname");

  for(;;) {
    var1 = randomfloatrange(5, 7);
    scripts\common\utility::lookatpos(var0.origin);
    wait var1;
    scripts\common\utility::lookatpos(undefined);
    wait randomfloatrange(0.3, 0.5);
  }
}

function dining_nolight_enemy3_dialogue() {
  self endon("death");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqlight_30");
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqlight_40");
}

function dining_nolight_dist_thread() {
  self endon("death");
  level endon("stop_nolight_dist_thread");
  var0 = squared(80);

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) < var0) {
      break;
    }

    waitframe();
  }

  level notify("stop_nolight_dist_thread");
  level.player.ignoreme = 0;
}

function dining_nolight_wait_anim() {
  if(!istrue(level.demo)) {
    self endon("enemy");
    self endon("bulletwhizby");
  }

  self endon("damage");
  self waittillmatch("single anim", "end");
}

function dining_nolight_wait_time(var0) {
  if(!istrue(level.demo)) {
    self endon("bulletwhizby");
  }

  self endon("damage");
  self endon("enemy");
  wait var0;
}

function disable_player_sealth(var0) {
  if(isDefined(var0)) {
    wait var0;
  }

  level.player scripts\engine\utility::ent_flag_clear("stealth_enabled");
  level.player.maxvisibledist = 8192;
}

function is_footstep_react() {
  if(!isDefined(self.anim_react_event)) {
    return false;
  }

  if(!isDefined(self.anim_react_event.typeorig)) {
    return false;
  }

  return self.anim_react_event.typeorig == "footstep";
}

function dining_room_late_long_death() {
  if(!isalive(self)) {
    return;
  }

  if(istrue(level.demo) && self.animname == "dining_enemy3") {
    scripts\engine\sp\utility::set_deathanim("demo_death");
    return;
  }

  self endon("death");
  self notify("stop_dining_enemy_damage");
  self endon("stop_dining_room_late_long_death");

  if(self.health > 120) {
    self.health = 200;
  }

  self.allowdeath = 0;
  var0 = scripts\engine\utility::getStruct(self.animname + "_late_long_death", "targetname");
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_long_death_relative(self, "dining_late_long_death", undefined, &dining_longdeath_counter);
}

function dinnig_enemy_react_then_pain() {
  self endon("death");
  self endon("stop_dining_enemy_damage");
  self waittill("damage");

  if(!isalive(self) || self.health == 1) {
    return;
  }

  self notify("react_pain");
  self stopanimScripted();

  if(self.currentpose == "crouch") {
    scripts\asm\asm::asm_setstate("pain_crouch");
  } else {
    scripts\asm\asm::asm_setstate("pain_stand");
  }

  if(self.a.weaponpos.size == 0 || !isDefined(self.a.weaponpos["right"])) {
    scripts\anim\shared::forceuseweapon(self.sidearm, "secondary");
    return;
  }
}

function dining_death_vo() {
  if(self.animname == "dining_enemy3") {
    scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aqf1_dining_room_aqreact_71");
    return;
  }

  if(self.animname == "dining_enemy2") {
    return;
  }

  if(self.animname == "dining_enemy1") {
    scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aq2_dining_room_aqreact_91");
    return;
  }
}

function dining_long_death_vo() {
  self endon("death");
  self waittill("longdeath");
  waitframe();

  if(self.animname == "dining_enemy3") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf1_dining_room_aqreact_70");
    return;
  }

  if(self.animname == "dining_enemy2") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_dining_room_aqreact_80");
    return;
  }

  if(self.animname == "dining_enemy1") {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_dining_room_aqreact_90");
    return;
  }
}

function dining_trigger_damage_thread(var0) {
  thread dining_trigger_damage_onnotify("damage");
  thread dining_trigger_damage_onnotify("flashbang");
  jumpiftrue(isDefined(var0)) LOC_00000020;
  var0 = 0;

  for(;;) {
    self waittill("trigger");

    if(!var0 && !isDefined(self.triggertype)) {
      continue;
    }

    var1 = scripts\engine\sp\utility::get_living_ai_array("dining_enemies", "script_noteworthy");

    if(var0) {
      scripts\engine\utility::flag_set("player_exiting_kitchen");
      scripts\engine\sp\utility::array_notify(var1, "react");
      continue;
    }

    if(self.triggertype == "frag") {
      foreach(var3 in var1) {
        if(distancesquared(var3.origin, self.point) > 200 && randomint(100) < 70) {
          var3 dodamage(var3.health * 0.7, self.point, level.player);
          continue;
        }

        var3 kill();
      }

      continue;
    }

    if(self.triggertype == "flash") {
      foreach(var3 in var1) {
        if(!istrue(var3.flashbangimmunity)) {
          thread dining_enemy_flashbang();
        }
      }
    }
  }
}

function dining_enemy_flashbang() {
  self notify("stop_dining_enemy_react");
  self notify("stop_anim_react_death");
  self.skipdeathanim = undefined;
  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\townhoused\townhoused_code::force_flash();
}

function dining_trigger_damage_onnotify(var0) {
  self endon("death");

  for(;;) {
    self waittill(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(var0 == "flashbang") {
      self.triggertype = "flash";
      self notify("trigger");
      continue;
    }

    if(isDefined(var10) && var10.basename == "frag") {
      self.triggertype = "frag";
      self.point = var4;
      self notify("trigger");
      continue;
    }

    if(isDefined(var10) && var10.basename == "flash") {
      self.triggertype = "flash";
      self notify("trigger");
    }
  }
}

function dining_engage_enemy(var0) {
  self endon("death");
  self.target = undefined;
  self.goalradius = 32;

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_linked_nodes();
    self setgoalnode(var1[0]);
  } else {
    self setgoalpos(self.origin);
  }

  self getenemyinfo(level.player);
  wait randomfloat(2);

  if(isDefined(var0)) {
    self.goalradius = var0;
    return;
  }

  self.goalradius = 1000;
}

function dining_react_death(var0, var1) {
  self endon("death");

  if(istrue(var1)) {
    self endon("stop_death_react_thread");

    while(self.health > 1) {
      waitframe();
    }
  }

  if(self.damagelocation == "head" || self.damagelocation == "helmet") {
    var2 = "death";
  } else {
    var2 = "long_death";
  }

  self notify("stop_anim_react_death");

  if(var2 == "long_death") {
    self notify("longdeath");
    var3 = "dining_" + var2;

    if(dining_longdeath_count_get() < 2 && isDefined(level.scr_anim[self.animname][var3])) {
      var4 = level.scr_anim[self.animname][var3];

      if(!animhasnotetrack(var4, "can_use_long_death_end")) {
        self.allowdeath = 1;
        var5 = "dining_long_death_end";
        var4 = level.scr_anim[self.animname][var5];

        if(isDefined(var4)) {
          scripts\engine\sp\utility::set_deathanim(var5);
        } else {
          self.allowdeath = 1;
        }
      }
    } else {
      var2 = "death";
    }
  } else {
    self.skipdeathanim = 1;
  }

  if(var2 == "long_death") {
    self actoraimassistoff();
    dining_longdeath_counter();
  } else {
    dining_death_counter();
  }

  var1 scripts\sp\anim::anim_single_with_props([self], "dining_" + var2);
  var5 = "dining_" + var2 + "_expire";

  if(var2 == "long_death" && scripts\engine\utility::hasanim(var5)) {
    var1 scripts\sp\anim::anim_single_with_props([self], var5);
    return;
  }
}

function dining_death_counter(var0) {
  self notify("stop_dining_death_counter");
  self endon("stop_dining_death_counter");

  if(istrue(var0)) {
    self waittill("death");
  }

  if(!isDefined(level.dining_death_counter)) {
    level.dining_death_counter = 0;
  }

  level.dining_death_counter++;

  if(level.dining_death_counter == 3) {
    scripts\engine\utility::flag_set("dining_room_dead");
    return;
  }
}

function dining_longdeath_counter() {
  if(!isDefined(level.dining_longdeath_counter)) {
    level.dining_longdeath_counter = 0;
  }

  level.dining_longdeath_counter++;
  dining_death_counter();

  if(dining_longdeath_count_get() == 3) {
    return 0;
  }
}

function dining_longdeath_count_get() {
  if(!isDefined(level.dining_longdeath_counter)) {
    level.dining_longdeath_counter = 0;
  }

  return level.dining_longdeath_counter;
}

function dining_enemy3_grenade() {
  self endon("death");
  self waittill("grenade_bounce");
  self notify("stop_anim_react_death");
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  scripts\common\anim::anim_single_solo(self, "dining_react_grenade");
  self.skipdeathanim = undefined;
}

function dining_enemy3_react(var0) {
  dining_delete_clip();
  self notify("stop_anim_react_death");
  self notify("stop_dining_enemy_damage");
  scripts\engine\sp\utility::clear_deathanim();

  if(var0 == "pain") {
    return var0;
  }

  var1 = dining_room_is_light_dead();
  var2 = scripts\engine\utility::getStruct("dining_animnode", "targetname");

  if(var1) {
    self.allowdeath = 1;
    scripts\common\anim::anim_single_solo(self, "dining_react_high");
    return "skip_reaction";
  }

  if(isDefined(self.anim_react_event)) {
    if(self.anim_react_event.typeorig == "grenade danger") {
      thread scripts\common\anim::anim_single_solo(self, "dining_react_grenade");
      return "skip_reaction";
    }
  }

  thread dining_enemy3_react_goto_gun();
  return "skip_reaction";
}

function dining_enemy3_react_goto_gun() {
  self endon("death");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.allowdeath = 1;
  scripts\common\anim::anim_single_solo(self, "dining_react");
}

function price_dining_room(var0) {
  level.price endon("stop_dining_lookat");
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_dining_room_entry_10");
  var1 = scripts\engine\utility::getStruct("dining_room_gesture", "targetname");
  level.price thread scripts\asm\gesture::ai_request_gesture("advance", var1);
}

function price_dining_room_end(var0) {
  level.price notify("stop_dining_lookat");
  level.price.ignoreall = 1;
  level.price.dontevershoot = 0;
  level.price.favoriteenemy = undefined;
  level.price.aiment delete();
}

function dining_room_animrate_adjust(var0, var1) {
  waitframe();
  scripts\engine\utility::flag_wait_either("dining_room_react", "player_exiting_kitchen");
  var2 = var1 + "_fastforward";

  if(scripts\engine\utility::flag_exist(var2)) {
    scripts\engine\utility::flag_wait(var2);
  }

  thread dining_room_teleport_price();
  self setanimrate(scripts\engine\utility::getanim(var1), 1.6);
}

function dining_room_teleport_price() {
  level endon("stop_dining_room_teleport");
  var0 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");
  var1 = level.price scripts\engine\utility::getanim("stairtrain1_arrive");
  var2 = getstartorigin(var0.origin, var0.angles, var1);
  var3 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
  var4 = getEnt("dining_room_teleport_price_trigger", "targetname");
  var5 = cos(80);
  var6 = [level.player, level.price];

  for(;;) {
    waitframe();

    if(!level.player istouching(var4)) {
      continue;
    }

    var7 = 0;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price.origin + (0, 0, 60), var5)) {
      if(cansee_bounds(level.price.origin)) {
        var7 = 1;
      }
    }

    var8 = 0;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var2 + (0, 0, 60), var5)) {
      if(cansee_bounds(var2)) {
        var8 = 1;
      }
    }

    if(!var7 && !var8) {
      var3 notify("stop_loop_price");
      level.price scripts\engine\sp\utility::anim_stopanimScripted();
      level.price.diningroom_skipanimreach = 1;
      level.price scripts\anim\notetracks_sp::notetrackvisorpricelower_instant();
      return;
    }
  }
}

function cansee_bounds(var0) {
  var1 = vectortoangles(level.player.origin - var0);
  var2 = anglestoright(var1);
  var3 = 16;
  var4 = 60;
  var5 = 2;
  var6 = 2;
  var7 = var4 / var5;
  var8 = var3 / var6;

  for(var9 = 0; var9 < var6; var9++) {
    var10 = var9 + 1;
    var11 = var0 + var2 * var8 * var10;

    if(cansee_vertical(var11, var5, var7)) {
      return true;
    }
  }

  for(var9 = 0; var9 < var6; var9++) {
    var10 = var9 + 1;
    var11 = var0 + var2 * var8 * var10 * -1;

    if(cansee_vertical(var11, var5, var7)) {
      return true;
    }
  }

  return false;
}

function cansee_vertical(var0, var1, var2) {
  var3 = (0, 0, 1);

  if(cansee_point(var0)) {
    return true;
  }

  for(var4 = 0; var4 < var1; var4++) {
    var5 = var4 + 1;
    var6 = var0 + var3 * var2 * var5;

    if(cansee_point(var6)) {
      return true;
    }
  }

  return false;
}

function cansee_point(var0) {
  var1 = isDefined(level.player worldpointtoscreenpos(var0, getdvarint("MRNKTKLLKP")));

  if(var1) {}

  return var1;
}

function stairtrain1_setup() {
  if(!isDefined(level.temp_stairtrain_count)) {
    level.temp_stairtrain_count = 0;
  }

  var0 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");

  if(self == level.price) {
    if(level.start_point != "stairtrain1") {
      if(!istrue(self.diningroom_skipanimreach)) {
        var0 scripts\sp\anim::anim_reach_solo(self, "stairtrain1_arrive");
      }

      level notify("stop_dining_room_teleport");
      thread stairtrain1_price_player_race();
      var0 scripts\common\anim::anim_single_solo(self, "stairtrain1_arrive");
    }

    scripts\engine\utility::flag_set("dining_room_price_in_position");
    var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "stairtrain1_start", undefined, "stop_frontdoor_enter_loop");
  }

  scripts\engine\utility::flag_wait("stairtrain1_go");
  thread try_nvg_enable_hint();
  var0 notify("stop_frontdoor_enter_loop");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 3) {
    level.temp_stairtrain_count = undefined;
    var1 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var2 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
    var3 = [level.price, var1, var2];
    var4 = undefined;

    foreach(var6 in var3) {
      if(isDefined(var4)) {
        var4 scripts\sp\stairtrain::set_prevguy(var6);
      }

      var4 = var6;
      var6.animnode = var0;
      var6 scripts\engine\sp\utility::anim_stopanimScripted();
      var6 thread scripts\asm\asm_sp::asm_animcustom(&scripts\sp\maps\townhoused\townhoused_code::stairtrain1_animcustom);
    }

    scripts\engine\sp\utility::trigger_wait_targetname("player_base_stairtrain1");
    wait 2.35;
    scripts\engine\utility::flag_set("stairtrain1_started");
    return;
  }
}

function stairtrain1_price_player_race() {
  level endon("stop_price_player_race");
  var0 = scripts\engine\utility::getStruct("first_floor_hallway_path", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  waitframe();
  var2 = level.price scripts\engine\utility::getanim("stairtrain1_arrive");
  var3 = 0;

  for(;;) {
    var4 = pointonsegmentnearesttopoint(var0.origin, var1.origin, level.player.origin);
    var5 = pointonsegmentnearesttopoint(var0.origin, var1.origin, level.price.origin);
    var6 = distancesquared(var0.origin, var4);
    var7 = distancesquared(var0.origin, var5);

    if(var6 > var7 && !var3) {
      var3 = 1;
      level.price setanimrate(var2, 2.5);
    } else if(var6 < var7 && var3) {
      var3 = 0;
      level.price setanimrate(var2, 1);
    }

    waitframe();
  }
}

function postspawn_bravo4() {
  scripts\engine\utility::set_movement_speed(120);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.script_pushable = 0;

  if(!scripts\sp\starts::is_after_start("dining_room")) {
    self setCanDamage(0);
  }

  scripts\sp\maps\townhoused\townhoused_code::postpawn_friendly_shared();
  level.squads["bravo4"] = scripts\engine\utility::array_add(level.squads["bravo4"], self);

  if(scripts\sp\starts::is_after_start("stairtrain1")) {
    if(self.animname == "bravo4_3") {
      wait 0.1;
      scripts\common\ai::stop_magic_bullet_shield();
      self delete();
    }

    return;
  }

  if(level.squads["bravo4"].size == 3) {
    thread bravo4_frontdoor_enter();
    return;
  }
}

function bravo4_frontdoor_enter() {
  var0 = level.squads["bravo4"];
  var1 = scripts\engine\utility::getStruct("stairtrain1_animnode", "targetname");
  var1 scripts\common\anim::anim_first_frame(var0, "frontdoor_start");
  scripts\engine\utility::flag_wait("player_in_dining_room");
  var1 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var0, "frontdoor_start", undefined, "stop_frontdoor_start_loop");
  scripts\engine\utility::flag_wait("dining_room_dead");
  scripts\engine\utility::flag_wait("player_said_dining_clear");
  var2 = gettime();
  scripts\engine\utility::flag_wait("dining_room_price_in_position");
  wait max(1 - (gettime() - var2) * 0.001, 0);
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_stairtrain1_rally_10");
  var1 notify("stop_frontdoor_start_loop");
  var3 = getEnt("frontdoor", "targetname");
  var3 scripts\engine\sp\utility::assign_animtree("door");
  var1 thread scripts\common\anim::anim_single_solo(var3, "frontdoor_enter");
  thread stair_player_clip();

  foreach(var5 in var0) {
    var5 setCanDamage(1);

    if(var5.animname == "bravo4_3") {
      var1 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var5, "frontdoor_enter", undefined, "stop_frontdoor_enter_loop_bravo4_3");
      continue;
    }

    if(level.start_point != "stairtrain1") {
      var1 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var5, "frontdoor_enter", undefined, "stop_frontdoor_enter_loop");
    }
  }

  if(level.start_point != "stairtrain1") {
    var7 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var7 waittillmatch("single anim", "end");
  }

  scripts\engine\utility::flag_set("delete_stair_player_pusher");

  foreach(var5 in var0) {
    if(var5.animname == "bravo4_3") {
      continue;
    }

    if(var5.animname == "bravo4_2") {
      thread stairtrain1_ready_thread();
    }

    thread stairtrain1_setup();
  }
}

function stairtrain1_ready_thread() {
  self waittillmatch("single anim", "end");
  var0 = squared(80);

  for(;;) {
    waitframe();

    if(distancesquared(self.origin, level.player.origin) < var0) {
      break;
    }
  }

  scripts\engine\utility::flag_set("stairtrain1_go");
}

function stair_player_clip() {
  wait 4;
  var0 = getEnt("stair_player_pusher", "targetname");
  var0 moveTo(var0.og_origin, 4, 0, 4);
  scripts\engine\utility::flag_wait("delete_stair_player_pusher");
  var0 delete();
}

function bravo4_3_door_enter() {
  self waittillmatch("single anim", "end");
  self.script_pushable = 0;
  self.uprightcqbidle = 1;
  self.grenadeawareness = 0;
  self.goalradius = 16;
  self setgoalpos(self.origin);
  scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");
  scripts\common\ai::set_gunpose("gun_down");
  thread scripts\sp\maps\townhoused\townhoused_code::lookat_random("front_door_random_lookats");
}

function bravo_3_toggle_laser(var0) {
  self endon("death");
  var1 = cos(15);
  var2 = 1;
  var3 = 0;

  for(;;) {
    if(scripts\engine\utility::within_fov(self getEye(), self.angles, level.player getEye(), var1)) {
      if(var2) {
        scripts\sp\maps\townhoused\townhoused_code::enable_laser(0);
        scripts\common\ai::set_gunpose("gun_down");
        var2 = 0;
      }
    } else if(var2) {
      if(randomint(100) > 30) {
        var3 = gettime() + randomintrange(2000, 5000);
        scripts\sp\maps\townhoused\townhoused_code::enable_laser(1);
        scripts\common\ai::set_gunpose("gun_down");
        var2 = 0;
      }
    } else if(!var2 && gettime() > var3) {
      scripts\sp\maps\townhoused\townhoused_code::enable_laser(1);
      scripts\common\ai::set_gunpose("ads");
      var2 = 1;
    }

    waitframe();
  }
}

function create_aiment(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("tag_origin_only_collision");
  var1 notsolid();
  self.aiment = var1;
  self.dontevershoot = 1;
  self setentitytarget(var1);
  self.favoriteenemy = var1;
  return var1;
}

function delete_aiment() {
  var0 = self;

  if(isai(self)) {
    var0 = self.aiment;
  }

  var0 delete();
}

function second_floor_movement() {
  thread second_floor_price();
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var0.end_pos = (273.801, 876.154, -305.97);
  var0.end_angles = (0, 147.443, 0);
  thread second_floor_back_bedroom();
  var1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var1.end_pos = (339.515, 930.924, -305.844);
  var1.end_angles = (0, 98.5017, 0);
  thread second_floor_bathroom();
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  var2 = scripts\engine\utility::getStructArray("2ndfloor_animnodes", "script_noteworthy");

  foreach(var4 in var2) {
    var4 notify("stop_second_floor_loop");
    var4 notify("stop_loop");
  }

  var6 = scripts\sp\door::get_interactive_door("secondfloor_door_two");
  var6 scripts\sp\door::add_pushent(var0);
  var6 scripts\sp\door::add_pushent(var1);
  thread second_floor_stairtrain_arrive();
  thread second_floor_stairtrain_arrive();
  var7 = getEnt("2nd_floor_door_playerclip", "targetname");
  var7 solid();
  var7 = getEnt("2ndfloor_bathroom_playerclip", "targetname");
  var7 delete();
  thread stairtrain2_player_near();
}

function stairtrain2_player_near() {
  var0 = getEnt("player_near_stairtrain2", "targetname");
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("player_near_stairtrain2");
}

function second_floor_stairtrain_arrive() {
  var0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");

  if(self != level.price) {
    if(self.animname == "bravo4_2") {
      scripts\engine\utility::flag_wait("bravo4_2_move_to_stairtrain2");
    } else {
      thread second_floor_bravo4_1_arrive_flag();
    }

    if(distancesquared(self.origin, self.end_pos) > 100) {
      self forceteleport(self.end_pos, self.end_angles);
    }

    scripts\engine\sp\utility::anim_stopanimScripted();
    var0 scripts\sp\anim::anim_reach_solo(self, "stairtrain2_arrive");
    scripts\engine\utility::flag_wait("move_to_stairtrain2");
  }

  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "stairtrain2_arrive", undefined, "stop_arrive_loop");
  scripts\engine\utility::flag_wait("2ndfloor_bathroom_enemy_dead");
  thread stairtrain2_setup();
}

function second_floor_bravo4_1_arrive_flag() {
  var0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  var1 = getstartorigin(var0.origin, var0.angles, scripts\engine\utility::getanim("stairtrain2_arrive"));

  while(distancesquared(self.origin, var1) > 8100) {
    waitframe();
  }

  scripts\engine\utility::flag_set("bravo4_2_move_to_stairtrain2");
}

function second_floor_price() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    scripts\engine\utility::ent_flag_init("stairtrain_on");
  }

  if(scripts\engine\utility::ent_flag("stairtrain_on")) {
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
  }

  interior_price_settings();

  if(getdvarint("scr_reveal") > 0) {
    thread second_floor_reveal_stuff();
  }

  var0 = spawnStruct();
  var0.origin = self.origin;
  var0.angles = self.angles;
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_single_then_loop_solo(self, "2ndfloor_arrive");
  self.goalradius = 32;
  self setgoalpos(self.origin);
  scripts\engine\utility::flag_wait("2nd_floor_move");

  if(getdvarint("scr_reveal") == 0) {
    thread scripts\sp\maps\townhoused\townhoused_code::train_go("south");
  }

  wait 0.25;
  thread targets_behind_door_callout();
  var1 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  var0 notify("stop_loop");
  var1 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "stairtrain2_pre_arrive", undefined, "stop_pre_arrive_loop_price");
  scripts\engine\utility::flag_wait("2nd_floor_clear");
  var1 notify("stop_pre_arrive_loop_price");
  thread second_floor_stairtrain_arrive();
}

function second_floor_reveal_stuff() {
  thread scripts\sp\maps\townhoused\townhoused_code::train_go("south");
  var0 = undefined;

  foreach(var2 in level.createfxent) {
    if(var2.v["fxid"] == "vfx_streetlight_lensflare") {
      if(var2.v["origin"][0] == 674.48) {
        var0 = var2;
        break;
      }
    }
  }

  wait 0.1;

  if(isDefined(var0)) {
    var0.looper delete();
    return;
  }
}

function targets_behind_door_callout() {
  level.hostage_enemy endon("death");
  level.hostage_enemy endon("enemy");
  wait 1;
  var0 = gettime();

  while(isDefined(level.hostage_enemy) && !scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.hostage_enemy.origin, cos(15)) && !scripts\engine\utility::time_has_passed(var0, 6)) {
    waitframe();
  }

  if(!isDefined(level.hostage_enemy)) {
    return;
  }

  wait 0.3;
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_2nd_floor_bedroom2_10");
}

function second_floor_back_bedroom() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    scripts\engine\utility::ent_flag_init("stairtrain_on");
  }

  if(scripts\engine\utility::ent_flag("stairtrain_on")) {
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
  }

  var0 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var1 = scripts\engine\sp\utility::get_living_ai("bedroom_enemy", "animname");

  if(getdvarint("scr_reveal") > 0) {
    wait 3;
  }

  var2 = "2ndfloor_bedroom_enter";
  var0 notify("stop_loop");
  var3 = scripts\sp\door::get_interactive_door("2ndfloor_back_bedroom_door");
  var3 scripts\sp\door::remove_open_ability();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_door(var3, var2);
  level notify("stop_dog_sounds_front_door");

  if(getdvarint("scr_reveal") > 0) {
    thread reveal_firing();
  }

  var1.allowdeath = 1;
  var1.skipdeathanim = undefined;
  var0 thread scripts\common\anim::anim_single_solo(var1, var2);
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, var2, undefined, "stop_second_floor_loop");
}

function reveal_firing() {
  wait 9.05;
  thread scripts\sp\maps\townhoused\townhoused_anim::second_floor_bedroom_reveal_fire(self);
  wait 0.3;
  thread scripts\sp\maps\townhoused\townhoused_anim::second_floor_bedroom_reveal_fire(self);
  wait 0.3;
  thread scripts\sp\maps\townhoused\townhoused_anim::second_floor_bedroom_reveal_fire(self);
}

function back_bedroom_enemy() {
  var0 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(self, "2ndfloor_bedroom_enter");
}

function second_floor_bathroom() {
  if(!scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    scripts\engine\utility::ent_flag_init("stairtrain_on");
  }

  if(scripts\engine\utility::ent_flag("stairtrain_on")) {
    scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
  }

  var0 = scripts\engine\utility::getStruct("2ndfloor_bathroom_animnode", "targetname");
  var0 notify("stop_loop");
  var1 = scripts\sp\door::get_interactive_door("2ndfloor_bathroom_door");
  var1 scripts\sp\door::remove_open_ability();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_door(var1, "2ndfloor_bathroom_enter");
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, "2ndfloor_bathroom_enter");
}

function postspawn_second_floor_enemy() {
  scripts\engine\sp\utility::disable_long_death();
  scripts\engine\sp\utility::disable_surprise();
  self.nofacialfiller = 1;

  if(self.animname == "bathroom_guy") {
    self.pathenemyfightdist = 10;
    thread bathroom_enemy();
    return;
  }

  if(self.animname == "bedroom_enemy") {
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.skipdeathanim = 1;
    thread back_bedroom_enemy();
    thread back_bedroom_enemy_death();
    return;
  }

  if(!isDefined(level.hostage_ai)) {
    level.hostage_ai = [];
  }

  if(self.animname == "hostage_enemy") {
    level.hostage_enemy = self;
    scripts\engine\utility::ent_flag_init("engaging_enemy");
  } else if(self.animname == "hostage") {
    self.team = "neutral";
    level.hostage = self;
  }

  self.dontmelee = 1;
  level.hostage_ai[level.hostage_ai.size] = self;

  if(level.hostage_ai.size == 2) {
    thread hostage_sequence();
    return;
  }
}

function back_bedroom_enemy_death() {
  self waittill("death");
  thread hostage_enemy_dialogue();
}

function hostage_enemy_dialogue() {
  var0 = level.hostage;
  var1 = level.hostage_enemy;

  if(!isalive(var1) || var1 scripts\engine\utility::ent_flag("engaging_enemy")) {
    return;
  }

  var1 endon("death");
  var1 endon("engaging_enemy");
  wait 3;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_10");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_20");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_30");
  wait 0.5;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_40");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_50");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_25");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_aq_convo4_60");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_aq_convo4_70");
}

function hostage_sequence() {
  var0 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var1 = level.hostage;
  var2 = level.hostage_enemy;
  var1 thread scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aqf2_2nd_floor_bedroom2_51");
  var2 thread scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aq5_2nd_floor_bedroom2_81");
  thread hostage_flank_react(var0);

  foreach(var4 in level.hostage_ai) {
    thread hostage_damage_thread(level, var4);
  }

  var2 scripts\common\ai::gun_remove();
  var2.weapon = isundefinedweapon();
  var2 scripts\anim\shared::forceuseweapon(var2.sidearm, "sidearm");
  var2 scripts\anim\shared::placeweaponon(var2.sidearm, "left");
  thread hostage_enemy_thread();
  var0 thread scripts\common\anim::anim_loop(level.hostage_ai, "hostage_loop");
  thread hostage_detach_weapon();
}

function hostage_detach_weapon() {
  wait 0.2;
  var0 = self gettagorigin("tag_weapon_right");
  var1 = self gettagangles("tag_weapon_right");
  var2 = spawn("weapon_" + createheadicon(self.weapon), var0, 2);
  waitframe();
  var2.angles = var1;
  self.gun_on_ground = var2;
  self.og_sidearm = self.sidearm;
  self.sidearm = isundefinedweapon();
  scripts\common\ai::gun_remove();
}

function hostage_damage_thread(var0, var1) {
  var0 endon("stop_damage_thread");
  var0.health = 10000;
  var0.scripted_health = 150;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = 0;

  while(var0.scripted_health > 1) {
    var0 waittill("damage", var6, var2, var7, var3, var4, var8, var9, var10, var11, var12);

    if(var4 == "MOD_IMPACT") {
      continue;
    }

    var0.scripted_health -= var6;

    if(var0.scripted_health <= 0 && scripts\sp\maps\townhoused\townhoused_code::is_explosivedamage(var4)) {
      var1 notify("stop_loop");
      var0.allowdeath = 1;
      var0 kill(var3, var2, var2, var4);
      return;
    }

    if(scripts\sp\maps\townhoused\townhoused_code::is_flash_weapon(var12)) {
      var5 = 1;
      break;
    }
  }

  if(scripts\engine\utility::ent_flag_exist("engaging_enemy")) {
    scripts\engine\utility::ent_flag_set("engaging_enemy");
  }

  var0 notify("stop_enemy_thread");
  var0 notify("stop_anim_aim");

  if(var5) {
    thread hostage_flashbang_thread(var0);
    return;
  }

  var0.health = 1;
  var0.ignoreall = 1;
  var0 scripts\sp\utility::context_melee_allow(0);
  level notify("stop_hostage_flank_react");

  foreach(var14 in level.hostage_ai) {
    if(var14 != var0) {
      if(var14.scripted_health > 0) {
        var14.health = var14.scripted_health;
      }

      var14 notify("stop_enemy_thread");
      var14 notify("stop_damage_thread");
    }

    var14 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var1 notify("stop_loop");
  scripts\engine\utility::flag_set("2ndfloor_execute");
  var16 = level.hostage;
  var17 = level.hostage_enemy;

  if(var0.animname == "hostage") {
    var17 notify("stop_anim_aim");
    thread hostage_death_counter(var17);
    hostage_death_counter(var16);
    var17.skipdeathanim = 1;
    var17.allowdeath = 1;
    var1 scripts\common\anim::anim_single(level.hostage_ai, "enemy_live");
    var17.skipdeathanim = undefined;
    return;
  }

  var16.skipdeathanim = 1;
  var16.allowdeath = 1;
  var16 stopsounds();
  var17 stopsounds();
  var17 actoraimassistoff();
  var0.skipdeathanim = 1;
  thread hostage_death_counter(var16);
  hostage_death_counter(var17);

  if(istrue(level.demo)) {
    var16 actoraimassistoff();
  }

  if(var0.damagelocation == "head" || var0.damagelocation == "helmet") {
    var0.skipdeathanim = undefined;
    var0 scripts\engine\sp\utility::set_deathanim("hostage_headshot");
    var0 kill(var3, var2, var2, var4);
    var1 scripts\common\anim::anim_single_solo(var16, "hostage_live");
    return;
  }

  thread hostage_enemy_ondeath();
  var1 scripts\common\anim::anim_single(level.hostage_ai, "hostage_live");
}

function hostage_flank_react(var0) {
  level endon("stop_hostage_flank_react");
  scripts\engine\utility::flag_wait("hostage_flanked");
  var0 notify("stop_loop");
  scripts\engine\utility::flag_set("2ndfloor_execute");

  foreach(var2 in level.hostage_ai) {
    if(!isalive(var2)) {
      continue;
    }

    var2.health = var2.scripted_health;
    var2 notify("stop_enemy_thread");
    var2 notify("stop_anim_aim");
    var2 notify("stop_damage_thread");
    var2 scripts\engine\sp\utility::anim_stopanimScripted();

    if(var2.animname == "hostage" && var2.weapon != var2.og_sidearm) {
      var2.team = "axis";
      var3 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
      var2 scripts\anim\shared::forceuseweapon(var3, "primary");
      thread hostage_death_counter(var2);
    }
  }
}

function hostage_death_counter(var0) {
  self notify("stop_hostage_death_counter");
  self endon("stop_hostage_death_counter");

  if(istrue(var0)) {
    self waittill("death");
  }

  if(!isDefined(level.hostage_death_counter)) {
    level.hostage_death_counter = 0;
  }

  level.last_hostage_death_position = self.origin + (0, 0, 20);
  level.hostage_death_counter++;

  if(level.hostage_death_counter == 2) {
    scripts\engine\utility::flag_set("hostage_guys_dead_or_longdeath");
    return;
  }
}

function hostage_enemy_ondeath() {
  scripts\engine\utility::delaythread(0.05, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq5_2nd_floor_bedroom2_82");
  self waittill("death");
  self setanimrate(scripts\engine\utility::getanim("hostage_live"), 0);
}

function hostage_death_with_gun() {
  if(isDefined(self.scripted_longdeath)) {
    return false;
  }

  if(self.damagelocation == "head" || self.damagelocation == "helmet") {
    self.skipdeathanim = undefined;
    scripts\engine\sp\utility::set_deathanim("hostage_live_headshot");
  }

  return false;
}

function hostage_flashbang_thread(var0) {
  var0 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  waitframe();
  self.health = int(max(self.scripted_health, 10));

  if(self.team != "axis") {
    self.team = "axis";
    self.sidearm = self.og_sidearm;
    self.primaryweapon = isundefinedweapon();
    scripts\anim\shared::forceuseweapon(self.sidearm, "secondary");
  }

  scripts\sp\maps\townhoused\townhoused_code::force_flash();
}

function hostage_enemy_thread() {
  self endon("death");
  self endon("stop_enemy_thread");
  hostage_enemy_sight();
  scripts\engine\utility::ent_flag_set("engaging_enemy");
  self stopsounds();
  var0 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var0 notify("stop_loop");
  scripts\engine\utility::array_thread(level.hostage_ai, &scripts\engine\sp\utility::anim_stopanimscripted);
  GscBinSkip1(0x45, "left", 30);
}

function hostage_enemy_sight() {
  var0 = wait_see_player();
  thread hostage_dialogue();
  thread hostage_enemy_engage_dialogue();

  if(!istrue(var0)) {
    return;
  }

  wait 0.25;
  self getenemyinfo(level.player);
}

function wait_see_player() {
  self endon("enemy");
  var0 = "tag_eye";

  for(;;) {
    if(sighttracepassed(self getEye(), level.player getEye(), 0, undefined)) {
      break;
    }

    waitframe();
  }

  return true;
}

function hostage_dialogue() {
  level endon("hostage_flanked");

  if(!isalive(level.hostage) || scripts\engine\utility::flag("2ndfloor_execute")) {
    return;
  }

  level.hostage endon("death");
  level endon("2ndfloor_execute");
  level.hostage thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf2_2nd_floor_bedroom2_60");
  thread stop_sounds_on_damaged();
}

function hostage_enemy_engage_dialogue() {
  level endon("hostage_flanked");

  if(!isalive(level.hostage_enemy) || scripts\engine\utility::flag("2ndfloor_execute")) {
    return;
  }

  level.hostage_enemy endon("death");
  level endon("2ndfloor_execute");
  level.hostage_enemy waittill("weapon_fired");
  level.hostage_enemy thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq5_2nd_floor_bedroom2_80");
  thread stop_sounds_on_damaged();
}

function stop_sounds_on_damaged() {
  if(!isalive(self)) {
    return;
  }

  self endon("death");
  self waittill("damage");
  self stopsounds();
}

function bathroom_enemy() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("bathroom_enemy_animnode", "targetname");

  if(istrue(level.demo)) {
    self.health = 20;
  }

  self.allowdeath = 1;
  self.animnode = var0;
  self.deathfunction = &bathroom_enemy_death_func;
  thread bathroom_enemy_death();
  thread bathroom_trigger_think();
  thread demo_bathroom_fakeblood();
  var0 thread scripts\common\anim::anim_loop_solo(self, "bathroom_loop");
  scripts\engine\utility::flag_wait("2ndfloor_execute");
  thread bathroom_enemy_audio();

  while(!bathroom_enemy_react()) {
    waitframe();
  }

  self stopsounds();
  wait 0.1;
  self notify("stop_bathroom_audio");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_162");
  wait 0.3;
  thread bathroom_flash_think();
  var0 notify("stop_loop");
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.baseaccuracy = 0;
  thread bathroom_nade_think();
  bathroom_enemy_react_anim(var0);

  if(!istrue(self.scripted_flash)) {
    var0 scripts\common\anim::anim_single_solo(self, "bathroom_crouch");
  }

  if(istrue(level.demo)) {
    var0 scripts\common\anim::anim_first_frame_solo(self, "bathroom_shoot");
    return;
  }

  self notify("getup");
  self.baseaccuracy = 0.2;
  self.skipdeathanim = undefined;
  self.deathfunction = undefined;

  if(istrue(self.threwbackgrenade) || istrue(self.scripted_flash)) {
    wait 3;
  }

  scripts\engine\utility::flag_set("bathroom_guy_engage");
  self.deathfunction = undefined;
}

function bathroom_trigger_think() {
  self endon("death");
  var0 = getEnt("bathroom_damage_trigger", "targetname");
  thread bathroom_trigger_damage_ondamage();
  thread bathroom_trigger_damage_onflashbang();

  for(;;) {
    var0 waittill("trigger", var1);
  }

  LOC_00000044:
    if(var0.triggertype == "flash") {
      var2 = scripts\engine\sp\utility::get_living_ai("bathroom_guy", "animname");

      if(isalive(var2)) {
        var2 notify("scripted_flash");
        return;
      }

      return;
    }
}

function bathroom_trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9) && var9.basename == "frag" && ispointinvolume(var3, self)) {
      self.triggertype = "frag";
    }
  }
}

function bathroom_trigger_damage_onflashbang() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var0, var1, var2, var3);
    self.triggertype = "flash";
    self notify("trigger");
  }
}

function bathroom_flash_think() {
  self endon("death");
  self endon("quick_getup");
  self endon("getup");
  self waittill("scripted_flash");
  scripts\engine\sp\utility::anim_stopanimScripted();
  wait 0.2;
  scripts\sp\maps\townhoused\townhoused_code::force_flash();
  self.scripted_flash = 1;
}

function bathroom_nade_think() {
  self endon("death");
  self endon("quick_getup");
  self endon("getup");
  var0 = 2025;
  var1 = scripts\engine\utility::getStruct("bathroom_nade_throwback", "targetname");

  for(;;) {
    waitframe();
    var2 = getEntArray("grenade", "classname");

    if(var2.size == 0) {
      continue;
    }

    foreach(var4 in var2) {
      if(var4.model == "offhand_wm_grenade_flash") {
        continue;
      }

      if(distancesquared(var4.origin, self.origin) < var0) {
        wait 0.5;

        if(distancesquared(var4.origin, self.origin) < var0) {
          var5 = scripts\engine\utility::getStructArray(var1.target, "targetname");
          var6 = undefined;
          var7 = undefined;

          foreach(var9 in var5) {
            if(isDefined(var9.script_noteworthy) && var9.script_noteworthy == "failsafe") {
              var6 = var6;
            }

            var10 = scripts\engine\trace::ray_trace(var1.origin, var9.origin);

            if(var10["fraction"] == 1) {
              var7 = var9;
              break;
            }
          }

          if(!isDefined(var7)) {
            return;
          }

          var12 = vectorNormalize(var7.origin + (0, 0, 100) - var1.origin);
          var13 = var12 * 300;
          var14 = magicgrenademanual("frag", var1.origin, var13, 3, var4);
          var4 delete();
          thread nade_line(var14);
          self.threwbackgrenade = 1;
          return;
        }
      }
    }

    var12 = undefined;
    var14 = undefined;
  }
}

function nade_line(var0) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    waitframe();
  }
}

function bathroom_enemy_react_anim(var0) {
  self endon("death");
  self endon("quick_getup");
  GscBinSkip4(0x35);
}

function bathroom_inner_trigger() {
  var0 = getEnt("2nd_floor_bathroom_inner", "targetname");
  var0 waittill("trigger");
  self notify("quick_getup");
}

function demo_bathroom_fakeblood() {
  if(!istrue(level.demo)) {
    return;
  }

  self waittill("death");
  var0 = self.origin + (0, 0, 30);
  GscBinSkip1(0x45, 0, self.angles + (-125, 120, 0));
}

function bathroom_enemy_death() {
  self waittill("death");
  scripts\engine\utility::flag_set("2ndfloor_bathroom_enemy_dead");
}

function bathroom_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!isDefined(var1)) {
    return;
  }

  if(isai(var1)) {
    playFX(scripts\engine\utility::getfx("door_shotgun_impact"), var3, var2);
    return;
  }
}

function bathroom_enemy_react() {
  if(self cansee(level.player)) {
    return true;
  }

  if(!isDefined(level.bathroom_door)) {
    return true;
  }

  if(level.bathroom_door.ajar) {
    return true;
  }

  if(level.bathroom_door.open_completely) {
    return true;
  }

  if(level.bathroom_door.bashed) {
    return true;
  }

  if(level.bathroom_door.health < level.bathroom_door.start_health - 10) {
    return true;
  }

  return false;
}

function bathroom_enemy_audio() {
  self endon("stop_bathroom_audio");
  self endon("death");
  self endon("stop_bathroom_breathing");
  thread bathroom_enemy_audio_close();

  for(;;) {
    scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_160");
    wait randomfloatrange(0.1, 0.5);
  }
}

function bathroom_enemy_audio_close() {
  self endon("stop_bathroom_audio");
  self endon("death");
  var0 = squared(150);

  while(distancesquared(level.player.origin, self.origin) > var0) {
    waitframe();
  }

  self notify("stop_bathroom_breathing");
  self stopsounds();
  self playSound("2nd_floor_shotgun_pump_behind_bathroom_door");
  self playSound("2nd_floor_shotgun_pump_behind_bathroom_door_2");
  thread sfx_random_mvmt_behind_door();
  scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_2nd_floor_bedroom2_161");
}

function sfx_random_mvmt_behind_door() {
  self endon("stop_bathroom_audio");
  self endon("death");
  self.bathroom_sfx = spawn("script_origin", self.origin);
  self.bathroom_sfx linkTo(self);
  waitframe();
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_01");
  wait 0.5;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_05_shells");
  wait 1.85;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_02");
  wait 3.15;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_03");
  wait 2.85;
  self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_04");
  wait 2.55;

  for(;;) {
    self.bathroom_sfx playSound("2nd_floor_shotgun_pump_behind_bathroom_door_mvmt_random", "sounddone");
    self.bathroom_sfx waittill("sounddone");
    wait randomfloatrange(2, 4.3);
  }
}

function bathroom_enemy_death_func() {
  scripts\sp\maps\townhoused\townhoused_code::scripted_deathanim("bathroom_death", self.animnode);

  if(isDefined(self.bathroom_sfx)) {
    self.bathroom_sfx stopsounds();
    self.bathroom_sfx delete();
    return;
  }
}

function stairtrain2_setup() {
  if(!isDefined(level.temp_stairtrain_count)) {
    level.temp_stairtrain_count = 0;
  }

  var0 = scripts\engine\utility::getStruct("stairtrain2_animnode", "targetname");
  scripts\engine\utility::flag_wait("player_near_stairtrain2");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 3) {
    level.temp_stairtrain_count = undefined;
    var1 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
    var2 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
    var3 = [level.price, var1, var2];
    var0 notify("stop_first_frame");
    var0 notify("stop_arrive_loop");
    var4 = undefined;

    foreach(var6 in var3) {
      if(isDefined(var4)) {
        var4 scripts\sp\stairtrain::set_prevguy(var6);
      }

      var4 = var6;
      var6.animnode = var0;
      var6 scripts\engine\sp\utility::anim_stopanimScripted();
      var6 thread scripts\asm\asm_sp::asm_animcustom(&scripts\sp\maps\townhoused\townhoused_code::stairtrain2_animcustom);
    }

    wait 1.3;
    level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain2_rally_50");
    return;
  }
}

function third_floor_movement() {
  var0 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");
  var1 = scripts\sp\door::get_interactive_door("3rdfloor_price_door");
  var1 scripts\sp\door::remove_open_ability();
  var1 scripts\engine\sp\utility::assign_animtree("door");
  thread post_stairtrain_anim(level.price, var0, "buddy_down_intro");
  thread buddy_down_price_anim();
  var2 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  thread post_stairtrain_anim(var2, var0);
  var3 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  post_stairtrain_anim(var3, var0, "buddy_down_intro");
  thread buddy_down_damage_thread();
  scripts\engine\utility::flag_wait("player_near_buddy_down");
  var4 = [var2, var3];

  foreach(var6 in var4) {
    var0 notify("stop_loop_" + var6.animname);
  }

  thread buddy_down_dialogue();
  scripts\engine\utility::flag_set("buddy_down");
  buddy_down_skip_setup(var2);
  buddy_down_skip_setup(var3);
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var4, "buddy_down", undefined, "stop_buddy_down_loop");
  scripts\engine\utility::flag_wait("player_near_buddy_down_room");
  var1 = scripts\sp\door::get_interactive_door("hiding_door");

  if(isDefined(var1)) {
    var1.ignore_grenades = undefined;
  }

  scripts\engine\sp\utility::spawn_targetname("hiding_door_enemy");
  scripts\engine\utility::flag_wait("3rd_floor_enemies_dead");
  scripts\engine\utility::flag_wait("3rd_floor_clear");
  var0 notify("stop_loop_" + level.price.animname);
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(scripts\engine\utility::flag("buddy_down_skip")) {
    buddy_down_skip_post_clear(var0, var4);
    thread go_to_3rd_floor_stairtain(level.price);
    return;
  }

  var0 notify("stop_buddy_down_loop");

  foreach(var6 in var4) {
    var6 scripts\engine\sp\utility::anim_stopanimScripted();
  }

  thread third_floor_buddy_down_drag(level, var0);
  thread go_to_3rd_floor_stairtain(level.price);
}

function third_floor_death_counter(var0) {
  self notify("stop_third_floor_death_counter");
  self endon("stop_third_floor_death_counter");

  if(!isDefined(level.third_floor_death_counter)) {
    level.third_floor_death_counter = 0;
  }

  if(istrue(var0)) {
    self waittill("death");
  }

  level.third_floor_death_counter++;

  if(level.third_floor_death_counter == 3) {
    scripts\engine\utility::flag_set("3rd_floor_enemies_dead");
    return;
  }
}

function buddy_down_dialogue() {
  scripts\engine\utility::flag_wait_either("buddy_down_price_dialogue", "buddy_down_skip");

  if(!scripts\engine\utility::flag("buddy_down_skip")) {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_bedroom_20");
    wait 1;
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_3rd_floor_bedroom_30");
    wait 0.1;
    scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_3rd_floor_bedroom_40");
  } else {
    scripts\engine\utility::flag_wait("player_in_buddy_down_room");
  }

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_pri_3rd_floor_bedroom_50");
}

function buddy_down_price_anim() {}

function buddy_down_two_enemy_dead_thread(var0) {
  while(any_alive(var0)) {
    wait 0.1;
  }
}

function any_alive(var0) {
  foreach(var2 in var0) {
    if(isalive(var2)) {
      return true;
    }
  }

  return false;
}

function get_first_living_in_array(var0) {
  foreach(var2 in var0) {
    if(isalive(var2)) {
      return var2;
    }
  }
}

function third_floor_buddy_down_drag(var0, var1) {
  var2 = "buddy_down_drag";
  var3 = getEnt("3rd_floor_door_playerclip", "targetname");
  var3 solid();
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  var4 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  thread go_to_3rd_floor_stairtain(var4);
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop(var1, var2);
  var1 = scripts\engine\utility::array_add(var1, var4);

  foreach(var6 in var1) {
    if(var6.animname == "bravo4_1") {
      var7 = scripts\sp\door::get_interactive_door("buddydown_door");
      var7 scripts\sp\door::add_pushent(var6);
    }
  }

  waitframe();
  var9 = 1.7;

  foreach(var6 in var1) {
    var11 = var9 / getanimlength(var6 scripts\engine\utility::getanim(var2));
    var6 setanimtime(var6 scripts\engine\utility::getanim(var2), var11);
    var6 setanimrate(var6 scripts\engine\utility::getanim("buddy_down_drag"), 0);
  }

  third_floor_view_exit();

  foreach(var6 in var1) {
    var6 setanimrate(var6 scripts\engine\utility::getanim("buddy_down_drag"), 1);
  }
}

function third_floor_view_exit() {
  var0 = getEnt("3rdfloor_exit_failsafe", "targetname");
  var0 endon("trigger");
  var1 = scripts\engine\utility::getStruct("3rd_floor_view_exit", "targetname");

  for(;;) {
    var2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var2, level.player getplayerangles(), var1.origin, 0.939693) && sighttracepassed(var2, var1.origin, 0, level.player)) {
      break;
    }

    waitframe();
  }
}

function buddy_down_skip_post_clear(var0, var1) {
  var2 = "buddy_down_drag";
  scripts\engine\sp\utility::array_spawn_targetname("bravo4_reinforcements", 1);
  var3 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  thread go_to_3rd_floor_stairtain(var3);

  foreach(var5 in var1) {
    if(var5.animname == "bravo4_1" || var5.animname == "bravo4_2") {
      var6 = scripts\engine\utility::getStruct("temp_" + var5.animname + "_3rd_floor_teleport", "targetname");
      var5.script_pushable = 0;
      var7 = scripts\engine\utility::drop_to_ground(var6.origin, 10, -100);
      var5 forceteleport(var7, var6.angles);
      var5 setgoalpos(var7);
      var5.uprightcqbidle = 1;
      var5.goalradius = 4;
      var5.fixednode = 0;
      var5 scripts\common\ai::set_gunpose("gun_down");
      continue;
    }

    var0 thread scripts\common\anim::anim_loop_solo(var5, "buddy_down_drag_loop");
  }
}

function buddy_down_damage_thread() {
  var0 = getEnt("buddy_down_damage_trigger", "targetname");
  thread buddy_down_trigger_damage_ondamage();
  thread buddy_down_trigger_damage_onflashbang();

  for(;;) {
    var0 waittill("trigger", var1);
  }

  LOC_0000003d:
    var2 = scripts\engine\sp\utility::get_living_ai("buddy_down_enemy", "script_noteworthy");
  var3 = scripts\engine\sp\utility::get_living_ai("buddy_down_gunner", "script_noteworthy");

  if(var0.triggertype == "frag") {
    if(isalive(var2)) {
      if(var2.damageshield) {
        var2.damageshield = 0;
      }

      var2 kill();
    }

    if(isalive(var3)) {
      if(var3.damageshield) {
        var3.damageshield = 0;
      }

      var3 kill();
    }
  } else if(var0.triggertype == "flash") {
    if(isalive(var2)) {
      var2 scripts\sp\maps\townhoused\townhoused_code::force_flash();
    }

    if(isalive(var3)) {
      var3 scripts\sp\maps\townhoused\townhoused_code::force_flash();
    }
  }

  var0 delete();
}

function buddy_down_door_damage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(scripts\engine\utility::flag("buddy_down_skip")) {
    return;
  }

  if(scripts\engine\utility::flag("shoot_buddy_down")) {
    return;
  }

  if(!isDefined(var1)) {
    return;
  }

  if(var1 == level.player) {
    thread buddy_down_player_engaging_early();
    return;
  }
}

function buddy_down_player_engaging_early() {
  if(scripts\engine\utility::flag("buddy_down_player_engaging_early")) {
    return;
  }

  scripts\engine\utility::flag_set("buddy_down_player_engaging_early");
  var0 = scripts\engine\sp\utility::get_living_ai("bravo4_1", "animname");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_a11_stairtrain2_rally_60");
  wait 1;
  var1 = scripts\engine\sp\utility::get_living_ai("bravo4_2", "animname");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_a12_stairtrain2_rally_70");
}

function buddy_down_trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9) && var9.basename == "frag" && ispointinvolume(var3, self)) {
      self.triggertype = "frag";
      var10 = scripts\sp\door::get_interactive_door("buddydown_door");
      var10 scripts\sp\door_scriptable::scriptable_damage_proc(200, var1, var2, level.player.origin, var4);
    }
  }
}

function buddy_down_trigger_damage_onflashbang() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var0, var1, var2, var3);
    self.triggertype = "flash";
    self notify("trigger");
  }
}

function post_stairtrain_anim(var0, var1, var2) {
  if(scripts\engine\utility::ent_flag_exist("stairtrain_on")) {
    if(scripts\engine\utility::ent_flag("stairtrain_on")) {
      scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
    }
  }

  if(isDefined(var2)) {
    var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_door(var2, var1);
  }

  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, var1, undefined, "stop_loop_" + self.animname);
}

function go_to_3rd_floor_stairtain(var0) {
  var1 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");

  if(scripts\engine\utility::flag("buddy_down_skip")) {
    var1 thread scripts\common\anim::anim_loop_solo(self, var0 + "_loop", "stop_arrive_3rd_floor_stairtrain");
  } else {
    var1 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, var0, undefined, "stop_arrive_3rd_floor_stairtrain");
  }

  scripts\engine\utility::flag_wait("player_near_stairtrain3");
  var1 notify("stop_arrive_3rd_floor_stairtrain");
  thread stairtrain3_setup();
}

function postspawn_bravo4_reinforcement() {
  scripts\sp\maps\townhoused\townhoused_code::postpawn_friendly_shared();
  scripts\sp\maps\townhoused\townhoused_code::force_nvg("on");

  if(self.animname == "bravo4_4") {
    self.ignoreall = 1;
    self.ignoreme = 1;

    if(level.start_point == "4th_floor") {
      return;
    }

    return;
  }
}

function postspawn_buddy_down_enemy() {
  thread third_floor_death_counter(1);
  scripts\engine\sp\utility::disable_surprise();
  self.grenadeawareness = 0;
  self.animname = "buddy_down_enemy";

  if(istrue(level.demo)) {
    scripts\sp\spawner::go_to_node(self.go_to_node);
    scripts\engine\sp\utility::set_generic_deathanim("demo_shotgun_death");
    return;
  }
}

function postspawn_buddy_down_gunner() {
  self endon("death");
  self.nofacialfiller = 1;
  thread third_floor_death_counter(1);

  if(istrue(level.demo)) {
    scripts\anim\shared::forceuseweapon("iw8_ar_akilo47", "primary");
    self.sidearm = isundefinedweapon();
  }

  self.animname = "buddy_down_gunner";
  self.damageshield = 1;
  thread buddy_down_gunner_damage_thread();
  thread buddy_down_gunner_flashed_thread();
  thread scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aq2_3rd_floor_bedroom_91");
  self.grenadeawareness = 0;
  scripts\engine\sp\utility::disable_surprise();
  level endon("buddy_down_skip");
  thread buddy_down_enemydead_interrupt(level);
  scripts\engine\utility::flag_wait("shoot_buddy_down_vo");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_10");
  scripts\engine\utility::flag_wait("shoot_buddy_down");
  thread enemy_shoot_buddy_down_door(level);
}

function buddy_down_enemydead_interrupt(var0) {
  level endon("shoot_buddy_down");
  scripts\engine\utility::flag_wait("buddy_down_enemy_dead");

  if(isalive(var0) && var0.health > 1) {
    return;
  }

  scripts\engine\utility::flag_set("buddy_down_skip");
}

function buddy_down_skip_setup() {
  self.blendtoai["flag"] = "buddy_down_skip";
  self.blendtoai["blendTime"] = 0.3;
  self.blendtoai["endfunc"] = &buddy_down_skip_move;
  self.scriptedthread = &blend_to_ai;
}

function buddy_down_skip_move() {
  var0 = scripts\engine\utility::getStruct("buddy_down_animnode", "targetname");
  var0 notify("stop_buddy_down_loop");
  self setgoalpos(self.origin);
  wait 0.5;
  var1 = getnode("3rdfloor_stairs_" + self.animname, "targetname");
  self.goalradius = 32;
  self setgoalnode(var1);
}

#using_animtree("");

function blend_to_ai() {
  var0 = self.codescripted["anim"];
  var1 = [%add_idle, $aim_graft_node, %gun_down_stand];
  var2 = [%sdr_com_exposed_twitch01, %sdr_com_exposed_aim_4, %sdr_com_exposed_stand_gun_down];
  scripts\engine\utility::flag_wait(self.blendtoai["flag"]);
  var3 = self.blendtoai["blendTime"];
  var4 = scripts\asm\asm::asm_lookupanimfromalias("exposed_idle", "rifle_aim_5");
  var5 = scripts\asm\asm::asm_getxanim("exposed_idle", var4);
  self setflaggedanim("whatever", var5, 1, var3);
  self.gunposeoverride = "disable";

  foreach(var7 in var1) {
    self setanimknob(var7, 1, var3);
  }

  foreach(var10 in var2) {
    self setanimlimited(var10, 1, 0);
  }

  self clearanim(%scripted, var3);
  self setanimrate(var0, 0);
  scripts\anim\notetracks_sp::notetrackvisorlower_instant();
  wait var3;

  if(isDefined(self.blendtoai["endfunc"])) {
    self thread[[self.blendtoai["endfunc"]]]();
  }

  self.uprightcqbidle = 1;
  scripts\engine\utility::set_movement_speed(20);
  scripts\engine\sp\utility::anim_stopanimScripted();
}

function fake_animScripted() {
  self animmode("noclip");
  self setanim(self.fake_animation, 1, 1);
  self waittillmatch("fake_animscripted", "end");
}

function buddy_down_gunner_damage_thread() {
  var0 = self.health;

  while(var0 > 0) {
    self waittill("damage", var1);
    var0 -= var1;
  }

  if(!isalive(self)) {
    return;
  }

  self.damageshield = 0;
  self.health = 1;

  if(!buddy_down_gunner_death()) {
    self kill();
    return;
  }
}

function buddy_down_gunner_death() {
  var0 = get_buddy_down_gunner_animnode();

  if(isDefined(self.flashed_animnode)) {
    self.flashed_animnode notify("stop_loop");
    var0 = self.flashed_animnode;
  }

  if(isDefined(var0)) {
    self.animname = "generic";
    var1 = getstartangles(var0.origin, var0.angles, scripts\engine\utility::getanim("gunner_couch_death"));

    if(abs(self.angles[1] - var1[1]) > 15) {
      return false;
    }

    self.allowdeath = 1;
    self.skipdeathanim = 1;
    scripts\sp\maps\townhoused\townhoused_code::enable_death_clearscriptedanim();
    self notify("stop_fake_flash");
    thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq2_3rd_floor_bedroom_92");
    self actoraimassistoff();
    third_floor_death_counter();
    var2 = getstartorigin(var0.origin, var0.angles, scripts\engine\utility::getanim("gunner_couch_death"));
    var3 = var0.origin - var2;
    var4 = scripts\engine\utility::spawn_script_origin(self.origin + var3, var0.angles);
    self linkTo(var4);
    var4 moveTo(var0.origin, 1);
    var4 scripts\common\anim::anim_single_solo(self, "gunner_couch_death");
    var4 delete();

    if(isalive(self)) {
      self kill();
    }

    return true;
  }

  return false;
}

function get_buddy_down_gunner_animnode() {
  var0 = 12;
  var1 = scripts\engine\utility::getStruct("buddy_down_gunner_animnode", "targetname");
  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  var3 = [var1.origin, var2.origin];
  var4 = [];
  GscBinSkip0(0x2e, var4.size, var3);
}

function buddy_down_gunner_flashed_thread() {
  self endon("death");
  self endon("stop_fake_flash");
  self waittill("flashed");
  var0 = get_buddy_down_gunner_animnode();
  self.flashed_animnode = var0;
  var0 scripts\common\anim::anim_generic(self, "fake_flash");
  var0 thread scripts\common\anim::anim_generic_loop(self, "fake_flash_idle");
  player_cansee_buddy_down_flashed();
  var0 notify("stop_loop");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_enemy_wait_10");
  var0 scripts\common\anim::anim_generic(self, "fake_flash_react");
}

function player_cansee_buddy_down_flashed() {
  self endon("stop_animmode");
  var0 = gettime() + 3000;

  while(gettime() < var0) {
    waitframe();
    var1 = self gettagorigin("tag_eye");
    var2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var2, level.player getplayerangles(), var1, 0.939693) && sighttracepassed(level.player getEye(), var1, 0, level.player)) {
      break;
    }
  }
}

function enemy_shoot_buddy_down_door(var0) {
  level endon("buddy_down_grenade_explode");
  var0 endon("death");
  var1 = scripts\engine\utility::getStruct("enemy_buddy_shoot_door", "targetname");
  var2 = spawn("script_origin", var1.origin);
  var0.dontevershoot = 1;
  var0 setentitytarget(var2);
  thread third_floor_frame_pulse(var0);
  level.player setsoundsubmix("sp_th_buddy_down_npc_guns_down");
  thread sfx_buddy_down_fire_volley();
  thread sfx_buddy_down_debris();

  for(;;) {
    var3 = var0 gettagorigin("tag_flash");
    magicbullet(var0.primaryweapon, var3, var1.origin, var0);
    magicbullet(var0.primaryweapon, var3, var1.origin, var0);
    var4 = vectorNormalize(var1.origin - var3);
    var5 = var1.origin + var4 * 3;
    var6 = var3 + var4 * 200;
    magicbullet(var0.primaryweapon, var5, var6, var0);
    wait randomfloatrange(0.05, 0.15);
    var1 = scripts\engine\utility::getStruct(var1.target, "targetname");
    var2.origin = var1.origin;
  }

  LOC_00000118:
    var0 clearentitytarget();
  wait 1;
  var0.dontevershoot = 0;
  var1 = scripts\engine\utility::getStruct("enemy_buddy_shoot_door_post", "targetname");
  var2.origin = var1.origin;
  var2 makeentitysentient("allies");
  var2 setthreatbiasgroup("allies");
  var0.favoriteenemy = var2;
  wait 2;
  var2 delete();
}

function sfx_buddy_down_fire_volley() {
  self playSound("scn_buddy_down_npc_fire_lr");
}

function sfx_buddy_down_debris() {
  thread scripts\engine\utility::play_sound_in_space("scn_buddy_down_npc_fire_door_lr", (174, 1037, -136));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("scn_buddy_down_door_debris", (215, 1010, -153));
}

function third_floor_frame_pulse(var0) {
  var0 endon("death");
  wait 0.5;
  var1 = getEnt("buddy_down_picture", "targetname");
  var2 = anglesToForward(var1.angles) * 1;
  var1 physicslaunchserver(var1.origin + (0, 0, randomfloatrange(-5, 5)), var2);
  wait 0.25;
  var1 = getEnt(var1.target, "targetname");
  var2 = anglesToForward(var1.angles) * 1;
  var1 physicslaunchserver(var1.origin + (0, 0, randomfloatrange(-5, 5)), var2);
}

function postspawn_hiding_door_enemy() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("hiding_door_animnode", "targetname");
  self.animname = "generic";
  self.primaryweapon = isundefinedweapon();
  scripts\anim\shared::forceuseweapon(self.sidearm, "secondary");
  var1 = scripts\sp\door::get_interactive_door("hiding_door");
  var1 scripts\sp\door::remove_open_ability();
  var1.tagent = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
  var1.tagent scripts\engine\sp\utility::assign_animtree("door");
  var0 scripts\common\anim::anim_first_frame_solo(self, "python_enter");
  var0 scripts\common\anim::anim_first_frame_solo(var1.tagent, "python_enter");
  wait 0.1;
  var1.startyaw = var1.angles[1];
  var1 linkTo(var1.tagent);
  thread hiding_door_model(var1);
  thread hiding_door_enemy_dead_dialogue();
  python_enter(var0, var1);
}

function python_enter(var0, var1) {
  self.nofacialfiller = 1;
  thread third_floor_death_counter(1);
  favela_door_trigger();
  thread audio_python_open_filter();
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_102");
  wait randomfloatrange(0.05, 0.3);

  if(self.health == 150) {
    self.health -= 20;
  }

  thread hiding_door_enemy_death_dialogue();
  self.diequietly = 1;
  thread hiding_door_anim_thread();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_long_death(self, "python_enter", 1, &python_longdeath_callback);
  var0 scripts\common\anim::anim_single([self, var1.tagent], "python_enter");
}

function hiding_door_anim_thread() {
  self waittillmatch("single anim", "end");
  self notify("stop_open_door_on_death");

  if(isDefined(self.tagent)) {
    self.tagent delete();
  }

  thread hiding_door_make_pushable();
}

function python_longdeath_callback() {
  third_floor_death_counter();
  var0 = 0;

  if(isDefined(self.damageweapon) && weaponclass(self.damageweapon) == "spread") {
    var1 = ["torso_upper", "head", "helmet", "neck", "left_arm_upper", "torso_lower"];
  } else {
    var1 = ["torso_upper", "head", "helmet", "neck", "left_arm_upper"];
  }

  foreach(var3 in var1) {
    if(self.damagelocation == var3) {
      return true;
    }
  }

  self.skipdeathanim = undefined;
  self.allowdeath = 1;
  self kill();
  var5 = level.player;

  if(isDefined(self.lastattacker)) {
    var5 = self.lastattacker;
  }

  self dodamage(10, var5.origin, var5, var5, self.damagemod, self.damageweapon);
  return false;
}

function hiding_door_enemy_death_dialogue() {
  self waittill("longdeath");
  self stopsounds();
  waitframe();
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_104");
  self waittill("death");
  self stopsounds();
}

function audio_python_open_filter() {
  wait 0.8;
  level.player clearallsoundsubmixes(0.8);
}

function favela_door_trigger() {
  level endon("buddy_down_favela_guy_too_close");
  level.player setsoundsubmix("sp_th_python_scream");
  scripts\engine\utility::flag_wait_or_timeout("buddy_down_favela_guy", 7);
  var0 = scripts\engine\utility::getStruct("favela_door_lookat", "targetname");
  var1 = cos(20);

  while(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin, var1)) {
    waitframe();
  }
}

function favela_door(var0, var1) {
  var2 = ["peak", "fire3"];
  var3 = 0;
  favela_door_trigger();

  for(;;) {
    var0 thread scripts\common\anim::anim_loop_solo(self, "faveladoor_idle");

    if(!var3 == 0) {
      wait 0.1;
    } else {
      wait randomfloatrange(0.3, 4);
    }

    var4 = "peak";

    if(var3 < 2) {
      var4 = var2[var3];
      var3++;
    } else if(randomint(100) > 40) {
      var5 = randomintrange(1, 3);
      var4 = "fire" + var5;
    } else if(randomint(100) > 40) {
      var4 = "idle";
    }

    var0 notify("stop_loop");
    self stopanimScripted();

    if(var4 != "idle") {
      var0 scripts\common\anim::anim_single([self, var1.tagent], "faveladoor_" + var4);
      var6 = 1;
    }

    waitframe();
  }
}

function hiding_door_model(var0) {
  self endon("stop_open_door_on_death");
  var0 waittill("death");
  self unlink();

  if(isDefined(self.tagent)) {
    self.tagent delete();
  }

  thread hide_door_rotate();
}

function hide_door_rotate() {
  var0 = angleclamp(self.startyaw + 115);
  var1 = abs(var0 - angleclamp(self.angles[1]));
  var2 = var1 / 60;
  var3 = self.pivots["open_left"].origin - self.og_origin;
  var4 = rotatevector(var3, self.angles - self.true_start_angles);
  scripts\sp\maps\townhoused\townhoused_code::temp_scriptablerotateTo((0, var0, 0), var2, 0, var2, var3);
  thread hiding_door_make_pushable();
}

function hiding_door_make_pushable() {
  if(isDefined(self.scripted_ispushable)) {
    return;
  }

  self.scripted_ispushable = 1;
  var0 = self.pivots["open_left"].origin - self.og_origin;
  var1 = rotatevector(var0, self.angles - self.true_start_angles);
  self.pivot_ent = scripts\engine\utility::spawn_script_origin(self.origin + var1, self.angles);
  self linkTo(self.pivot_ent);
  self.hinge_side = "open_left";
  self.forward = anglesToForward(self.pivot_ent.angles);
  thread scripts\sp\door_internal::monitor_door_push(0);
  scripts\sp\door_internal::waittill_second_interact_or_bash();
  scripts\sp\door::remove_open_ability();
}

function hiding_door_enemy_dead_dialogue() {
  thread scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aq6_3rd_floor_bedroom_103");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq6_3rd_floor_bedroom_100");
  self waittill("death");
  scripts\engine\utility::flag_set("3rd_floor_bedroom_enemy_dead");
}

function stairtrain3_setup() {
  if(!isDefined(level.temp_stairtrain_count)) {
    level.temp_stairtrain_count = 0;
  }

  var0 = scripts\engine\utility::getStruct("stairtrain3_animnode", "targetname");
  level.temp_stairtrain_count++;

  if(level.temp_stairtrain_count == 2) {
    level.temp_stairtrain_count = undefined;
    var1 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var2 = [level.price, var1];
    var0 notify("stop_first_frame");
    var3 = undefined;

    foreach(var5 in var2) {
      if(isDefined(var3)) {
        var3 scripts\sp\stairtrain::set_prevguy(var5);
      }

      var3 = var5;
      var5.animnode = var0;
      var5 scripts\engine\sp\utility::anim_stopanimScripted();
      var5 thread scripts\asm\asm_sp::asm_animcustom(&scripts\sp\maps\townhoused\townhoused_code::stairtrain3_animcustom);
    }

    wait 2.1;
    level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_stairtrain3_rally_90");
    return;
  }
}

function fourth_floor_movement() {
  var0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  thread post_stairtrain_anim(level.price, var0);
  thread fourth_floor_price_anim();
  thread fourth_floor_price_movement();
  var1 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
  var2 = scripts\sp\door::get_interactive_door("4thfloor_bathroom_door");
  var2 scripts\engine\sp\utility::assign_animtree("door");
  var0 = scripts\engine\utility::getStruct("4thfloor_bathroom_animnode", "targetname");
  post_stairtrain_anim(var1, var0, "baby_mom_arrive", var2);
  scripts\engine\utility::flag_set("fourth_floor_bravo4_4_ready");
}

function fourth_floor_price_anim() {
  level.price waittillmatch("single anim", "end");
  var0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  var0 notify("stop_loop_" + level.price.animname);

  if(!scripts\engine\utility::flag("baby_mom_go") && scripts\sp\maps\townhoused\townhoused_code::isscriptedalive(level.baby_mom)) {
    level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_4th_floor_bedroom_20");
  }

  var0 scripts\common\anim::anim_single_solo(level.price, "baby_mom_breakdown");
  var1 = "baby_mom_breakdown_idle";
  var2 = "baby_mom_breakdown_nag";
  var3 = [];
  GscBinSkip0(0x2e, var3.size, "dx_vom_pri_4th_floor_bedroom_40");
}

function fourth_floor_door() {
  var0 = scripts\sp\door::get_interactive_door("baby_room_door");
  var0.fndamage = &baby_door_ondamage;
  var1 = angleclamp180(var0.angles[1]);

  for(;;) {
    if(var0 scripts\sp\maps\townhoused\townhoused_code::door_angle_check(var1, 20)) {
      break;
    }

    if(scripts\sp\maps\townhoused\townhoused_code::isscriptedalive(level.baby_mom)) {
      var2 = level.baby_mom gettagorigin("tag_eye");

      if(sighttracepassed(level.player getEye(), var2, 0, level.player)) {
        break;
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("baby_mom_go");
  level.player clearallsoundsubmixes();
}

function baby_door_ondamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(var0 == 0) {
    return;
  }

  scripts\engine\utility::flag_set("baby_mom_go");
  self.fndamage = undefined;
}

function fourth_floor_clear_nag() {
  var0 = scripts\sp\door::get_interactive_door("baby_room_exit");

  if(var0.ajar || var0.bashed) {
    return;
  }

  var0 endon("ajar");
  var0 endon("bashed");

  if(scripts\sp\maps\townhoused\townhoused_code::isscriptedalive(level.baby_mom)) {
    scripts\engine\utility::waittill_any_ents(level.baby_mom, "death", level, "finished_baby_mom_vo");
  } else {
    wait 5;
  }

  var1 = ["dx_vom_pri_3rd_floor_bedroom_110", "dx_vom_pri_3rd_floor_bedroom_120", "dx_vom_pri_3rd_floor_bedroom_130"];
  level.price scripts\sp\maps\townhoused\townhoused_code::radio_nag(var1, undefined, 12, 15);
}

function baby_cry() {
  scripts\engine\utility::flag_wait("start_baby_cry");
  level.player setsoundsubmix("sp_th_baby_cry");
  var0 = getEnt("baby", "targetname");
  var0 playLoopSound("scn_townhouse_baby_cry_lp");
  var0 endon("damage");
  var1 = var0.origin[2];
  var2 = 84;
  var3 = 0.05;
  var4 = 0;
  var5 = 0;

  for(;;) {
    wait var3;
    var6 = level.player.origin[2] - var1;
    var6 = scripts\engine\math::round_float(var6, 4);

    if(var6 < 0) {
      continue;
    }

    if(var4 == var6) {
      continue;
    }

    var4 = var6;
    var7 = var6 / var2;
    var7 = min(var7, 1);

    if(var5 == var7) {
      continue;
    }

    var5 = var7;
    var8 = scripts\engine\math::factor_value(1, 0.01, var7);
    var0 scalevolume(var8, var3);
  }
}

function baby_cry_hard() {
  self endon("death");
  wait 1;
  level.babycry_hard_start = gettime();
  self playLoopSound("scn_townhouse_baby_cry_hard_lp");
}

function baby_death() {
  self setCanDamage(1);
  self.health = 100;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isPlayer(var1)) {
      if(var9.basename == "flash" && distancesquared(var3, self.origin) > 300) {
        continue;
      }

      break;
    }
  }

  if(isalive(self.mom)) {
    self.mom setCanDamage(0);
  }

  self.health = 1;
  self stoploopsound();
  var10 = getdvarint("townhoused_baby_deaths", 0);
  var10++;
  setDvar("townhoused_baby_deaths", var10);
  var11 = 0;

  if(isalive(self.mom)) {
    var11 = 1;
    self notify("damage", 100, level.player);
  }

  if(var10 > 2) {
    scripts\sp\player_death::set_custom_death_quote(21);
    scripts\sp\analytics::analytics_obj_failed();
    level.missionfailed = 1;
    scripts\engine\utility::flag_set("missionfailed");
    thread scripts\sp\player_death::set_death_hint();
    level.player shellshock("default", 10);
    setblur(5, 1);
    setslowmotion(1, 0.5, 1);
    changelevel("", 0, 2);
  } else {
    scripts\sp\player_death::set_custom_death_quote(7);
  }

  scripts\sp\hud_util::fade_out(0);
  scripts\sp\utility::missionfailedwrapper();
}

function postspawn_baby_mom() {
  self endon("death");
  self.allowdeath = 1;
  self.skipdeathanim = 1;
  self.team = "neutral";
  scripts\common\ai::gun_remove();
  self.nofacialfiller = 1;
  self.scriptedisalive = 1;
  scripts\engine\utility::ent_flag_init("can_fastforward");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach(scripts\engine\sp\utility::getmodel(self.animname + "_head"));
  thread baby_mobile_stay_active();
  thread baby_mom_death_cleanup();
  thread scripts\sp\maps\townhoused\townhoused_code::do_sound_on_death("dx_vom_aqf3_4th_floor_bedroom_98");
  level.baby_mom = self;
  var0 = getEnt("baby", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("baby");
  self.baby = var0;
  var0.mom = self;
  thread baby_death();
  thread baby_mom_ondamage();
  var1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var1 scripts\common\anim::anim_first_frame([self, self.baby], "grab_baby");
  scripts\engine\utility::flag_wait("baby_mom_go");
  thread baby_mom_add_collision_head();
  thread scripts\sp\maps\townhoused\townhoused_code::train_go("south");
  baby_mom_anim();
}

function baby_mom_clear_damageshield() {
  self.damageshield = 0;
}

function baby_mom_ondamage() {
  self endon("stop_ondamage");
  self.damageshield = 1;

  while(self.damageshield) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9) && var9.basename == "flash") {
      if(self.health > 0) {
        self.health += var0;
      }

      continue;
    }

    if(isDefined(var4) && var4 == "MOD_MELEE") {
      continue;
    }

    if(var1 != level.player) {
      continue;
    }

    if(scripts\engine\utility::flag("baby_picked_up")) {
      baby_mom_playdeath();
      return;
    }

    self.damageshield = 0;
    self dodamage(var0, var1 getEye(), var1, undefined, var4, var9);
  }
}

function baby_mom_playdeath() {
  self.scriptedisalive = 0;
  self notify("scripted_death");
  var0 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");

  if(scripts\engine\utility::ent_flag("can_fastforward")) {
    var1 = scripts\engine\utility::getanim("grab_baby");
    var2 = self.baby scripts\engine\utility::getanim("grab_baby");
    var3 = self getanimtime(var1);
    var4 = getnotetracktimes(var1, "can_die");
    var5 = var4[0];

    if(var3 < var5) {
      self setanimrate(var1, 2.5);
      self.baby setanimrate(var2, 2.5);
      self waittillmatch("single anim", "can_die");
    }
  }

  self.baby scripts\engine\sp\utility::anim_stopanimScripted();
  var0 thread scripts\common\anim::anim_single_solo(self.baby, self.deathanime);
  self.skipdeathanim = 1;
  var0 scripts\common\anim::anim_single_solo(self, self.deathanime);
  self.diequietly = 1;
  var6 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");

  if(self.deathanime == "grab_baby_stand_death") {
    if(isDefined(var6.momdeathreact_anime)) {
      if(var6.momdeathreact_anime == "grab_baby_death_interrupt") {
        thread baby_idle_relative(self.baby);
        self.diequietly = 1;
        scripts\sp\maps\townhoused\townhoused_anim::kill_me_no_anim(self);
        return;
      }
    }

    var7 = "grab_baby_pickup_early";
    self.baby thread scripts\sp\maps\townhoused\townhoused_anim::baby_pickup_by_allyanim(var0, var7);
    var0 thread scripts\common\anim::anim_single_solo(self, var7);
    var6 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var3 = var6 getanimtime(var6 scripts\engine\utility::getanim(var7));

    if(var3 > 0) {
      waitframe();
      self setanimtime(scripts\engine\utility::getanim(var7), var3);
      var8 = getanimlength(var6 scripts\engine\utility::getanim(var7)) * var3;
      var9 = var8 / getanimlength(self.baby scripts\engine\utility::getanim(var7));
      self.baby setanimtime(self.baby scripts\engine\utility::getanim(var7), var9);
      return;
    }

    return;
  }
}

function baby_mom_add_collision_head() {
  self.linkedents = [];
  self.linkedents["head"] = scripts\sp\maps\townhoused\townhoused_code::quick_spawn_model("collision_head");
  self.linkedents["head"] linkTo(self, "j_head", (0, 0, 0), (0, 0, 0));
}

function baby_mom_prior_dialog() {
  level endon("baby_mom_go");
  var0 = scripts\engine\utility::getStruct("fake_bed_guy_vo", "targetname");
  var1 = scripts\engine\utility::spawn_script_origin(var0.origin);
  var1.animname = "tempEnt_guy";
  var0 = scripts\engine\utility::getStruct("fake_baby_mom_vo", "targetname");
  var2 = scripts\engine\utility::spawn_script_origin(var0.origin);
  var2.animname = "tempEnt_girl";
  scripts\engine\utility::flag_wait("half_up_3f_stairs");
  thread stopsounds_on_notify(var2);
  baby_mom_prior_dialog_internal(var1, var2);
  scripts\engine\utility::flag_wait("stairtrain3_done");
  wait 1;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_50");
  var2 playSound("dx_vom_aqf3_4th_floor_aq_convo5_60");
}

function stopsounds_on_notify(var0) {
  scripts\engine\utility::waittill_any_ents(self, var0, level, var0);
  self stopsounds();
}

function baby_mom_prior_dialog_internal(var0, var1) {
  if(scripts\engine\utility::flag("stairtrain3_done")) {
    return;
  }

  level endon("stairtrain3_done");
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_aq_convo5_10");
  wait 0.5;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_20");
  wait 0.2;
  var1 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_aq_convo5_30");
  wait 0.6;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aq4_4th_floor_aq_convo5_40");
}

function baby_mom_death_cleanup() {
  scripts\engine\utility::waittill_either("death", "scripted_death");

  if(!scripts\engine\utility::flag("baby_picked_up")) {
    thread baby_idle_relative();
  }

  if(isDefined(self.linkedents)) {
    self.linkedents = scripts\engine\utility::array_removeundefined(self.linkedents);

    foreach(var1 in self.linkedents) {
      var1 delete();
    }

    return;
  }
}

function baby_idle_relative(var0) {
  self endon("death");
  self clearanim(scripts\engine\utility::getanim("root"), 0.2);
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(!isDefined(var0)) {
    var0 = "baby_idle";
  }

  var1 = scripts\engine\utility::getanim(var0);
  var2 = getanimlength(var1);

  if(isDefined(level.babycry_hard_start)) {
    var3 = 0;
    var4 = (gettime() - level.babycry_hard_start) * 0.001;
    var4 %= var2;
    var5 = var4 / var2;
    self setflaggedanim("baby_idle_anim", var1, 0.1);
    self setanimtime(var1, var5);
  }

  thread baby_blend_idle(var1);
}

function baby_blend_idle(var0) {
  var1 = 40;
  var2 = 0.05;
  var3 = 0;

  for(var4 = 0; var4 < var1; var4++) {
    waitframe();
    var3 = var4 * var2;
    self setanim(var0, var3);
  }

  self setanim(var0, 1);
}

function print_notetrack() {
  for(;;) {
    self waittill("baby_idle_anim", var0);
  }
}

function baby_mobile_stay_active() {
  var0 = getEnt("baby", "targetname");
  var1 = var0.origin + (0, 0, 30);

  for(;;) {
    wait 2;
    radiusdamage(var1, 25, 1, 0, undefined, "MOD_RIFLE_BULLET", undefined, 1);
  }
}

function baby_mom_anim() {
  self endon("death");
  self endon("scripted_death");
  var0 = scripts\sp\maps\townhoused\townhoused_anim::baby_mom_anim_random();
  var1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var2 = undefined;

  if(var0 == "grab_baby") {
    var2 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var2 scripts\engine\utility::ent_flag_waitopen("stairtrain_on");

    if(!scripts\engine\utility::flag("fourth_floor_bravo4_4_ready")) {
      waitframe();
      var3 = scripts\sp\door::get_interactive_door("4thfloor_bathroom_door");
      var4 = 5;
      var3 setanimrate(var3 scripts\engine\utility::getanim("baby_mom_arrive"), var4);
      var2 setanimrate(var2 scripts\engine\utility::getanim("baby_mom_arrive"), var4);
    }

    scripts\engine\utility::flag_wait("fourth_floor_bravo4_4_ready");
    var5 = scripts\engine\utility::getStruct("4thfloor_bathroom_animnode", "targetname");
    var5 notify("stop_loop_" + var2.animname);
    var2.linkedents["head"] = scripts\sp\maps\townhoused\townhoused_code::quick_spawn_model("collision_head");
    var2.linkedents["head"] linkTo(var2, "j_head", (0, 0, 0), (0, 0, 0));
    var2 scripts\engine\sp\utility::anim_stopanimScripted();
    var2.uprightcqbidle = 1;
    thread baby_mom_death_react(var2);
    var2 = scripts\engine\sp\utility::get_living_ai("bravo4_4", "animname");
    var6 = [var2, self];
    thread baby_mom_dialog(level, self);
  } else {
    var6 = [self];
  }

  var7 = scripts\sp\maps\townhoused\townhoused_anim::baby_mom_anim_get(var1);
  scripts\engine\utility::flag_set("baby_mom_playerclip");
  var8 = var6;
  var8 = scripts\engine\utility::array_add(var6, self.baby);
  self.baby.state = "intro";
  var2 thread scripts\common\anim::anim_single(var8, var7.startanime);
  var9 = var7.idleanime;
  var10 = undefined;

  if(isDefined(var7.fnanimbranch)) {
    self.team = "axis";

    if(![[var7.fnanimbranch]]()) {
      var10 = var7.startanime_a;
    } else {
      var10 = var7.startanime_b;
      var9 = var7.idleanime_b;
    }
  }

  var2 waittill(var7.startanime);
  scripts\engine\utility::ent_flag_clear("can_fastforward");

  if(isDefined(var10)) {
    var2 scripts\common\anim::anim_single(var8, var10);
  }

  thread baby_mom_idle_react(var2, var7);
  self.baby.state = "idle";
  var8 = [self, self.baby];
  var2 thread scripts\common\anim::anim_loop(var8, var7.idleanime, "stop_baby_mom_idle");
  var2 thread scripts\common\anim::anim_loop_solo(var6, var7.idleanime, "stop_loop_bravo4_4");
}

function highlight_all_ents(var0) {
  for(;;) {
    if(isDefined(var0)) {
      var1 = var0;
    } else {
      var1 = getEntArray();
    }

    foreach(var3 in var1) {
      if(!isDefined(var3) || !isDefined(var3.targetname)) {}
    }

    waitframe();
  }
}

function stop_sounds_on_death() {
  scripts\engine\utility::waittill_either("death", "scripted_death");
  waitframe();
  self stopsounds();
}

function baby_mom_dialog(var0, var1) {
  level.player endon("death");
  var0 endon("death");
  var0 endon("scripted_death");
  thread stop_sounds_on_death();
  wait 0.6;
  level.player thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_73");
  wait 4.6;
  var1 thread scripts\engine\sp\utility::smart_dialogue("dx_vom_a12_4th_floor_bedroom_72");
  wait 0.4;
  var2 = getEnt("baby", "targetname");
  var3 = distance2dsquared(level.player.origin, var2.origin) < 30000;
  var4 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var2.origin, cos(15));

  if(var3 && var4) {
    level.player thread scripts\engine\sp\utility::player_gesture_combat("ges_baby_handsup", var2);
  }

  wait 1.4;
  var5 = scripts\sp\door::get_interactive_door("baby_room_exit");

  if(var5.ajar || var5.bashed) {
    level notify("finished_baby_mom_vo");
    return;
  }

  var5 endon("ajar");
  var5 endon("bashed");
  thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_80");
  wait 0.8;
  var6 = gettime();

  while(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var2.origin, cos(15)) && !scripts\engine\utility::time_has_passed(var6, 2)) {
    waitframe();
  }

  wait 0.5;
  thread scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_4th_floor_bedroom_90");
  level notify("finished_baby_mom_vo");
}

function baby_mom_idle_react(var0, var1) {
  self endon("death");
  self endon("scripted_death");
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "dx_vom_aqf3_4th_floor_bedroom_94");
}

function baby_mom_death_react(var0) {
  self.mom = var0;
  var0 scripts\engine\utility::waittill_either("death", "scripted_death");
  var0.baby setlookattext("", &"");
  thread baby_cry_hard();
  thread baby_mom_death_dialogue();

  if(!isDefined(self.momdeathreact_anime)) {
    return;
  }

  var1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var1 notify("stop_baby_mom_idle");
  var1 notify("stop_loop_bravo4_4");
  scripts\engine\sp\utility::anim_stopanimScripted();

  if(self.momdeathreact_anime == "grab_baby_death_interrupt") {
    var2 = spawnStruct();
    var2.origin = self.origin;
    var2.angles = self.angles + (0, 30, 0);
    var2 scripts\common\anim::anim_single_solo(self, self.momdeathreact_anime);
    scripts\common\anim::anim_loop_solo(self, "grab_baby_stand_death_idle");
  } else if(self.momdeathreact_anime == "grab_baby_stand_death") {
    var1 scripts\common\anim::anim_single_solo(self, self.momdeathreact_anime);
    scripts\common\anim::anim_loop_solo(self, "grab_baby_stand_death_idle");
  } else {
    var1 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(self, self.momdeathreact_anime);
  }

  self setgoalpos(self.origin);
}

function baby_mom_death_dialogue() {
  wait 0.6;
  level scripts\engine\sp\utility::smart_radio_dialogue_interrupt("dx_vom_a12_4th_floor_bedroom_91");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_4th_floor_bedroom_92");
}

function postspawn_bed_guy() {
  self endon("death");
  var0 = scripts\sp\utility::make_weapon("iw8_sm_mpapa7");
  scripts\anim\shared::forceuseweapon(var0, "primary");
  thread bed_guy_sight_thread(level);
  self.nofacialfiller = 1;
  self.allowdeath = 1;
  self.animname = "bed_guy";
  var1 = scripts\engine\utility::getStruct("bed_guy_animnode", "targetname");
  var1 thread scripts\common\anim::anim_loop_solo(self, "corner_idle");
  scripts\engine\utility::flag_wait("bed_guy_go");
  thread scripts\engine\sp\utility::smart_dialogue("dx_vom_aq1_4th_floor_bedroom_97");
  var1 notify("stop_loop");
  var2 = "hide_under_bed";
  var1 scripts\common\anim::anim_single_solo(self, var2);
  self.useeyetoshoot = 1;
  GscBinSkip1(0x45, "left", 25, self);
}

function bed_guy_flash() {
  self endon("death");
  var0 = scripts\engine\utility::getanim("under_bed_flash_knob");
  var1 = scripts\engine\utility::getanim("under_bed_flash");

  for(;;) {
    self waittill("flashbang");
    self.scriptedflashed = 1;
    self aisetanimlimited(var0, 1, 0.2);
    self setflaggedanimknoblimitedrestart("flash_anim", var1, 1, 0.2);
    self waittillmatch("flash_anim", "end");
    self.scriptedflashed = 0;
    self aisetanimlimited(var0, 0, 0.2);
  }
}

function demo_trigger_damage() {
  self endon("death");
  var0 = getEnt("bedguy_damage_trigger", "targetname");

  for(var1 = 0; var1 < 2; var1++) {
    var0 waittill("damage");
  }

  self kill();
}

function testing_weapon_collision(var0) {
  setDvar("scr_drop_bedguy_weapon", 0);

  for(;;) {
    if(getdvarint("scr_drop_bedguy_weapon") > 0) {
      setDvar("scr_drop_bedguy_weapon", 0);
      var1 = level.player getplayerangles();
      var2 = anglesToForward(var1);
      var3 = level.player getEye() + var2 * 30;
      var4 = spawn("weapon_" + createheadicon(var0), var3);
      var4.angles = var1;
    }

    waitframe();
  }
}

function bed_guy_target(var0) {
  var0 endon("death");

  if(istrue(level.demo)) {
    var0.dontevershoot = 1;
    var0 scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::disable_dontevershoot);
  }

  var1 = 32;
  var2 = 10;
  var3 = spawn("script_origin", level.player.origin);
  var3 makeentitysentient("allies");
  var0.favoriteenemy = var3;
  var3.health = 100;

  while(isalive(var0)) {
    var4 = vectorNormalize(scripts\engine\utility::flat_origin(var0 getEye()) - scripts\engine\utility::flat_origin(level.player.origin));
    var3.origin = level.player.origin + var4 * var1 + (0, 0, var2);
    waitframe();
  }

  var3 delete();
}

function fourth_floor_price_movement() {
  scripts\engine\utility::flag_wait("bed_guy_go");
  var0 = scripts\engine\utility::getStruct("baby_mom_door_animnode", "targetname");
  var0 notify("stop_loop_" + level.price.animname);
  thread fourth_floor_price_open_door();
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var1 = getnode("price_4th_floor", "targetname");
  level.price scripts\sp\maps\townhoused\townhoused_code::scripted_movement(var1, 1);
  level.price notify("stop_fourth_floor_price_open_door");
  var2 = scripts\engine\sp\utility::get_living_ai("bed_guy", "animname");

  if(isalive(var2)) {
    level.price.ignoreall = 0;
    level.price.dontevershoot = 0;
    var3 = var2 gettagorigin("tag_eye");
    var4 = vectorNormalize(level.price getEye() - var3);
    var3 = var3 + var4 * 30 + (0, 0, -5);
    var5 = spawn("script_origin", var3);
    var5 makeentitysentient("axis");
    level.price.favoriteenemy = var5;
    var2 waittill("death");
    wait 0.2;
    var5 delete();
    level.price.dontevershoot = 1;
    return;
  }
}

function fourth_floor_price_open_door() {
  level.price endon("stop_fourth_floor_price_open_door");
  var0 = scripts\sp\door::get_interactive_door("baby_room_exit");
  var0 scripts\sp\door::add_pushent(self);

  for(;;) {
    if(isDefined(self._blackboard.doortoopen) && self._blackboard.doortoopen.targetname == "baby_room_exit") {
      var0 = self._blackboard.doortoopen;
      self._blackboard.doortoopen = undefined;
      scripts\sp\maps\townhoused\townhoused_code::ai_try_open_door(var0);
      return;
    }

    waitframe();
  }
}

function bed_guy_sight_thread(var0) {
  var0 endon("death");

  for(;;) {
    waitframe();
    var1 = var0 gettagorigin("tag_eye");
    var2 = level.player getEye();

    if(scripts\engine\utility::within_fov(var2, level.player getplayerangles(), var1, 0.939693) && sighttracepassed(level.player getEye(), var1, 0, level.player)) {
      break;
    }
  }

  scripts\engine\utility::flag_set("bed_guy_go");
}

function attic_room() {
  thread attic_door_triggered();
  thread setup_ending();
  attic_price_stairtrain();
  scripts\engine\sp\utility::autosave_by_name("attic");
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  scripts\engine\sp\utility::spawn_script_noteworthy("attic_enemy", 1);
  thread attic_enemy_death_vo();
  thread attic_open_door();
  var0 notify("stop_attic_arrival_loop");
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(level.price, "attic_door_open", undefined, "stop_attic_door_open_loop");
  level.attic_enemy scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf4_attic_standoff_02");
  var1 = ["dx_vom_pri_attic_breach_20", "dx_vom_pri_attic_breach_30", "dx_vom_pri_attic_breach_40"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code::nag(var1, "saw_attic_enemy", 12, 15);
  level.attic_enemy.anim_smartdialog_func = &attic_enemy_smartdialog;
  level.attic_enemy thread scripts\sp\maps\townhoused\townhoused_code::flash_react_thread(["woman_flashbang_friendly_3", "woman_flashbang_friendly_4"]);
  thread attic_trigger_damage_thread();
  var0 thread scripts\common\anim::anim_loop_solo(level.attic_enemy, "start_idle", "stop_attic_loop");
  level.attic_enemy.allowdeath = 1;
  attic_player_sees_enemy();
  level notify("saw_attic_enemy");
  setmusicstate("mx_townhouse_suicide_os");
  var0 notify("stop_attic_door_open_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();

  if(istrue(level.price.halliganinhand)) {
    scripts\sp\maps\townhoused\townhoused_anim::stow_halligan(level.price);
  }

  level.price scripts\anim\shared::placeweaponon(level.price.weapon, "right");
  level.price scripts\engine\utility::ent_flag_init("attic_enter_anim_done");
  thread attic_enemy_anim();
  thread attic_price_anim();
  level waittill("start_enemy_death");
  level.price scripts\engine\utility::ent_flag_wait("attic_enter_anim_done");

  if(!istrue(level.finished_attic_clear_vo)) {
    level waittill("finished_attic_clear_vo");
  }

  var0 notify("stop_attic_entry_loop");
  level.price scripts\engine\sp\utility::anim_stopanimScripted();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(level.price, "attic_enemy_death", undefined, "stop_attic_price");
  thread attic_death_dialogue();

  if(!level.player scripts\engine\utility::ent_flag("no_gold_achievement")) {
    scripts\sp\utility::giveachievement_wrapper("goldenpath");
  }

  var2 = &"TOWNHOUSED/HINT_PICKUP";
  var3 = 45;
  var4 = 100;
  var5 = 60;
  var6 = 1;
  level.clacker scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), var2, var3, var4, var5, var6);
  thread clacker_unusable_thread();
  level.clacker waittill("trigger");
  level.player lerpfovscalefactor(0, 1);
  scripts\engine\utility::flag_set("player_picked_up_clacker");
  level.price scripts\engine\sp\utility::name_hide();
  thread scripts\sp\maps\townhoused\townhoused_lighting::price_ending_cinematic();
  level.player disableweapons();
  level.player allowmelee(0);
  level.player allowfire(0);
  level.player allowads(0);
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(level.player isnightvisionon()) {
    level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::allow_nvg, 0);
  } else {
    level.player scripts\engine\sp\utility::allow_nvg(0);
  }

  level.clacker linkTo(level.player_rig, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  level.player_rig.customnotetrackhandler = &attic_fov_notetrack;
  var0 thread scripts\common\anim::anim_single_solo(level.player_rig, "ending");
  thread ending_bink_init();
  var7 = "tag_accessory_right";
  level.price.laptop = scripts\engine\sp\utility::spawn_anim_model("laptop", level.price gettagorigin(var7), level.price gettagangles(var7));
  level.price.laptop linkTo(level.price, var7, (0, 0, 0), (0, 0, 0));
  thread attic_bink_start();
  var0 notify("stop_attic_price");
  var0 thread scripts\common\anim::anim_single_solo(level.price, "ending");
  var8 = distance2d(level.player.origin, level.clacker.origin);
  var9 = var5 / 1;
  var10 = var8 / var9;
  level.player playerlinktoblend(level.player_rig, "tag_player", var10, 0.2, 0.2);
  thread lerp_attic_player_viewangle(var10);
  wait var10;
  level.player_rig show();
  level.price waittillmatch("single anim", "end");
  var0 thread scripts\common\anim::anim_last_frame_solo(level.price, "ending");
}

function attic_trigger_damage_thread() {
  var0 = getEnt("attic_damage_trigger", "targetname");
  thread trigger_damage_ondamage();

  for(;;) {
    var0 waittill("trigger");

    if(isDefined(var0.triggertype)) {
      if(var0.triggertype == "frag") {
        if(isalive(level.attic_enemy)) {
          level.attic_enemy kill(var0.damagepos, var0.damageattacker, var0.damageattacker, var0.damagemod);
        }
      }

      self.damagepos = undefined;
      self.damagemod = undefined;
      self.damageattacker = undefined;
      self.triggertype = undefined;
    }
  }
}

function trigger_damage_ondamage() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9) && var9.basename == "frag" && ispointinvolume(var3, self)) {
      self.damagepos = var3;
      self.damagemod = var4;
      self.damageattacker = var1;
      self.triggertype = "frag";
      self notify("trigger");
    }
  }
}

function lerp_attic_player_viewangle(var0) {
  wait var0 + 1;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(2, 0, 0, 10, 20, 20, 10);
}

function clacker_unusable_thread() {
  self endon("trigger");
  var0 = 1;
  var1 = self.origin;
  var2 = self.origin[2] - 40;

  for(;;) {
    var3 = 0;

    if(level.player isgestureplaying()) {
      var3++;
    }

    if(!isalive(level.player)) {
      var3++;
    }

    if(level.player.origin[2] < var2) {
      var3++;
    }

    if(var3 == 0 && scripts\sp\maps\townhoused\townhoused_code::is_grenade_near_cursor_hint()) {
      var3++;
    }

    if(var0 && var3) {
      self.cursor_hint_ent makeunusable();
      var0 = 0;
    } else if(!var0 && !var3) {
      self.cursor_hint_ent makeusable();
      var0 = 1;
    }

    waitframe();
  }
}

function attic_death_dialogue() {
  level endon("player_picked_up_clacker");

  if(scripts\engine\utility::flag("player_picked_up_clacker")) {
    return;
  }

  wait 2;
  wait 2.8;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a31_attic_secure_20");
  wait 0.2;
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_a21_attic_secure_30");
  wait 2.3;
  var0 = ["dx_vom_pri_attic_secure_50", "dx_vom_pri_attic_secure_60", "dx_vom_pri_attic_secure_70"];
  level.price scripts\engine\utility::delaythread(5, &scripts\sp\maps\townhoused\townhoused_code::nag, var0, "player_picked_up_clacker", 12, 15);
}

function attic_bink_start() {
  var0 = level.price scripts\engine\utility::getanim("ending");
  var1 = getanimlength(var0);
  var1 -= 4;
  wait var1;
  level.player setclienttriggeraudiozone("fade_to_black", 1.6);
  pausecinematicingame(0);
  wait 1.4;
  setsaveddvar("MMRNLMPPLT", "1");
  scripts\engine\utility::flag_set("end_scene_done");
}

function ending_bink_init() {
  var0 = scripts\sp\endmission::getlevelindex(level.script);
  scripts\sp\endmission::setfadetime(var0, 0);
  var1 = var0 + 1;
  var2 = scripts\sp\endmission::getlevelbink(var1);
  level.endmission_bink_skip = 1;
  setsaveddvar("LNSNKKLPLL", "0");
  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var2, 1, 1, 1, 0, 0, 1);
}

function attic_fov_notetrack(var0, var1, var2) {}

function setup_ending() {
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(level.player_rig, "ending");
  waitframe();
  var1 = level.player_rig gettagorigin("tag_accessory_right");
  var2 = level.player_rig gettagangles("tag_accessory_right");
  level.clacker = scripts\engine\sp\utility::spawn_anim_model("clacker", var1, var2);
}

function attic_price_anim() {
  var0 = scripts\sp\door::get_interactive_door("attic_door");
  level.price scripts\engine\utility::delaythread(1.2, &scripts\sp\maps\townhoused\townhoused_code::force_open_door, var0);
  scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(level.price, "attic_entry", undefined, "stop_attic_entry_loop");
  level.price scripts\engine\utility::ent_flag_set("attic_enter_anim_done");
}

function attic_enemy_smartdialog(var0) {
  if(istrue(self.scriptedflashed)) {
    return;
  }

  scripts\engine\sp\utility::smart_dialogue(var0);
}

function attic_enemy_anim() {
  if(isalive(level.attic_enemy)) {
    thread attic_enemy_early_death();
    scripts\common\anim::anim_single_solo(level.attic_enemy, "attic_entry");
  }

  if(!isalive(level.attic_enemy) && !level.price scripts\engine\utility::ent_flag("attic_enter_anim_done")) {
    var0 = level.price scripts\engine\utility::getanim("attic_entry");

    if(level.price getanimtime(var0) < 0.9) {
      level.price setanimrate(var0, 2);
    }

    level.price waittillmatch("single anim", "end");
  }

  level notify("start_enemy_death");
  setmusicstate("");

  if(isalive(level.attic_enemy) && !isDefined(level.attic_enemy.early_death)) {
    level.attic_enemy.deathfunction = undefined;
    level.attic_enemy actoraimassistoff();
    scripts\common\anim::anim_single_solo(level.attic_enemy, "attic_enemy_death");
    return;
  }
}

function attic_enemy_death_vo() {
  var0 = spawnStruct();
  wait_attic_enemy_death(var0);
  wait 0.8;
  scripts\sp\maps\townhoused\townhoused_code::wait_weapon_fire_cooldown(0.4, 2);

  if(scripts\engine\utility::is_equal(var0.attacker, level.player)) {
    level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_standoff_40");
  } else {
    level.price scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_standoff_50");
  }

  level.finished_attic_clear_vo = 1;
  level notify("finished_attic_clear_vo");
}

function wait_attic_enemy_death(var0) {
  level endon("start_enemy_death");

  while(self.health > 0) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8);

    if(!isDefined(var0.attacker) || var0.attacker != level.player) {
      var0.attacker = var2;
    }
  }
}

function attic_enemy_early_death() {
  var0 = level.attic_enemy;
  var0 endon("death");
  var0 endon("stop_early_death");
  level endon("start_enemy_death");
  var1 = scripts\engine\utility::getStruct("attic_animnode", "targetname");

  while(var0.health > 1) {
    var0 waittill("damage");
  }

  var0 stopsounds();
  setmusicstate("");

  if(var0.damagelocation == "head" || var0.damagelocation == "helmet") {
    var0 scripts\engine\sp\utility::set_deathanim("attic_enemy_headshot_death");
    var0 scripts\engine\sp\utility::anim_stopanimScripted();
    var0 kill(var0.origin, level.player, level.player, var0.damagemod);
    return;
  }

  var0 scripts\engine\utility::delaythread(0.05, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqf4_attic_standoff_42");
  var0.early_death = 1;
  var2 = "attic_enemy_early_long_death";
  var0 thread scripts\sp\maps\townhoused\townhoused_code::delay_allowdeath(0.4);
  var0.skipdeathanim = 1;
  var0 actoraimassistoff();
  var0 scripts\common\anim::anim_single_solo(var0, "attic_enemy_early_long_death");
}

function attic_door_triggered() {
  var0 = scripts\sp\door::get_interactive_door("attic_door");
  var0 waittill("trigger");
  var0 notify("stop_open_ability");
  scripts\engine\utility::flag_set("attic_door_used");
  wait 0.4;
  scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_breach_02");
  wait 0.3;

  if(istrue(level.price_at_attic_door)) {
    return;
  }

  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_attic_breach_04");
}

function attic_price_stairtrain() {
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var0 scripts\sp\anim::anim_reach_solo(level.price, "attic_stairtrain_arrival");
  var0 scripts\common\anim::anim_single_solo(level.price, "attic_stairtrain_arrival");
  level.stairtrain_rearguy = level.price;
  level.price.animnode = var0;
  level.price scripts\asm\asm_sp::asm_animcustom(&scripts\sp\maps\townhoused\townhoused_code::stairtrain_attic_animcustom);
  waitframe();

  if(level.price scripts\engine\utility::ent_flag("stairtrain_on")) {
    level.price scripts\engine\utility::ent_flag_waitopen("stairtrain_on");
  }

  var0 scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(level.price, "attic_door_arrive", undefined, "stop_attic_arrival_loop");
  level.price_at_attic_door = 1;
  var1 = ["dx_vom_pri_attic_breach_20", "dx_vom_pri_attic_breach_30", "dx_vom_pri_attic_breach_40"];
  level.price thread scripts\sp\maps\townhoused\townhoused_code::nag(var1, "attic_door_used", 12, 15);
  scripts\engine\utility::flag_wait("attic_door_used");
}

function attic_player_sees_enemy() {
  var0 = ["tag_eye", "j_ankle_ri", "j_mainroot"];

  for(;;) {
    if(!isalive(level.attic_enemy)) {
      break;
    }

    var1 = 0;

    foreach(var3 in var0) {
      var4 = level.attic_enemy gettagorigin(var3);

      if(sighttracepassed(level.player getEye(), var4, 0, level.player)) {
        return;
      }
    }

    waitframe();
  }
}

function get_shelfs() {
  var0 = getEntArray("attic_shelf", "targetname");

  foreach(var2 in var0) {
    var2 notsolid();
    var2 scripts\engine\sp\utility::assign_animtree(var2.script_animname);
    add_linkedents(var2);

    foreach(var4 in var2.linkedents) {
      thread shelf_movement();
    }
  }

  return var0;
}

function shelf_movement() {
  wait 0.5;
  var0 = self.origin;
  var1 = squared(2);

  for(;;) {
    var2 = distancesquared(var0, self.origin);

    if(var2 > var1) {
      var3 = sqrt(var2);
      var4 = vectorNormalize(var0 - self.origin) * var3;
      self unlink();
      self physicslaunchclient(self.origin, var4);
      break;
    }

    var0 = self.origin;
    waitframe();
  }
}

function add_linkedents() {
  var0 = getEntArray(self.target, "targetname");

  foreach(var2 in var0) {
    if(!isDefined(self.linkedents)) {
      self.linkedents = [];
    }

    self.linkedents[self.linkedents.size] = var2;
    var2 linkTo(self);

    if(isDefined(var2.target)) {
      add_linkedents(var2);
    }
  }
}

function kill_everyone_ending() {
  wait 0.1;
  level.price scripts\common\ai::stop_magic_bullet_shield();
  level.price kill();
  wait 0.05;
  level.player kill();
  level waittill("never_ending");
}

function attic_open_door() {
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var1 = scripts\sp\door::get_interactive_door("attic_door");
  thread prime_attic_door_states(var1.origin + (0, 0, 200));
  var0 scripts\sp\maps\townhoused\townhoused_code::anim_door(var1, "attic_door_open", undefined, 1);
  var1 scripts\sp\door_internal::set_pivot_point(1);
  var1 thread scripts\sp\door_internal::monitor_door_push(0);
  var1 scripts\sp\door_internal::waittill_second_interact_or_bash();
  var1 scripts\sp\door::remove_open_ability();
  thread remove_prime_ents();
}

function temp_attic_dialogue() {
  wait 0.3;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_40");
  wait 1;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_50");
  wait 4;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_60");
  wait 4;
  level.price thread scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_interior_90");
}

function prime_attic_door_states(var0) {
  level.primedents = [];
  level.primedents[level.primedents.size] = scripts\sp\maps\townhoused\townhoused_code::quick_spawn_model("attic_door_damaged", var0);
  level.primedents[level.primedents.size] = scripts\sp\maps\townhoused\townhoused_code::quick_spawn_model("attic_door_damaged2", var0);
}

function remove_prime_ents() {
  scripts\engine\utility::array_delete(level.primedents);
}

function try_nvg_enable_hint() {
  if(!level.player scripts\sp\nvg\nvg_player::is_nvg_on()) {
    scripts\sp\nvg\nvg_player::nvg_on_hint(8);
    return;
  }
}

function hint_nvg_enable_check() {
  return level.player scripts\sp\nvg\nvg_player::is_nvg_on();
}

function hint_nvg_disable_check() {
  return !level.player scripts\sp\nvg\nvg_player::is_nvg_on();
}

function postspawn_attic_enemy() {
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  var0 scripts\common\anim::anim_first_frame_solo(self, "attic_entry");
  self.og_headmodel = self.headmodel;
  self detach(self.headmodel);
  self attach(scripts\engine\sp\utility::getmodel(self.animname + "_head"));
  self.team = "neutral";
  self.health = 80;
  scripts\sp\utility::context_melee_allow(0);
  scripts\common\ai::gun_remove();
  self.nofacialfiller = 1;
  level.attic_enemy = self;
  thread scripts\sp\maps\townhoused\townhoused_code::golden_enemydamage();
  thread scripts\sp\maps\townhoused\townhoused_code::golden_enemydeath();
}

function nvg_death_hint() {
  scripts\engine\utility::flag_init("player_used_nvgs");
  level.player.nvg.on_func = &player_nvgon;
  var0 = "townhouse_nvgs_used";
  level.player waittill("death");

  if(isDefined(level.custom_death_quote)) {
    return;
  }

  if(getdvarint(var0) > 0) {
    return;
  }

  if(scripts\engine\utility::flag("player_used_nvgs")) {
    setDvar(var0, 1);
    scripts\sp\player_death::set_custom_death_quote(15);
    return;
  }
}

function player_nvgon() {
  scripts\engine\utility::flag_set("player_used_nvgs");
}