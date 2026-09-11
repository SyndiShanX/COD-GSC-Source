/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_embassy\cp_so_embassy_util.gsc
****************************************************************/

function ref_11a9a(var0, var1) {
  if(!isDefined(self.origin)) {
    return;
  }

  var2 = spawn("script_model", self.origin);
  var2 endon("death");
  var2.isusable = 1;
  var2 setCursorHint("hint_button");
  var2 sethintdisplayfov(360);
  var2 setusefov(135);
  var2 sethintdisplayrange(500);
  var2 setuserange(80);
  var2 sethintonobstruction("hide");
  var2 setuseholdduration("duration_none");
  var2 sethintlockplayermovement(1);
  var2 makeusable();

  if(isDefined(var0)) {
    var2 setHintString(var0);
  }

  if(isDefined(var1)) {
    var2.origin += var1;
  }

  var2.userate = 1;
  var2.laststandfinisherdone = 4;
  var2.curprogress = 0;
  var2.usetime = 5;
  var2.inuse = 0;
  var2.playerusing = undefined;
  var3 = undefined;
  return var2;
}

function supportboxmaxammo() {
  var0 = [];
  GscBinSkip1(0x45, 0, spawnStruct());
}

function weapon_xp_iw8_sm_papa90(var0) {
  for(;;) {
    var1 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
    var1 = scripts\engine\utility::array_removeundefined(var1);

    if(!scripts\engine\utility::flag("care_package_space_full") && var1.size >= var0) {
      scripts\engine\utility::flag_clear("care_package_space_full");
    }

    if(scripts\engine\utility::flag("care_package_space_full") && var1.size < var0) {
      scripts\engine\utility::flag_set("care_package_space_full");
    }

    wait 2;
  }
}

function weapon_xp_iw8_sm_augolf(var0) {
  level endon("stop_care_packages");
  level.ref_12db9 = var0;
  var1 = int(tablelookupbyrow("scripts/cp/maps/cp_so_embassy/cp_so_embassy_killstreaks.csv", var0, level.players.size));
  wait 2;

  if(!scripts\engine\utility::flag("care_package_vo_playing")) {
    scripts\engine\utility::flag_set("care_package_vo_playing");

    if(var1 == 1) {
      thread ref_12758("dx_mpo_usop_airdrop_use");
    } else if(var1 > 1) {
      thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
    }

    scripts\engine\utility::delaythread(6, &scripts\engine\utility::flag_clear, "care_package_vo_playing");
  }

  var2 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var2 = scripts\engine\utility::array_removeundefined(var2);
  var3 = squared(70);

  for(var4 = 0; var4 < var1; var4++) {
    scripts\engine\utility::flag_waitopen("care_package_space_full");
    var5 = play_players_see_informant_before_aipickup();
    var6 = var5.script_radius;
    var7 = var5.script_radius;
    var8 = var5.angles;
    var9 = var5.origin;
    var9 = getclosestmatchingmasterlootnode(var2, var9, var3);
    var5.should_take_damage_from_trigger_hurt = 1;
    var10 = tablelookupbyrow("scripts/cp/maps/cp_so_embassy/cp_so_embassy_killstreaks.csv", level.ref_12db9, 5);
    var10 = strtok(var10, " ");
    var11 = scripts\engine\utility::random(var10);

    if(!isDefined(var11)) {
      continue;
    }

    thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var6, var7, var8, var9, var11, &weapon_xp_iw8_sm_mpapa7);
    wait 3;
  }
}

function play_players_see_informant_before_aipickup() {
  var0 = level.minigun_right[randomintrange(0, 4)];

  foreach(var2 in level.minigun_right) {
    if(istrue(var2.should_take_damage_from_trigger_hurt)) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function getclosestmatchingmasterlootnode(var0, var1, var2) {
  for(;;) {
    var3 = 1;

    foreach(var5 in var0) {
      if(!isDefined(var5) || distance2dsquared(var5.origin, var1) > var2) {
        continue;
      }

      var3 = 0;
      break;
    }

    if(var3) {
      break;
    }

    var1 += (60, 0, 0);
  }

  return var1;
}

function weapon_xp_iw8_sm_mpapa7(var0, var1, var2) {
  var3 = sortbydistance(level.minigun_right, var1);
  var4 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();

  if(!isDefined(var3[0])) {
    return;
  }

  if(getcost(var4, var1)) {
    return;
  }

  var3[0].should_take_damage_from_trigger_hurt = 0;
}

function getcost(var0, var1) {
  var2 = squared(300);

  foreach(var4 in var0) {
    if(distance2dsquared(var1, var4.origin) <= var2) {
      return true;
    }
  }

  return false;
}

function weapon_xp_iw8_sm_beta(var0, var1, var2) {
  if(!scripts\engine\utility::flag("care_package_vo_playing")) {
    scripts\engine\utility::flag_set("care_package_vo_playing");

    if(var1 == 1) {
      thread ref_12758("dx_mpo_usop_airdrop_use");
    } else if(var1 > 1) {
      thread ref_12758("dx_mpo_usop_airdrop_multiple_use");
    }

    scripts\engine\utility::delaythread(6, &scripts\engine\utility::flag_clear, "care_package_vo_playing");
  }

  var3 = scripts\cp\laser_traps\cp_laser_traps::get_drone_target_loc();
  var4 = squared(70);

  for(var5 = 0; var5 < var1; var5++) {
    if(!isDefined(var2)) {
      var2 = var5;
    }

    var6 = level.minigun_right[var2];

    if(!isDefined(var6)) {
      var6 = level.minigun_right[0];
    }

    var7 = var6.script_radius;
    var8 = var6.script_radius;
    var9 = var6.angles;
    var10 = var6.origin;

    if(istrue(var6.should_take_damage_from_trigger_hurt)) {
      var10 = getclosestmatchingmasterlootnode(var3, var10, var4);
    }

    var6.should_take_damage_from_trigger_hurt = 1;

    if(var0 == "incendiary_launcher") {
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var7, var8, var9, var10, undefined, &weapon_xp_iw8_sm_mpapa5);
    } else {
      thread scripts\cp\laser_traps\cp_laser_traps::get_driver_interaction_hint_string(var7, var8, var9, var10, var0, &weapon_xp_iw8_sm_mpapa7);
    }

    wait 3;
  }
}

function weapon_xp_iw8_sm_mpapa5(var0, var1, var2) {
  wait 0.1;
  var3 = scripts\cp\cp_weapon::buildweapon("iw8_la_mike32_mp", ["calcust", "lnchrscope_mike32"]);
  var4 = createheadicon(var3);
  var5 = spawn("weapon_" + var4, var1 + (0, 0, 20));
  var5 physicslaunchserveritem(var5.origin, (0, 0, 1250));
  thread start_end_breach_fx(var5, var0);
}

function get_drop_location(var0) {
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, (0, 0, 90));
  var1 show();
  var1 linkTo(var0);
  wait 0.15;
  var1.origin = var0.origin;
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var1, "tag_origin");
  var0 waittill("trigger");
  var1 delete();
}

function start_end_breach_fx(var0, var1) {
  thread scripts\cp\cp_outline_utility::outlineenableforall(var0, "outline_depth_white", "equipment");
  var0 itemweaponsetammo(6, 6);
  var0 waittill("trigger");
  var1 thread scripts\mp\trials\trial_pitcher::firemanager();
}

function ref_134ed(var0, var1, var2) {
  while(scripts\engine\utility::flag("spawning_in_progress")) {
    wait 0.1;
  }

  scripts\engine\utility::flag_set("spawning_in_progress");
  wait 0.5;
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");
  var4 = [];

  if(!isDefined(var3) || var3.size < 1) {
    return;
  }

  if(isDefined(var2)) {
    var3 = sortbydistance(var3, var2);
  }

  if(!isDefined(var1)) {
    var1 = ref_130a1();
  }

  var5 = 0;

  for(var6 = 0; var6 < var1; var6++) {
    if(var5 >= var3.size - 1) {
      var5 = 0;
      var3 = scripts\engine\utility::array_reverse(var3);
    }

    while(scripts\engine\utility::flag("pause_mission_spawning") || getaiarray("axis").size >= ref_130a1() || getaiarray().size > 37) {
      wait 0.2;
    }

    var7 = var3[var5] scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);

    if(!isDefined(var7)) {
      continue;
    }

    var8 = level.players;
    var9 = [];

    foreach(var11 in var8) {
      if(getdefaultstreamhinttimeoutms(var11)) {
        var9 = var11;
      }
    }

    var8 = scripts\engine\utility::array_remove_array(var8, var9);
    var11 = scripts\engine\utility::random(var8);

    if(isDefined(var11)) {
      var7 getenemyinfo(var11);
    }

    var7.goalheight = 30;
    var7 scripts\engine\utility::set_movement_speed(300);
    var4 = var7;

    if(isDefined(var3[var5].count)) {
      var3[var5].count++;
    }

    if(scripts\engine\utility::is_equal(var7.team, "axis")) {
      var7 setthreatbiasgroup("axis");
    }

    var5++;

    if(!isDefined(var3[var5]) || var4.size >= var1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
  scripts\engine\utility::flag_clear("spawning_in_progress");
  return var4;
}

function ref_134f0(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "targetname");

  if(!isDefined(var1) || getaiarray().size > 40) {
    return;
  }

  var2 = var1 scripts\cp\laser_traps\cp_laser_traps::spawn_ai(0);
  var2 scripts\engine\utility::set_movement_speed(300);
  var2.goalheight = 30;

  if(isDefined(var1.count)) {
    var1.count++;
  }

  if(isDefined(var2) && scripts\engine\utility::is_equal(var2.team, "axis")) {
    var2 setthreatbiasgroup("axis");
  }

  waitframe();
  return var2;
}

function ref_1352b(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  var5 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var0, var1, var2, var4, var3);
  var5 scripts\engine\utility::set_movement_speed(300);
  var5.goalheight = 30;
  waitframe();
  return var5;
}

function ref_1352c(var0, var1, var2, var3) {
  var4 = [];

  foreach(var6 in var1) {
    var7 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var0, var6[0], var6[1], var3, var2);
    var7 scripts\engine\utility::set_movement_speed(300);
    var7.goalheight = 30;
    var4 = var7;
    waitframe();
  }

  return var4;
}

function set_start_pos(var0) {
  foreach(var2 in level.players) {
    level thread scripts\cp\utility::teleportplayertoteamstructs(var2, var0);
  }
}

function ref_124a6() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var0 = "iw8_sm_mpapa7";
  var1 = ["laserirsmg", "thermal_west01", "gripangpro", "linearbrakesmg", "compsmg", "muzzlemelee01", "muzzlemelee02", "brakesmg", "pistolgrip01_mpapa7"];
  var2 = "iw8_sn_mike14_mp";
  GscBinSkip1(0x45, 0, scripts\cp\cp_weapon::buildweapon(var0, var1, "none", "none", -1));
}

function hostagetemppistol() {
  self endon("death_or_disconnect");
  self.ref_14389 = 1;
  waitframe();
  var1 = newclienthudelem(self);
  var1.x = 0;
  var1.y = 0;
  var1 setshader("black", 640, 480);
  var1.alignx = "left";
  var1.aligny = "top";
  var1.sort = 1;
  var1.horzalign = "fullscreen";
  var1.vertalign = "fullscreen";
  var1.alpha = 1;
  var1.foreground = 1;
  var1.lowresbackground = 1;
  var2 = 1;
  precacherumble("cp_wheelson_rumble");
  precacherumble("damage_heavy");
  var3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self playerlinkTo(var3, undefined, 0, 90, 90, 90, 90);
  thread vehicle_preventplayercollisiondamagefortimeafterexitinternal();
  self disableweapons();
  scripts\engine\utility::flag_wait("players_connected");
  thread persistantgametypeteamassign();
  wait 8;
  scripts\engine\utility::flag_set("fade_in");
  var1 fadeovertime(var2);
  var1.alpha = 0;
  completepayloadpunish(1, 1);
  self unlink();
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_hide_minimap", 0);
  self enableweapons();
  wait 2;

  if(isDefined(var1)) {
    var1 destroy();
  }

  var3 delete();
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

function completepayloadpunish(var0, var1, var2) {
  var3 = self;

  if(!isPlayer(var3)) {
    return;
  }

  var3.movespeedscale = 0;
  var3 setmovespeedscale(0);

  if(!isDefined(var3.movespeedscale)) {
    var3.movespeedscale = 1;
  }

  var4 = &movespeed_get_func;
  var5 = &movespeed_set_func;
  thread player_speed_proc(var3, var0, var1, var4, var5, "blend_movespeedscale");
}

function player_speed_proc(var0, var1, var2, var3, var4, var5) {
  self notify(var4);
  self endon(var4);
  var6 = [[var2]](var5);
  var7 = var0;

  if(isDefined(var1) && var1 > 0) {
    var8 = var7 - var6;
    var9 = 0.05;
    var10 = var1 / var9;
    var11 = var8 / var10;

    while(abs(var7 - var6) > abs(var11 * 1.1)) {
      var6 += var11;
      [[var3]](var6, var5);
      wait var9;
    }
  }

  [[var3]](var7, var5);
}

function movespeed_get_func(var0) {
  if(!isDefined(var0)) {
    var0 = "default";
  }

  if(!isDefined(self.movespeedscales) || !isDefined(self.movespeedscales[var0])) {
    return 1;
  }

  return self.movespeedscales[var0];
}

function movespeed_set_func(var0, var1) {
  var2 = 1;

  if(!isDefined(var1)) {
    var1 = "default";
  }

  self.movespeedscales[var1] = var0;

  foreach(var0 in self.movespeedscales) {
    if(var0 == 1) {
      self.movespeedscales = scripts\engine\utility::array_remove_key(self.movespeedscales, var4);
    }

    var2 *= var0;
  }

  self.movespeedscale = var2;
  self setmovespeedscale(self.movespeedscale);
}

function ref_1247b(var0) {}

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var0])) {
    var1 = level.objectivestabledata[var0];

    if(isDefined(var1.ondebugstartfunc)) {
      [[var1.ondebugstartfunc]](var1);
    }

    thread scripts\cp\cp_objectives::run_objective(var1.objname, var1.questtype);
    return;
  }
}

function onplayerspawneddevguisetup(var0) {
  var1 = var0.name;
  var2 = undefined;

  foreach(var4 in level.players) {
    if(var4 == var0) {
      var2 = int(var5);
      break;
    }
  }

  if(isDefined(var2)) {
    thread setupdevguientries(var0, var0, var1);
    return;
  }
}

function setupdevguientries(var0, var1, var2) {}

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
    var0 = getDvar("scr_strike_name");
    var1 = undefined;

    switch (var0) {
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

function onplayerconnect(var0) {}

function interaction_trigger_properties(var0, var1, var2) {
  switch (var1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var1.useduration)) {
        self.interaction_trigger setuseholdduration(var1.useduration);
      }

      break;
  }
}

function laser_control_station_use_monitor() {
  var0 = [];
  var1 = scripts\engine\utility::getStructArray("helicopter_ai", "script_noteworthy");

  foreach(var3 in var1) {
    if(var3.targetname == "exfil_heli_nodes_01") {
      var0 = var3;
    }
  }

  scripts\engine\utility::deletestructarray_ref(var0);
}

function ref_134eb(var0, var1, var2) {
  var3 = scripts\cp\laser_traps\cp_laser_traps::ref_134f1(var0, var1.origin, var1.angles);

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3.script_startingposition = var2;
  var1 scripts\common\vehicle_aianim::guy_enter(var3);
  return var3;
}

function propchange(var0) {
  GscBinSkip1(0x45, 1, 0);
}

function ref_130a1() {
  GscBinSkip1(0x45, 1, 0);
}

function c130_drop(var0, var1) {
  foreach(var3 in level.players) {
    if(distancesquared(var3.origin, var0) <= var1 * var1) {
      return true;
    }
  }

  return false;
}

function c130_door_badplace_id(var0, var1) {
  foreach(var3 in level.players) {
    if(distance2dsquared(var3.origin, var0) <= var1 * var1) {
      return true;
    }
  }

  return false;
}

function brevent1playerthink(var0, var1) {
  foreach(var3 in level.players) {
    if(distance2dsquared(var3.origin, var0) > var1 * var1) {
      return false;
    }
  }

  return true;
}

function brevent1playervalid(var0, var1, var2) {
  foreach(var4 in level.players) {
    if(distance2dsquared(var4.origin, var0) > var1 * var1 || var4.origin[2] > var2) {
      return false;
    }
  }

  return true;
}

function ref_12758(var0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var1 = lookupsoundlength(var0) * 0.001;
  level.ref_121a7 playSound(var0);
  wait var1;
}

function brenableagents(var0, var1, var2) {
  var3 = 1;
  jumpiffalse(!isDefined(var1) || var1 == "x") LOC_0000001b;
  var3 = 0;

  for(;;) {
    var4 = 0;

    foreach(var6 in level.players) {
      if(var6.origin[var3] > var0) {
        var4++;
      }
    }

    if(var4 >= level.players.size) {
      break;
    }

    wait 0.5;
  }

  scripts\engine\utility::flag_set(var2);
}

function getdefaultstreamhinttimeoutms() {
  return self.inlaststand;
}

function ref_1238d(var0, var1, var2, var3, var4) {
  for(;;) {
    wait 0.5;

    if(getaiarrayinradius(var0, 80).size > 0) {
      badplace_cylinder("moody_traversal_ent", 5, var0, var1, var2, var3);

      if(isDefined(var4) && var3 != var4) {
        badplace_cylinder("moody_traversal_ent", 5, var0, var1, var2, var4);
      }

      wait 5;
    }
  }
}