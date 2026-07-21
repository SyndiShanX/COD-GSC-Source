/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\script_funcs.gsc
***********************************************/

soldier_init(var_0, var_1, var_2) {
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  self.asm.frantic = 0;
  self.arrivalspeed = 1.0;
  self.defaultturnthreshold = 59;
  scripts\common\utility::clear_movement_speed();
  self.asm.gestures = spawnStruct();

  if(isDefined(self.fnasm_initfingerposes))
    self thread[[self.fnasm_initfingerposes]]();

  self.fnhelmetpop = scripts\asm\soldier\death::helmetpop;
  initnodeyaw(self.asm.archetype);
  initgrenadeoffsets();
  initaimlimits(var_0);

  if(self.asm.archetype == "juggernaut" || self.asm.archetype == "juggernaut_cp")
    scripts\asm\juggernaut\juggernaut::initanimspeedthresholds_juggernaut(self.asm.archetype);
  else
    initanimspeedthresholds_soldier(self.asm.archetype);

  if(scripts\asm\shared\utility::getbasearchetype() == "soldier_lw") {
    self.disablepistol = 1;
    self.disablelmgmount = 1;
    self.a.disablelongdeath = 1;
  }

  isnavmeshloaded();
  initgestures();

  if(self isscriptable())
    thread initscriptable();

  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var_3 = weaponclass(self.weapon);

  if(var_3 == "mg")
    self.combatmode = "cover_lmg";

  scripts\anim\shared.gsc::updateweaponarchetype(var_3);
}

initscriptable() {
  self endon("death");
  scripts\engine\utility::flag_wait("scriptables_ready");
  self setscriptablepartstate("notetrack_handler", "active", 0);
}

initnodeyaw(var_0) {
  if(!isDefined(anim.nodeyaws))
    anim.nodeyaws = [];

  if(isDefined(anim.nodeyaws[var_0])) {
    return;
  }
  initnodeyaw_soldier(var_0);
}

initnodeyaw_soldier(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 90;
  var_1["Cover Left Crouch"] = 90;
  var_1["Cover Right"] = -90;
  var_1["Cover Right Crouch"] = -90;
  var_1["Cover Crouch"] = -90;
  var_1["Cover Stand"] = -90;
  var_1["Cover Stand 3D"] = -90;
  anim.nodeyaws[var_0] = var_1;
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim.franticnodeyaws[var_0] = var_1;
  var_2 = [];
  var_2["Aim Down"] = 45;
  anim.nodeexposedpitches[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Right Crouch"] = 0;
  var_1["Cover Left"] = 0;
  anim.nodeleanyaws[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim.nodeleanpitches[var_0] = var_2;
  var_2 = [];
  var_2["Cover Left Crouch"] = 45;
  var_2["Cover Right Crouch"] = 45;
  anim.nodeoverleanpitches[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim.franticnodeleanyaws[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim.franticnodeexposedyaws[var_0] = var_1;
}

initnodeyaw_dev(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 90;
  var_1["Cover Right"] = -90;
  var_1["Cover Crouch"] = -90;
  var_1["Cover Stand"] = -90;
  var_1["Cover Stand 3D"] = -90;
  anim.nodeyaws[var_0] = var_1;
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim.franticnodeyaws[var_0] = var_1;
  var_2 = [];
  anim.nodeexposedpitches[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 0;
  var_1["Cover Right Crouch"] = 90;
  var_1["Cover Left"] = -90;
  anim.nodeleanyaws[var_0] = var_1;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim.nodeleanpitches[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim.franticnodeleanyaws[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim.franticnodeexposedyaws[var_0] = var_1;
}

initnodeyaw_rebel(var_0) {
  var_1 = [];
  var_1["Cover Left"] = 180;
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Crouch"] = 180;
  var_1["Cover Stand"] = 180;
  var_1["Cover Stand 3D"] = 180;
  anim.nodeyaws[var_0] = var_1;
  var_2 = [];
  var_2["Aim Down"] = 45;
  anim.nodeexposedpitches[var_0] = var_2;
  var_2 = [];
  var_2["Cover Crouch"] = 45;
  anim.nodeleanpitches[var_0] = var_2;
  var_1 = [];
  var_1["Cover Left Crouch"] = 0;
  var_1["Cover Right"] = 180;
  var_1["Cover Right Crouch"] = 180;
  anim.nodeleanyaws[var_0] = var_1;
  var_1 = [];
  var_1["Cover Crouch"] = 0;
  var_1["Cover Left Crouch"] = 0;
  anim.nodeexposedyaws[var_0] = var_1;
}

initaimlimits(var_0) {
  if(!isDefined(level.combataimlimits)) {
    level.combataimlimits = [];
    level.franticaimlimits = [];
    level.aimlimitstatemappings = [];
  }

  if(!isDefined(level.combataimlimits[var_0])) {
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_1["exposed_idle"] = var_3;
    var_3 = [];
    var_2["exposed_idle"] = var_3;
    var_3 = [];
    var_3["down"] = 15;
    var_1["cover_crouch_lean"] = var_3;
    var_3 = [];
    var_3["down"] = 15;
    var_2["cover_crouch_lean"] = var_3;
    var_3 = [];
    var_2["cover_crouch_aim"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_1["cover_left_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_2["cover_left_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_1["cover_left_crouch_lean"] = var_3;
    var_3 = [];
    var_3["right"] = -15;
    var_2["cover_left_crouch_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 15;
    var_1["cover_right_lean"] = var_3;
    var_3 = [];
    var_3["down"] = 37;
    var_3["left"] = 24;
    var_2["cover_right_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 25;
    var_1["cover_right_crouch_lean"] = var_3;
    var_3 = [];
    var_3["left"] = 15;
    var_2["cover_right_crouch_lean"] = var_3;
    level.combataimlimits[var_0] = var_1;
    level.franticaimlimits[var_0] = var_2;
  }

  if(!isDefined(level.aimlimitstatemappings[var_0])) {
    var_4 = [];
    var_4["cover_stand_exposed"] = "cover_stand_exposed";
    var_4["cover_stand_hide_to_exposed"] = "cover_stand_exposed";
    var_4["cover_stand_full_exposed"] = "exposed_idle";
    var_4["cover_stand_hide_to_full_exposed"] = "exposed_idle";
    var_4["cover_stand_to_exposed_idle"] = "exposed_idle";
    var_4["wall_run_exit"] = "exposed_idle";
    var_4["wall_run_continue"] = "exposed_idle";
    var_4["wall_run_left_shoot"] = "exposed_idle";
    var_4["wall_run_right_shoot"] = "exposed_idle";
    var_4["wall_run_attach_left_shoot"] = "exposed_idle";
    var_4["wall_run_attach_right_shoot"] = "exposed_idle";
    var_4["cover_crouch_hide_to_stand"] = "exposed_idle";
    var_4["cover_crouch_hide_to_aim"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_right"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_left"] = "cover_crouch_aim";
    var_4["cover_crouch_hide_to_lean"] = "cover_crouch_lean";
    var_4["cover_crouch_aim"] = "cover_crouch_aim";
    var_4["cover_crouch_lean"] = "cover_crouch_lean";
    var_4["cover_crouch_exposed_left"] = "cover_crouch_aim";
    var_4["cover_crouch_exposed_right"] = "cover_crouch_aim";
    var_4["cover_crouch_stand"] = "exposed_idle";
    var_4["cover_crouch_to_exposed_idle"] = "exposed_idle";
    var_4["cover_right_exposed_a"] = "exposed_idle";
    var_4["cover_right_hide_to_a"] = "exposed_idle";
    var_4["cover_right_exposed_b"] = "exposed_idle";
    var_4["cover_right_hide_to_b"] = "exposed_idle";
    var_4["cover_right_a_to_b"] = "exposed_idle";
    var_4["cover_right_b_to_a"] = "exposed_idle";
    var_4["cover_right_crouch_exposed_a"] = "exposed_idle";
    var_4["cover_right_crouch_exposed_b"] = "exposed_idle";
    var_4["cover_right_crouch_hide_to_a"] = "exposed_idle";
    var_4["cover_right_crouch_hide_to_b"] = "exposed_idle";
    var_4["cover_right_crouch_a_to_b"] = "exposed_idle";
    var_4["cover_right_crouch_b_to_a"] = "exposed_idle";
    var_4["cover_right_lean"] = "cover_right_lean";
    var_4["cover_right_hide_to_lean"] = "cover_right_lean";
    var_4["cover_right_crouch_hide_to_lean"] = "cover_right_crouch_lean";
    var_4["cover_right_crouch_lean"] = "cover_right_crouch_lean";
    var_4["cover_right_to_exposed_idle"] = "exposed_idle";
    var_4["cover_left_exposed_a"] = "exposed_idle";
    var_4["cover_left_exposed_b"] = "exposed_idle";
    var_4["cover_left_hide_to_a"] = "exposed_idle";
    var_4["cover_left_hide_to_b"] = "exposed_idle";
    var_4["cover_left_a_to_b"] = "exposed_idle";
    var_4["cover_left_b_to_a"] = "exposed_idle";
    var_4["cover_left_hide_to_lean"] = "cover_left_lean";
    var_4["cover_left_lean"] = "cover_left_lean";
    var_4["cover_left_crouch_hide_to_lean"] = "cover_left_crouch_lean";
    var_4["cover_left_crouch_lean"] = "cover_left_crouch_lean";
    var_4["cover_left_to_exposed_idle"] = "exposed_idle";
    var_4["cqb_idle"] = "exposed_idle";
    var_4["cqb_stand_loop"] = "exposed_idle";
    var_4["cqb_stand_strafe_loop"] = "exposed_idle";
    var_4["stand_run_strafe_loop"] = "exposed_idle";
    var_4["exposed_reload"] = "exposed_idle";
    var_4["exposed_weaponswitch"] = "exposed_idle";
    var_4["exposed_stand_turn"] = "exposed_idle";
    var_4["exposed_idle"] = "exposed_idle";
    var_4["exposed_prone"] = "exposed_idle";
    var_4["exposed_stand_infantry_reaction"] = "exposed_idle";
    level.aimlimitstatemappings[var_0] = var_4;
  }
}

initanimspeedthresholds_soldier(var_0) {
  if(hasanimspeedthresholdstring(var_0)) {
    return;
  }
  if(var_0 == "boss" || var_0 == "boss2")
    animspeedthresholdsexist(var_0, "shuffle", 30);
  else
    animspeedthresholdsexist(var_0, "shuffle", 23);

  animspeedthresholdsexist(var_0, "walk", 56);
  animspeedthresholdsexist(var_0, "fast", 120);
  animspeedthresholdsexist(var_0, "jog", 170);
  animspeedthresholdsexist(var_0, "run", 220);
  animspeedthresholdsexist(var_0, "sprint", 250);
}

initgestures() {
  if(isDefined(anim.gestures)) {
    return;
  }
  var_0 = [];
  var_0[var_0.size] = "point_casual";
  var_0[var_0.size] = "point_military";
  var_0[var_0.size] = "yes";
  var_0[var_0.size] = "no";
  var_0[var_0.size] = "hold";
  var_0[var_0.size] = "talk";
  var_0[var_0.size] = "shrug";
  var_0[var_0.size] = "getdown";
  var_0[var_0.size] = "nvg_on";
  var_0[var_0.size] = "nvg_off";
  var_0[var_0.size] = "beckon";
  anim.gestures = var_0;
}

initgrenadeoffsets() {
  if(!isDefined(anim.grenadethrowanims))
    anim.grenadethrowanims = [];

  if(!isDefined(anim.grenadethrowoffsets))
    anim.grenadethrowoffsets = [];

  var_0 = self.asm.archetype == "soldier_lw";
  var_1 = !var_0;

  if(isDefined(anim.grenadethrowanims["soldier"]) && isDefined(anim.grenadethrowoffsets["soldier"])) {
    return;
  }
  anim.islightweightsoldier = var_0;
  anim.isfullsoldier = var_1;
  anim.grenadethrowanims["soldier"] = [];
  anim.grenadethrowoffsets["soldier"] = [];
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_short"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_short");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_short"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_short"][0] = (82.8191, 11.6735, 28.1425);
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_long"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_long");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"][0] = (82.8191, 11.6735, 28.1425);
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_long"][1] = (108.037, 19.9333, 58.7747);
  anim.grenadethrowanims["soldier"]["grenade_return_throw"]["throw_default"] = scripts\asm\asm::asm_getallanimindicesforalias("grenade_return_throw", "throw_default");
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_default"] = [];
  anim.grenadethrowoffsets["soldier"]["grenade_return_throw"]["throw_default"][0] = (108.037, 19.9333, 58.7747);
  anim.grenadethrowanims["soldier"]["cover_stand_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_stand_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"][0] = (12.4289, 10.4494, 63.257);
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_exposed"][1] = (19.6744, -0.861649, 55.6794);
  anim.grenadethrowanims["soldier"]["cover_stand_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_stand_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"][0] = (12.4289, 10.4494, 63.257);
  anim.grenadethrowoffsets["soldier"]["cover_stand_grenade"]["grenade_safe"][1] = (19.6744, -0.861649, 55.6794);
  anim.grenadethrowanims["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_exposed"][0] = (14.4711, 19.9796, 60.7207);
  anim.grenadethrowanims["soldier"]["cover_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_crouch_grenade"]["grenade_safe"][0] = (16.2644, 3.3802, 58.673);
  anim.grenadethrowanims["soldier"]["cover_right_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_exposed"][0] = (52.7985, -16.1898, 71.2437);
  anim.grenadethrowanims["soldier"]["cover_right_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_grenade"]["grenade_safe"][0] = (23.61, 1.79103, 73.2797);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_exposed"][0] = (52.6922, -11.2103, 74.5468);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade"]["grenade_safe"][0] = (29.3343, -4.89863, 47.8837);
  anim.grenadethrowanims["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_right_crouch_grenade_throw", "grenade_throw");
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][0] = (15.5324, 4.86811, 50.6292);
  anim.grenadethrowoffsets["soldier"]["cover_right_crouch_grenade_throw"]["grenade_throw"][1] = (1.17014, -1.57043, 60.0271);
  anim.grenadethrowanims["soldier"]["cover_left_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_exposed"][0] = (52.9483, -8.80599, 69.6026);
  anim.grenadethrowanims["soldier"]["cover_left_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_grenade"]["grenade_safe"][0] = (29.9023, 0.265982, 33.1921);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade", "grenade_exposed");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_exposed"][0] = (70.3568, 6.78523, 61.5581);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade", "grenade_safe");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_safe"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade"]["grenade_safe"][0] = (24.2908, -7.09458, 21.4564);
  anim.grenadethrowanims["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = scripts\asm\asm::asm_getallanimindicesforalias("cover_left_crouch_grenade_throw", "grenade_throw");
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"] = [];
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][0] = (0.306949, -4.18872, 12.3224);
  anim.grenadethrowoffsets["soldier"]["cover_left_crouch_grenade_throw"]["grenade_throw"][1] = (-7.34781, 1.87832, 25.0602);
  anim.grenadethrowanims["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_throw_grenade"]["exposed_grenade"][0] = (30.5741, 1.97765, 73.9287);
  anim.grenadethrowanims["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_prone_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_prone_throw_grenade"]["exposed_grenade"][0] = (28.3429, 6.4308, 40.3279);
  anim.grenadethrowanims["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_crouch_throw_grenade", "exposed_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_grenade"][0] = (15.7078, 1.95027, 36.0834);
  anim.grenadethrowanims["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = scripts\asm\asm::asm_getallanimindicesforalias("exposed_crouch_throw_grenade", "exposed_crouch_grenade");
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"] = [];
  anim.grenadethrowoffsets["soldier"]["exposed_crouch_throw_grenade"]["exposed_crouch_grenade"][0] = (15.7078, 1.95027, 36.0834);
}

needtoturnformelee(var_0, var_1, var_2, var_3) {
  if(!istrue(self._blackboard.meleerequestedcharge))
    return 0;

  var_4 = scripts\asm\asm_bb::bb_getmeleechargetarget();

  if(!isDefined(var_4))
    return 0;

  var_5 = var_4.origin - self.origin;
  var_6 = length(var_5);

  if(var_6 > 80)
    return 0;

  var_7 = vectortoyaw(var_5);

  if(scripts\engine\utility::absangleclamp180(var_7 - self.angles[1]) < 90)
    return 0;

  self.desiredturnyaw = var_7;
  return 1;
}

needtoturntofacepath(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "abort"))
    return 0;

  if(!self.facemotion)
    return 0;

  var_4 = vectortoyaw(self.lookaheaddir);
  var_5 = angleclamp180(var_4 - self.angles[1]);

  if(abs(var_5) < 50)
    return 0;

  self.desiredturnyaw = var_5;
  return 1;
}

drawneedtoturn(var_0) {
  self notify("kill_draw_need_to_turn");
  self endon("kill_draw_need_to_turn");

  for(;;) {
    var_1 = self.origin + anglesToForward(self.angles) * 100;
    waitframe();
  }
}

needtoturn(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos))
      var_4 = self._blackboard.shootparams_pos;
    else if(isDefined(self._blackboard.shootparams_ent))
      var_4 = self._blackboard.shootparams_ent.origin;
  }

  if(!isDefined(var_4)) {
    if(isDefined(self.smartfacingpos))
      var_4 = self.smartfacingpos;
  }

  if(!isDefined(var_4) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36 && self.combatmode != "no_cover")
    var_4 = self.node.origin + anglesToForward(self.node.angles) * 384;

  if(!isDefined(var_4))
    return 0;

  var_5 = self.angles[1] - vectortoyaw(var_4 - self.origin);
  var_6 = distancesquared(self.origin, var_4);

  if(var_6 < 65536) {
    var_7 = sqrt(var_6);

    if(var_7 > 3)
      var_5 = var_5 + asin(-3 / var_7);
  }

  return abs(angleclamp180(var_5)) > self.turnthreshold;
}

needtoturn3d(var_0, var_1, var_2, var_3) {
  if(istrue(self.matchexposednodeorientation) && isDefined(self.node))
    return 0;

  var_4 = getturndesiredyaw3d();

  if(abs(var_4) > self.turnthreshold)
    return 1;

  var_5 = getturndesiredpitch3d();

  if(abs(var_5) > self.pitchturnthreshold)
    return 1;

  return 0;
}

getturndesiredyaw() {
  if(isDefined(self.desiredturnyaw))
    return self.desiredturnyaw;

  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_pos))
      var_2 = self._blackboard.shootparams_pos;
    else if(isDefined(self._blackboard.shootparams_ent))
      var_1 = self._blackboard.shootparams_ent;
  } else if(isDefined(self.smartfacingpos))
    var_2 = self.smartfacingpos;

  if(!isDefined(var_2) && isDefined(self.node) && self.node.type == "Exposed" && distancesquared(self.node.origin, self.origin) < 36)
    return self.node.angles[1] - self.angles[1];

  if(isDefined(var_1) && !issentient(var_1))
    var_0 = 1.5;

  var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos(var_0, var_1, var_2);
  return var_3;
}

getturndesiredyaw3d() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent))
      var_1 = self._blackboard.shootparams_ent;
    else if(isDefined(self._blackboard.shootparams_pos))
      var_2 = self._blackboard.shootparams_pos;
  } else if(isDefined(self.enemy))
    var_1 = self.enemy;

  if(isDefined(var_1) && !issentient(var_1))
    var_0 = 1.5;

  var_3 = scripts\engine\utility::getpredictedaimyawtoshootentorpos3d(var_0, var_1, var_2);
  return var_3;
}

getturndesiredpitch3d() {
  var_0 = 0.25;
  var_1 = undefined;
  var_2 = undefined;

  if(scripts\asm\asm_bb::bb_shootparamsvalid()) {
    if(isDefined(self._blackboard.shootparams_ent))
      var_1 = self._blackboard.shootparams_ent;
    else if(isDefined(self._blackboard.shootparams_pos))
      var_2 = self._blackboard.shootparams_pos;
  } else if(isDefined(self.enemy))
    var_1 = self.enemy;

  if(isDefined(var_1) && !issentient(var_1))
    var_0 = 1.5;

  var_3 = scripts\engine\utility::getpredictedaimpitchtoshootentorpos3d(var_0, var_1, var_2);
  return var_3;
}

chooseturnanim(var_0, var_1, var_2) {
  var_3 = getturndesiredyaw();

  if(var_3 < 0)
    var_4 = "right";
  else
    var_4 = "left";

  var_3 = abs(var_3);
  var_5 = 0;

  if(var_3 > 157.5)
    var_5 = 180;
  else if(var_3 > 112.5)
    var_5 = 135;
  else if(var_3 > 67.5 || !istrue(self.allowturn45))
    var_5 = 90;
  else
    var_5 = 45;

  var_6 = var_4 + "_" + var_5;
  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  return var_7;
}

chooseturnanim3d(var_0, var_1, var_2) {
  var_3 = getturndesiredyaw3d();
  var_4 = getturndesiredpitch3d();

  if(abs(var_3) > self.turnthreshold && abs(var_3) > abs(var_4)) {
    if(var_3 < 0)
      var_5 = "right";
    else
      var_5 = "left";

    var_3 = abs(var_3);
    var_6 = 0;

    if(var_3 > 157.5)
      var_6 = 180;
    else if(var_3 > 112.5)
      var_6 = 135;
    else if(var_3 > 67.5)
      var_6 = 90;
    else
      var_6 = 45;

    var_7 = var_5 + "_" + var_6;
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_7);
    return var_8;
  } else {
    if(var_4 < 0)
      var_5 = "up";
    else
      var_5 = "down";

    var_4 = abs(var_4);
    var_6 = 0;

    if(var_4 > 157.5)
      var_6 = 180;
    else if(var_4 > 112.5)
      var_6 = 135;
    else if(var_4 > 67.5)
      var_6 = 90;
    else
      var_6 = 45;

    var_7 = var_5 + "_" + var_6;
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_7);
    return var_8;
  }
}

choosecrouchturnanim(var_0, var_1, var_2) {
  var_3 = getturndesiredyaw();

  if(var_3 < -135)
    var_4 = "2r";
  else if(var_3 > 135)
    var_4 = "2l";
  else if(var_3 < 0)
    var_4 = "6";
  else
    var_4 = "4";

  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return var_5;
}

reload_cleanup(var_0, var_1, var_2) {
  var_3 = self.asm.reloadweapon;
  self.asm.reloadweapon = undefined;

  if(!isDefined(self.weaponinfo)) {
    return;
  }
  var_4 = isDefined(var_3) && isDefined(self.weapon) && var_3 == self.weapon;

  if(!isDefined(var_3))
    var_3 = self.weapon;

  var_5 = createheadicon(var_3);

  if(!isDefined(self.weaponinfo[var_5])) {
    return;
  }
  if(!scripts\asm\asm::asm_eventfired(var_0, "drop clip")) {
    return;
  }
  if(self.weaponinfo[var_5].useclip) {
    var_6 = getweaponclipmodel(var_3);

    if(isDefined(var_6)) {
      var_7 = scripts\asm\asm::asm_eventfired(var_0, "attach clip left") || scripts\asm\asm::asm_eventfired(var_0, "attach clip right");
      var_8 = scripts\asm\asm::asm_eventfired(var_0, "detach clip left") || scripts\asm\asm::asm_eventfired(var_0, "detach clip right") || scripts\asm\asm::asm_eventfired(var_0, "detach clip nohand");

      if(!var_7)
        self notify("abort_reload");
      else if(var_7 && !var_8) {
        if(scripts\asm\asm::asm_eventfired(var_0, "attach clip left"))
          var_9 = "tag_accessory_left";
        else
          var_9 = "tag_accessory_right";

        self detach(var_6, var_9);
        self notify("clip_detached");

        if(var_4)
          scripts\anim\shared.gsc::showweaponmagattachment(var_5);
      }
    }
  }
}

terminateexposedprone(var_0, var_1, var_2) {
  self.pushable = 1;
}

playexposedproneloop(var_0, var_1, var_2) {
  self.pushable = 0;
  playexposedloop(var_0, var_1, var_2);
}

playexposedloop(var_0, var_1, var_2) {
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  var_3 = self asmgetstatetransitioningfrom(var_0);

  if(isDefined(var_3) && (var_3 == "stand_run_loop" || var_3 == "move_walk_loop" || var_3 == "patrol_move" || var_3 == "cqb_stand_loop"))
    childthread scripts\asm\shared\utility::setuseanimgoalweight(var_1, 0.2);

  if(isDefined(self.node))
    self._blackboard.lastusednode = self.node;

  if(self.team != "allies")
    thread faceenemywhenneeded(var_1);

  scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1.0);
}

playexposedcrouchloop(var_0, var_1, var_2) {
  playexposedloop(var_0, var_1, var_2);
}

playexposedidleaimdownloop(var_0, var_1, var_2) {
  self.aimingdown = 1;
  playexposedloop(var_0, var_1, var_2);
}

playexposedcrouchaimdownloop(var_0, var_1, var_2) {
  self.aimingdown = 1;
  playexposedcrouchloop(var_0, var_1, var_2);
}

terminateexposedidleaimdown(var_0, var_1, var_2) {
  self.aimingdown = 0;
}

terminateexposedcrouchaimdown(var_0, var_1, var_2) {
  self.aimingdown = 0;
}

faceenemywhenneeded(var_0) {
  self endon(var_0 + "_finished");
  var_1 = self.maxfaceenemydist * self.maxfaceenemydist;

  for(;;) {
    waitframe();

    if(shouldfaceenemyinexposed()) {
      var_2 = distancesquared(self.origin, self.enemy.origin);

      if(var_2 < var_1)
        self orientmode("face enemy");
      else
        self orientmode("face current");

      continue;
    }

    self orientmode("face current");
  }
}

terminateexposedcrouch(var_0, var_1, var_2) {}

shouldfaceenemyinexposed() {
  if(isDefined(self.pathgoalpos))
    return 0;

  return isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(self.enemy);
}

playanim_weaponswitch(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm_bb::bb_getrequestedweapon();
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\anim\combat_utility.gsc::fasteranimspeed();
  self aisetanim(var_1, var_4, var_5);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_1, var_4));
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  self notify("switched_to_sidearm");
  scripts\common\gameskill::didsomethingotherthanshooting();
}

terminate_weaponswitch(var_0, var_1, var_2) {
  var_3 = weaponclass(self.weapon);
  scripts\anim\shared.gsc::updateweaponarchetype(var_3);
}

playturnanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  pushdisabledgunpose();
  scripts\common\gameskill::didsomethingotherthanshooting();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);

  if(scripts\engine\utility::actor_is3d() && isDefined(self.enemy))
    self orientmode("face enemy");
  else
    self orientmode("face angle 3d", self.angles);

  if(isDefined(self.node))
    self animmode("angle deltas");
  else
    self animmode("zonly_physics");

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  self.stepoutyaw = angleclamp180(getangledelta(var_4, 0, 1) + self.angles[1]);
  self.useanimgoalweight = 1;
  var_5 = 1;
  self aisetanim(var_1, var_3, var_5);

  if(shouldfaceenemyinexposed())
    thread playturnanim_turnanimanglefixup(var_4, var_1);

  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playturnanim_turnanimanglefixup(var_0, var_1) {
  self endon("death");
  self endon(var_1 + "_finished");
  var_2 = self.enemy;
  var_2 endon("death");
  var_3 = getanimlength(var_0);

  if(animhasnotetrack(var_0, "start_aim")) {
    var_4 = getnotetracktimes(var_0, "start_aim");
    var_3 = var_3 * var_4[0];
  } else if(animhasnotetrack(var_0, "finish")) {
    var_4 = getnotetracktimes(var_0, "finish");
    var_3 = var_3 * var_4[0];
  }

  var_5 = int(var_3 * 20);
  var_6 = var_5;

  while(var_6 > 0) {
    var_7 = 1 / var_6;
    var_8 = scripts\engine\utility::getyawtospot(var_2.origin);
    self.stepoutyaw = angleclamp180(self.angles[1] + var_8);
    var_9 = self aigetanimtime(var_0);
    var_10 = getangledelta(var_0, var_9, 1.0);
    var_11 = angleclamp180(var_8 - var_10);
    self orientmode("face angle", angleclamp(self.angles[1] + var_11 * var_7));
    var_6--;
    wait 0.05;
  }
}

playturnanim_cleanup(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self.stepoutyaw = undefined;
  self.desiredturnyaw = undefined;
  popdisabledgunpose();

  if(istrue(self.leavecasualkiller))
    terminate_casualkiller(var_0, var_1, var_2);
}

shouldsnaptocover_checktype(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm_bb::bb_moverequested())
    return 0;

  if(!scripts\asm\shared\utility::isatcovernode())
    return 0;

  if(!isDefined(self.node))
    return 0;

  if(isDefined(self.primaryweapon) && scripts\anim\utility_common.gsc::isusingsidearm() && weaponclass(self.primaryweapon) != "mg")
    return 0;

  return scripts\asm\shared\utility::isarrivaltype(var_0, var_1, var_2, var_3);
}

currentsnaptonodeis(var_0, var_1, var_2, var_3) {
  var_4 = var_3;

  if(!isDefined(self.node))
    return var_4 == "Exposed Crouch";

  if(distance2dsquared(self.origin, self.node.origin) > 225) {
    if(scripts\asm\asm_bb::bb_getrequestedstance() == "stand")
      return var_4 == "Exposed";
    else
      return var_4 == "Exposed Crouch";
  }

  if(isDefined(self._blackboard.runpassthroughtype))
    return self._blackboard.runpassthroughtype == var_3;
  else
    return scripts\asm\shared\utility::isarrivaltype(var_0, var_1, var_2, var_3);
}

reloadnotehandler(var_0) {
  scripts\anim\notetracks.gsc::notetrack_prefix_handler(var_0);
  return undefined;
}

reload(var_0, var_1, var_2) {
  self endon("reload_terminate");
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);

  if(weaponclass(self.weapon) == "pistol")
    self orientmode("face enemy");

  self aisetanim(var_1, var_3);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self.asm.reloadweapon = self.weapon;
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::reloadnotehandler);
}

shoot_doagentnotetrackswithtimeout(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = var_1 + "_timeout";
  var_5 = var_1 + "_timeout_end";
  childthread scripts\asm\shoot\script_funcs::shoot_timeout(var_4, var_5, var_3);
  self endon(var_4);
  var_6 = animhasnotetrack(var_2, "fire");
  var_7 = weaponclass(self.weapon) == "rocketlauncher";
  var_8 = getanimlength(var_2);
  var_9 = [];

  if(var_6) {
    var_10 = getnotetracktimes(var_2, "fire");

    if(var_10.size == 1 && var_10[0] == 0)
      var_6 = 0;
    else {
      var_9[0] = var_8 * var_10[0];

      for(var_11 = 1; var_11 < var_10.size; var_11++) {
        var_12 = var_8 * var_10[var_11];
        var_12 = var_12 - var_9[var_11 - 1];
        var_9[var_11] = var_12;
      }
    }
  }

  var_13 = 0;
  var_14 = self._blackboard.shootparams_shotsperburst;
  var_15 = var_14 == 1 || self._blackboard.shootparams_style == "semi";
  var_16 = isPlayer(self.enemy) && self.enemy isinvulnerable();
  var_17 = scripts\anim\utility_common.gsc::weapon_pump_action_shotgun();
  var_15 = 1;
  var_18 = 0;

  while(var_13 < var_14 && var_14 > 0) {
    if(var_6) {
      if(var_9[var_18] > 0)
        wait(var_9[var_18]);

      var_18 = (var_18 + 1) % var_9.size;
    }

    if(!self.bulletsinclip) {
      break;
    }

    scripts\asm\shoot\script_funcs::shootatshootentorpos(var_15);

    if(var_16) {
      if(randomint(3) == 0)
        self.bulletsinclip--;
    } else
      self.bulletsinclip--;

    if(var_7) {
      self.rocketammo--;

      if(weaponclass(self.weapon) == "rocketlauncher" && self tagexists("tag_rocket"))
        self hidepart("tag_rocket");
    }

    var_13++;

    if(var_17)
      childthread scripts\asm\shoot\script_funcs::shoot_shotgunpumpsound(var_1);

    if(self._blackboard.shootparams_fastburst && var_13 == var_14) {
      break;
    }

    if(!var_6 || var_14 == 1 && self._blackboard.shootparams_style == "single")
      self waittillmatch(var_1, "end");
  }

  self notify(var_5);
}

shoot_setshootparameters() {
  var_0 = self._blackboard.shootparams_shotsperburst;
  var_1 = 2;

  if(self._blackboard.shootparams_style == "single" || var_0 == 1 && self._blackboard.shootparams_style != "rack") {
    var_0 = 1;
    var_1 = 2;
  } else if(self._blackboard.shootparams_style == "semi") {
    var_1 = 3;

    if(var_0 == 1)
      var_1 = 2;
    else if(var_0 > 5)
      var_0 = 5;
  } else if(self._blackboard.shootparams_style == "mg") {
    var_1 = 2;
    var_0 = 1;
  } else if(self._blackboard.shootparams_style == "rack" && self.currentpose != "prone")
    var_1 = 5;
  else {
    var_1 = 4;

    if(var_0 > 6)
      var_0 = 6;
  }

  self setupshootstyleadditive(var_1, var_0);
}

shoot_clearshootparameters() {
  self setupshootstyleadditive(0, 0);
}

shoot_generic(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._blackboard.shoot_firstshot = 0;

  if(scripts\anim\utility_common.gsc::isasniper(1))
    scripts\asm\track::onsniperabouttofire();

  self updateplayersightaccuracy();
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = scripts\engine\utility::ter_op(scripts\anim\utility_common.gsc::weapon_pump_action_shotgun(), 3, 2);

  if(self asmcurrentstatehasshootadditive(var_0)) {
    shoot_setshootparameters();
    scripts\asm\shoot\script_funcs::shoot_donotetrackswithtimeout(var_0, var_1, var_4, var_5, "shoot_additive_fire");
  } else {
    shoot_clearshootparameters();

    if(isagent(self))
      shoot_doagentnotetrackswithtimeout(var_0, var_1, var_4, var_5);
    else {
      var_6 = scripts\asm\shoot\script_funcs::shoot_getrate();
      self setflaggedanimknobrestart(var_1, var_4, 1, 0.2, var_6);
      scripts\asm\shoot\script_funcs::shoot_donotetrackswithtimeout(var_0, var_1, var_4, 2);
    }
  }

  self._blackboard.shootparams_numburstsleft--;

  if(!scripts\asm\shoot\script_funcs::shootstylesingle())
    scripts\asm\shoot\script_funcs::shoot_stopsoundwithdelay(0.05);

  scripts\asm\asm::asm_fireevent(var_0, "shoot_finished");

  if(scripts\anim\utility_common.gsc::isasniper(1))
    scripts\asm\track::onsniperfired();
}

shoot_playidleanimloop_sniper(var_0, var_1, var_2) {
  thread scripts\asm\shoot\script_funcs::handleburstdelay(var_0, var_1);

  if(scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }
  self.bshootidle = 1;
  scripts\asm\asm::asm_playadditiveanimloopstate(var_0, var_1, var_2);
}

shouldendsniperidle(var_0, var_1, var_2, var_3) {
  if(!shouldsniperidle(var_0, var_1, var_2, var_3))
    return 1;

  return 0;
}

shouldsniperidle(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common.gsc::isasniper())
    return 0;

  if(scripts\asm\track::issniperconverging())
    return 0;

  return 1;
}

shouldsniperbeginfiring(var_0, var_1, var_2, var_3) {
  if(!scripts\anim\utility_common.gsc::isasniper())
    return scripts\asm\shoot\script_funcs::shouldbeginfiring(var_0, var_1, var_2, var_3);

  if(scripts\asm\track::issniperconverging())
    return 0;

  if(!scripts\asm\shoot\script_funcs::shouldbeginfiring(var_0, var_1, var_2, var_3))
    return 0;

  return 1;
}

shouldreacttonewenemy(var_0, var_1, var_2, var_3) {
  if(isDefined(self.stealth)) {
    self.newenemyreaction = 0;
    return 0;
  }

  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(self.enemy.unittype) && self.enemy.unittype == "civilian")
    return 0;

  if(!istrue(self.newenemyreaction) && !istrue(self.forcenewenemyreaction))
    return 0;

  if(isDefined(self.newenemyreactiontime) && gettime() - self.newenemyreactiontime > 1000) {
    self.forcenewenemyreaction = undefined;
    return 0;
  }

  if(istrue(self.casualkiller)) {
    if(isDefined(level.casualkillernewenemyreaction) && gettime() < level.casualkillernewenemyreaction)
      return 0;

    level.casualkillernewenemyreaction = gettime() + 5000;
  }

  return 1;
}

shouldcasualkillerreacttonewenemy(var_0, var_1, var_2, var_3) {
  if(istrue(self.casualkiller) && istrue(self.leavecasualkiller)) {
    var_4 = shouldreacttonewenemy(var_0, var_1, var_2, var_3);

    if(istrue(var_4)) {
      self clearbtgoal(2);
      return 1;
    }
  }

  return 0;
}

terminate_newenemyreaction(var_0, var_1, var_2) {
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = undefined;
  self.stepoutyaw = undefined;
  popdisabledgunpose();

  if(istrue(self.leavecasualkiller))
    terminate_casualkiller(var_0, var_1, var_2);
}

terminate_transitiontoexposedanim(var_0, var_1, var_2) {
  terminate_newenemyreaction(var_0, var_1, var_2);
  scripts\asm\soldier\cover::clearcoveranim(var_0, var_1, var_2);
}

getnewenemyreactangleindex(var_0) {
  var_0 = angleclamp180(var_0);

  if(var_0 > 135 || var_0 < -135)
    var_1 = 2;
  else if(var_0 < -45)
    var_1 = 4;
  else if(var_0 > 45)
    var_1 = 6;
  else
    var_1 = 8;

  return var_1;
}

getnewenemyreactdirindex() {
  var_0 = 0;
  var_1 = self lastknownpos(self.enemy);
  var_2 = var_1 - self.origin;

  if(length2dsquared(var_2) < 36)
    var_0 = 0;
  else {
    var_3 = vectortoyaw(var_2);
    var_0 = self.angles[1] - var_3;
  }

  return getnewenemyreactangleindex(var_0);
}

getnewenemyreactalias() {
  var_0 = getnewenemyreactdirindex();
  var_1 = "" + var_0;
  return var_1;
}

chooseanim_newenemyreaction(var_0, var_1, var_2) {
  var_3 = getnewenemyreactalias();
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

facegoalthread_newenemyreaction(var_0, var_1) {
  self notify("FaceGoalThread");
  self endon("FaceGoalThread");
  self endon("death");
  self endon(var_0 + "_finished");

  for(;;) {
    var_2 = 0.25;
    var_3 = angleclamp180(var_1 - self.angles[1]);
    self orientmode("face angle", self.angles[1] + var_3 * var_2);
    waitframe();
  }
}

handlefacegoalnotetrack_newenemyreaction(var_0, var_1, var_2) {
  if(var_1 == "face_goal") {
    var_3 = var_2 - self.origin;
    var_4 = vectortoyaw(var_3);
    thread facegoalthread_newenemyreaction(var_0, var_4);
    return 1;
  }

  return 0;
}

playanim_newenemyreaction(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  pushdisabledgunpose();
  var_3 = self asmgetanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self aisetanim(var_1, var_3);
  var_5 = self lastknownpos(self.enemy);
  thread playturnanim_turnanimanglefixup(var_4, var_1);
  scripts\asm\asm::asm_donotetrackswithinterceptor(var_0, var_1, ::handlefacegoalnotetrack_newenemyreaction, var_5);

  if(isDefined(self.enemy) && self cansee(self.enemy))
    self.remainexposedendtime = gettime() + 2000;
}

chooseanimidle_interiorexterior(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(scripts\asm\asm::asm_hasdemeanoranimoverride(var_3, "idle")) {
    var_4 = scripts\asm\asm::asm_getdemeanoranimoverride(var_3, "idle");

    if(isarray(var_4))
      return var_4[randomint(var_4.size)];

    return var_4;
  }

  if(isDefined(self.node) && self.node.type == "Cover Stand") {
    if(!self.node scripts\engine\utility::isvalidpeekoutdir("over"))
      var_2 = var_2 + "_high";
  }

  if(istrue(self.uprightcqbidle)) {
    var_2 = var_2 + "_interior";

    if(!istrue(self._blackboard.hasplayedidleintro)) {
      var_2 = var_2 + "_intro";
      self._blackboard.hasplayedidleintro = 1;
    }
  }

  return scripts\asm\shared\utility::chooseanim_weaponclassprepended(var_0, var_1, var_2);
}

chooseanim_playerpushed(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");
  var_4 = vectorNormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = angleclamp180(var_5[1] - self.angles[1]);
  var_7 = scripts\asm\soldier\move::yawdiffto2468(var_6);
  var_8 = "pushed_" + var_7;
  var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_8);
  return var_9;
}

terminateidle(var_0, var_1, var_2) {
  self._blackboard.hasplayedidleintro = undefined;
}

shouldleavecasualkiller(var_0, var_1, var_2, var_3) {
  if(istrue(self.leavecasualkiller)) {
    if(needtoturn(var_0, var_1, var_2, var_3))
      return 0;

    if(isDefined(self.enemy)) {
      var_4 = self.angles[1] - vectortoyaw(self.enemy.origin - self.origin);

      if(abs(angleclamp180(var_4)) > 75)
        return 0;
    }

    return 1;
  }

  return 0;
}

shouldleavecasualkillerimmediately(var_0, var_1, var_2, var_3) {
  if(istrue(self.leavecasualkiller)) {
    terminate_casualkiller(var_0, var_1, var_3);
    return 1;
  }

  return 0;
}

terminate_casualkiller(var_0, var_1, var_2) {
  scripts\asm\shared\utility::setbasearchetype(scripts\asm\shared\utility::findoverridearchetype("default"));
  scripts\asm\shared\utility::clearoverridearchetype("casual_killer", 0, 1);
  self.newenemyreaction = 0;
  self.forcenewenemyreaction = undefined;
  self notify("leaveCasualKiller");
  self.leavecasualkiller = undefined;
  self.casualkiller = undefined;
  self setdefaultaimlimits();
}

shoulddodge(var_0, var_1, var_2, var_3) {
  if(istrue(self.disabledodge))
    return 0;

  if(isDefined(self.dodgecooldown) && gettime() < self.dodgecooldown)
    return 0;

  if(istrue(self.fixednode))
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  if(!issentient(self.enemy))
    return 0;

  if(!self issuppressed() && self canshootenemy())
    return 0;

  if(!self cansee(self.enemy))
    return 0;

  self.dodgecooldown = gettime() + randomintrange(4000, 7000);
  self.dodgeanim = "4";
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_2);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);
  var_6 = getmovedelta(var_5, 0, 1);
  self.dodgeanim = "6";
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_2);
  var_5 = scripts\asm\asm::asm_getxanim(var_2, var_4);
  var_7 = getmovedelta(var_5, 0, 1);
  var_6 = rotatevector(var_6, self.angles);
  var_7 = rotatevector(var_7, self.angles);
  var_8 = self.origin - self.enemy.origin;
  var_9 = generateaxisanglesfromforwardvector(var_8, self.enemy.angles);
  var_10 = angleclamp180(var_9[1] - self.enemy.angles[1]);

  if(abs(var_10) > 4)
    return 0;

  if(var_10 > 0) {
    if(checkdodge(var_7)) {
      self.dodgeanim = "6";
      return 1;
    }
  } else if(checkdodge(var_6)) {
    self.dodgeanim = "4";
    return 1;
  }

  return 0;
}

checkdodge(var_0) {
  var_1 = self.origin + var_0;

  if(!self isingoal(var_1))
    return 0;

  if(!navisstraightlinereachable(self.origin, var_1, self))
    return 0;

  var_2 = self getapproxeyepos();
  var_3 = var_2 + var_0;

  if(!sighttracepassed(var_2, var_3, 1, self))
    return 0;

  if(isai(self.enemy) && !isbot(self.enemy))
    var_4 = self.enemy getapproxeyepos();
  else
    var_4 = self.enemy getEye();

  if(!sighttracepassed(var_3, var_4, 0, undefined))
    return 0;

  return 1;
}

chooseanim_dodge(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, self.dodgeanim);
}

pushdisabledgunpose() {
  if(isDefined(self.gunposeoverride))
    self.stashedgunposeoverride = self.gunposeoverride;

  self.gunposeoverride = "disable";
}

popdisabledgunpose() {
  if(isDefined(self.stashedgunposeoverride)) {
    self.gunposeoverride = self.stashedgunposeoverride;
    self.stashedgunposeoverride = undefined;
  } else
    self.gunposeoverride = undefined;
}