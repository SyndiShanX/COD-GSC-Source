/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_util.gsc
****************************************************************/

function ref_11a9a(var_0, var_1) {
  if(!isDefined(self.origin)) {
    return;
  }

  var_2 = spawn("script_model", self.origin);
  var_2 endon("death");
  var_2.isusable = 1;
  var_2 setCursorHint("hint_button");
  var_2 sethintdisplayfov(360);
  var_2 setusefov(135);
  var_2 sethintdisplayrange(500);
  var_2 setuserange(80);
  var_2 sethintonobstruction("hide");
  var_2 setuseholdduration("duration_none");
  var_2 sethintlockplayermovement(1);
  var_2 makeusable();

  if(isDefined(var_0)) {
    var_2 setHintString(var_0);
  }

  if(isDefined(var_1)) {
    var_2.origin += var_1;
  }

  var_2.userate = 1;
  var_2.laststandfinisherdone = 4;
  var_2.curprogress = 0;
  var_2.usetime = 5;
  var_2.inuse = 0;
  var_2.playerusing = undefined;
  var_3 = undefined;
  return var_2;
}

function supportboxmaxammo() {
  var_0 = [];
  GscBinSkip1(0x45, 0, spawnStruct());
}

function weapon_xp_iw8_sm_papa90(var_0) {
  for(;;) {
    var_1 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
    var_1 = scripts\engine\utility::array_removeundefined(var_1);

    if(!scripts\engine\utility::flag("care_package_space_full") && var_1.size >= var_0) {
      scripts\engine\utility::flag_clear("care_package_space_full");
    }

    if(scripts\engine\utility::flag("care_package_space_full") && var_1.size < var_0) {
      scripts\engine\utility::flag_set("care_package_space_full");
    }

    wait 2;
  }
}

function weapon_xp_iw8_sm_augolf(var_0) {
  level endon("stop_care_packages");
  level.ref_12db9 = var_0;
  var_1 = int(tablelookupbyrow("scripts/cp/maps/cp_so_embassy/cp_so_embassy_killstreaks.csv", var_0, level.players.size));
  wait 2;

  if(!scripts\engine\utility::flag("care_package_vo_playing")) {
    scripts\engine\utility::flag_set("care_package_vo_playing");

    if(var_1 == 1) {
      thread ref_12758("dx_mpo_usop_airdrop_use");
    } else if(var_1 > 1) {
      thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
    }

    scripts\engine\utility::delaythread(6, &scripts\engine\utility::flag_clear, "care_package_vo_playing");
  }

  var_2 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_2 = scripts\engine\utility::array_removeundefined(var_2);
  var_3 = squared(70);

  for(var_4 = 0; var_4 < var_1; var_4++) {
    scripts\engine\utility::flag_waitopen("care_package_space_full");
    var_5 = play_players_see_informant_before_aipickup();
    var_6 = var_5.script_radius;
    var_7 = var_5.script_radius;
    var_8 = var_5.angles;
    var_9 = var_5.origin;
    var_9 = getclosestmatchingmasterlootnode(var_2, var_9, var_3);
    var_5.should_take_damage_from_trigger_hurt = 1;
    var_10 = tablelookupbyrow("scripts/cp/maps/cp_so_embassy/cp_so_embassy_killstreaks.csv", level.ref_12db9, 5);
    var_10 = strtok(var_10, " ");
    var_11 = scripts\engine\utility::random(var_10);

    if(!isDefined(var_11)) {
      continue;
    }

    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_6, var_7, var_8, var_9, var_11, &weapon_xp_iw8_sm_mpapa7);
    wait 3;
  }
}

function play_players_see_informant_before_aipickup() {
  var_0 = level.minigun_right[randomintrange(0, 4)];

  foreach(var_2 in level.minigun_right) {
    if(istrue(var_2.should_take_damage_from_trigger_hurt)) {
      continue;
    }

    var_0 = var_2;
  }

  return var_0;
}

function getclosestmatchingmasterlootnode(var_0, var_1, var_2) {
  for(;;) {
    var_3 = 1;

    foreach(var_5 in var_0) {
      if(!isDefined(var_5) || distance2dsquared(var_5.origin, var_1) > var_2) {
        continue;
      }

      var_3 = 0;
      break;
    }

    if(var_3) {
      break;
    }

    var_1 += (60, 0, 0);
  }

  return var_1;
}

function weapon_xp_iw8_sm_mpapa7(var_0, var_1, var_2) {
  var_3 = sortbydistance(level.minigun_right, var_1);
  var_4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();

  if(!isDefined(var_3[0])) {
    return;
  }

  if(getcost(var_4, var_1)) {
    return;
  }

  var_3[0].should_take_damage_from_trigger_hurt = 0;
}

function getcost(var_0, var_1) {
  var_2 = squared(300);

  foreach(var_4 in var_0) {
    if(distance2dsquared(var_1, var_4.origin) <= var_2) {
      return true;
    }
  }

  return false;
}

function weapon_xp_iw8_sm_beta(var_0, var_1, var_2) {
  if(!scripts\engine\utility::flag("care_package_vo_playing")) {
    scripts\engine\utility::flag_set("care_package_vo_playing");

    if(var_1 == 1) {
      thread ref_12758("dx_mpo_usop_airdrop_use");
    } else if(var_1 > 1) {
      thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
    }

    scripts\engine\utility::delaythread(6, &scripts\engine\utility::flag_clear, "care_package_vo_playing");
  }

  var_3 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var_4 = squared(70);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(!isDefined(var_2)) {
      var_2 = var_5;
    }

    var_6 = level.minigun_right[var_2];

    if(!isDefined(var_6)) {
      var_6 = level.minigun_right[0];
    }

    var_7 = var_6.script_radius;
    var_8 = var_6.script_radius;
    var_9 = var_6.angles;
    var_10 = var_6.origin;

    if(istrue(var_6.should_take_damage_from_trigger_hurt)) {
      var_10 = getclosestmatchingmasterlootnode(var_3, var_10, var_4);
    }

    var_6.should_take_damage_from_trigger_hurt = 1;

    if(var_0 == "incendiary_launcher") {
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, undefined, &weapon_xp_iw8_sm_mpapa5);
    } else {
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var_7, var_8, var_9, var_10, var_0, &weapon_xp_iw8_sm_mpapa7);
    }

    wait 3;
  }
}

function weapon_xp_iw8_sm_mpapa5(var_0, var_1, var_2) {
  wait 0.1;
  var_3 = scripts\cp\cp_weapon::buildweapon("iw8_la_mike32_mp", ["calcust", "lnchrscope_mike32"]);
  var_4 = createheadicon(var_3);
  var_5 = spawn("weapon_" + var_4, var_1 + (0, 0, 20));
  var_5 physicslaunchserveritem(var_5.origin, (0, 0, 1250));
  thread start_end_breach_fx(var_5, var_0);
}

function get_drop_location(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 90));
  var_1 show();
  var_1 linkTo(var_0);
  wait 0.15;
  var_1.origin = var_0.origin;
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_1, "tag_origin");
  var_0 waittill("trigger");
  var_1 delete();
}

function start_end_breach_fx(var_0, var_1) {
  thread scripts\cp\cp_outline_utility::outlineenableforall(var_0, "outline_depth_white", "equipment");
  var_0 itemweaponsetammo(6, 6);
  var_0 waittill("trigger");
  var_1 thread scripts\mp\trials\trial_pitcher::firemanager();
}

function ref_134ed(var_0, var_1, var_2) {
  while(scripts\engine\utility::flag("spawning_in_progress")) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_in_progress");
  wait 0.5;
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_4 = [];

  if(!isDefined(var_3) || var_3.size < 1) {
    return;
  }

  if(isDefined(var_2)) {
    var_3 = sortbydistance(var_3, var_2);
  }

  if(!isDefined(var_1)) {
    var_1 = ref_130a1();
  }

  var_5 = 0;

  for(var_6 = 0; var_6 < var_1; var_6++) {
    if(var_5 >= var_3.size - 1) {
      var_5 = 0;
      var_3 = scripts\engine\utility::array_reverse(var_3);
    }

    while(scripts\engine\utility::flag("pause_mission_spawning") || getaiarray("axis").size >= ref_130a1() || getaiarray().size > 37) {
      wait 0.2;
    }

    var_7 = var_3[var_5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    if(!isDefined(var_7)) {
      continue;
    }

    var_8 = level.players;
    var_9 = [];

    foreach(var_11 in var_8) {
      if(getdefaultstreamhinttimeoutms(var_11)) {
        var_9 = var_11;
      }
    }

    var_8 = scripts\engine\utility::array_remove_array(var_8, var_9);
    var_11 = scripts\engine\utility::random(var_8);

    if(isDefined(var_11)) {
      var_7 getenemyinfo(var_11);
    }

    var_7.goalheight = 30;
    var_7 scripts\engine\utility::set_movement_speed(300);
    var_4 = var_7;

    if(isDefined(var_3[var_5].count)) {
      var_3[var_5].count++;
    }

    if(scripts\engine\utility::is_equal(var_7.team, "axis")) {
      var_7 setthreatbiasgroup("axis");
    }

    var_5++;

    if(!isDefined(var_3[var_5]) || var_4.size >= var_1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
  scripts\engine\utility::flag_clear("spawning_in_progress");
  return var_4;
}

function ref_134f0(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1) || getaiarray().size > 40) {
    return;
  }

  var_2 = var_1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
  var_2 scripts\engine\utility::set_movement_speed(300);
  var_2.goalheight = 30;

  if(isDefined(var_1.count)) {
    var_1.count++;
  }

  if(isDefined(var_2) && scripts\engine\utility::is_equal(var_2.team, "axis")) {
    var_2 setthreatbiasgroup("axis");
  }

  waitframe();
  return var_2;
}

function ref_1352b(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  var_5 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_0, var_1, var_2, var_4, var_3);
  var_5 scripts\engine\utility::set_movement_speed(300);
  var_5.goalheight = 30;
  waitframe();
  return var_5;
}

function ref_1352c(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in var_1) {
    var_7 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_0, var_6[0], var_6[1], var_3, var_2);
    var_7 scripts\engine\utility::set_movement_speed(300);
    var_7.goalheight = 30;
    var_4 = var_7;
    waitframe();
  }

  return var_4;
}

function set_start_pos(var_0) {
  foreach(var_2 in level.players) {
    level thread scripts\cp\utility::teleportplayertoteamstructs(var_2, var_0);
  }
}

function ref_124a6() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var_0 = "iw8_sm_mpapa7";
  var_1 = ["laserirsmg", "thermal_west01", "gripangpro", "linearbrakesmg", "compsmg", "muzzlemelee01", "muzzlemelee02", "brakesmg", "pistolgrip01_mpapa7"];
  var_2 = "iw8_sn_mike14_mp";
  GscBinSkip1(0x45, 0, scripts\cp\cp_weapon::buildweapon(var_0, var_1, "none", "none", -1));
}

function hostagetemppistol() {
  self endon("death_or_disconnect");
  self.ref_14389 = 1;
  waitframe();
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 1;
  var_1.foreground = 1;
  var_1.lowresbackground = 1;
  var_2 = 1;
  precacherumble("cp_wheelson_rumble");
  precacherumble("damage_heavy");
  var_3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinkTo(var_3, undefined, 0, 90, 90, 90, 90);
  thread vehicle_preventplayercollisiondamagefortimeafterexitinternal();
  self disableweapons();
  scripts\engine\utility::flag_wait("players_connected");
  thread persistantgametypeteamassign();
  wait 8;
  scripts\engine\utility::flag_set("fade_in");
  var_1 fadeovertime(var_2);
  var_1.alpha = 0;
  completepayloadpunish(1, 1);
  self unlink();
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_hide_minimap", 0);
  self enableweapons();
  wait 2;

  if(isDefined(var_1)) {
    var_1 destroy();
  }

  var_3 delete();
}

function vehicle_preventplayercollisiondamagefortimeafterexitinternal() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_hide_hud", 1);
  self setclientomnvar("ui_hide_minimap", 1);

  while(!scripts\engine\utility::flag("fade_in")) {
    if(isDefined(self calloutmarkerping_entityzoffset("ui_hide_hud")) && !self calloutmarkerping_entityzoffset("ui_hide_hud")) {
      self setclientomnvar("ui_hide_hud", 1);
    }

    if(isDefined(self calloutmarkerping_entityzoffset("ui_hide_minimap")) && !self calloutmarkerping_entityzoffset("ui_hide_minimap")) {
      self setclientomnvar("ui_hide_minimap", 1);
    }

    waitframe();
  }
}

function persistantgametypeteamassign() {
  wait 5;
  self playSound("cp_so_embassy_fastrope_plr");
  self playrumblelooponentity("cp_wheelson_rumble");
  wait 3;
  self stoprumble("cp_wheelson_rumble");
  waitframe();
  self playRumbleOnEntity("damage_heavy");
}

function completepayloadpunish(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3)) {
    return;
  }

  var_3.movespeedscale = 0;
  var_3 setmovespeedscale(0);

  if(!isDefined(var_3.movespeedscale)) {
    var_3.movespeedscale = 1;
  }

  var_4 = &movespeed_get_func;
  var_5 = &movespeed_set_func;
  thread player_speed_proc(var_3, var_0, var_1, var_4, var_5, "blend_movespeedscale");
}

function player_speed_proc(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);
  self endon(var_4);
  var_6 = [[var_2]](var_5);
  var_7 = var_0;

  if(isDefined(var_1) && var_1 > 0) {
    var_8 = var_7 - var_6;
    var_9 = 0.05;
    var_10 = var_1 / var_9;
    var_11 = var_8 / var_10;

    while(abs(var_7 - var_6) > abs(var_11 * 1.1)) {
      var_6 += var_11;
      [[var_3]](var_6, var_5);
      wait var_9;
    }
  }

  [[var_3]](var_7, var_5);
}

function movespeed_get_func(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var_0])) {
    return 1;
  }

  return self.movespeedscales[var_0];
}

function movespeed_set_func(var_0, var_1) {
  var_2 = 1;

  if(!isDefined(var_1)) {
    var_1 = "default";
  }

  self.movespeedscales[var_1] = var_0;

  foreach(var_0 in self.movespeedscales) {
    if(var_0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var_4);
    }

    var_2 *= var_0;
  }

  self.movespeedscale = var_2;
  self setmovespeedscale(self.movespeedscale);
}

function ref_1247b(var_0) {}

function rundebugstartobjective(var_0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var_0])) {
    var_1 = level.objectivestabledata[var_0];

    if(isDefined(var_1.ondebugstartfunc)) {
      [[var_1.ondebugstartfunc]](var_1);
    }

    thread scripts\cp\cp_objectives::run_objective(var_1.objname, var_1.questtype);
    return;
  }
}

function onplayerspawneddevguisetup(var_0) {
  var_1 = var_0.name;
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4 == var_0) {
      var_2 = int(var_5);
      break;
    }
  }

  if(isDefined(var_2)) {
    thread setupdevguientries(var_0, var_0, var_1);
    return;
  }
}

function setupdevguientries(var_0, var_1, var_2) {}

function wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  wait 0.2;
}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("personal_ent_zones_initialized");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
    var_0 = getDvar("scr_strike_name");
    var_1 = undefined;

    switch (var_0) {
      case "putnewstrikehere":
        break;
      default:
        break;
    }

    return;
  }
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var_0) {}

function interaction_trigger_properties(var_0, var_1, var_2) {
  switch (var_1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var_1.useduration)) {
        self.interaction_trigger setuseholdduration(var_1.useduration);
      }

      break;
  }
}

function laser_control_station_use_monitor() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("helicopter_ai", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_3.targetname == "exfil_heli_nodes_01") {
      var_0 = var_3;
    }
  }

  scripts\engine\utility::deletestructarray_ref(var_0);
}

function ref_134eb(var_0, var_1, var_2) {
  var_3 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var_0, var_1.origin, var_1.angles);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3.script_startingposition = var_2;
  var_1 scripts\common\vehicle_aianim::guy_enter(var_3);
  return var_3;
}

function propchange(var_0) {
  GscBinSkip1(0x45, 1, 0);
}

function ref_130a1() {
  GscBinSkip1(0x45, 1, 0);
}

function c130_drop(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0) <= var_1 * var_1) {
      return true;
    }
  }

  return false;
}

function c130_door_badplace_id(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0) <= var_1 * var_1) {
      return true;
    }
  }

  return false;
}

function brevent1playerthink(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(distance2dsquared(var_3.origin, var_0) > var_1 * var_1) {
      return false;
    }
  }

  return true;
}

function brevent1playervalid(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(distance2dsquared(var_4.origin, var_0) > var_1 * var_1 || var_4.origin[2] > var_2) {
      return false;
    }
  }

  return true;
}

function ref_12758(var_0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var_1 = lookupsoundlength(var_0) * 0.001;
  level.ref_121a7 playSound(var_0);
  wait var_1;
}

function brenableagents(var_0, var_1, var_2) {
  var_3 = 1;
  jumpiffalse(!isDefined(var_1) || var_1 == "x") LOC_0000001b;
  var_3 = 0;

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(var_6.origin[var_3] > var_0) {
        var_4++;
      }
    }

    if(var_4 >= level.players.size) {
      break;
    }

    wait 0.5;
  }

  scripts\engine\utility::flag_set(var_2);
}

function getdefaultstreamhinttimeoutms() {
  return self.inlaststand;
}

function ref_1238d(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    wait 0.5;

    if(getaiarrayinradius(var_0, 80).size > 0) {
      badplace_cylinder("moody_traversal_ent", 5, var_0, var_1, var_2, var_3);

      if(isDefined(var_4) && var_3 != var_4) {
        badplace_cylinder("moody_traversal_ent", 5, var_0, var_1, var_2, var_4);
      }

      wait 5;
    }
  }
}