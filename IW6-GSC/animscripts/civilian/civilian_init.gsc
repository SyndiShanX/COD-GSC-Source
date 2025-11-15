/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\civilian\civilian_init.gsc
**************************************************/

main() {
  animscripts\init::main();
  civilian_init();
}

#using_animtree("generic_human");

civilian_init() {
  self.allowdeath = 1;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.neverenablecqb = 1;
  self.alwaysrunforward = 1;
  self orientmode("face default");
  self.combatmode = "no_cover";
  self pushplayer(0);
  self.a.reacttobulletchance = 1;

  if(!isDefined(level.initialized_civilian_animations)) {
    level.initialized_civilian_animations = 1;
    level.scr_anim["default_civilian"]["run_combat"][0] = % civilian_run_upright;
    level.scr_anim["default_civilian"]["run_hunched_combat"][0] = % civilian_run_hunched_a;
    level.scr_anim["default_civilian"]["run_hunched_combat"][1] = % civilian_run_hunched_c;
    level.scr_anim["default_civilian"]["run_hunched_combat"][2] = % civilian_run_hunched_flinch;
    level.scr_anim["default_civilian"]["run_noncombat"][0] = % civilian_walk_cool;
    var_0 = [];
    var_0[0] = 3;
    var_0[1] = 3;
    var_0[2] = 1;
    level.scr_anim["default_civilian"]["run_hunched_weights"] = common_scripts\utility::get_cumulative_weights(var_0);
    var_0 = [];
    var_0[0] = 1;
    level.scr_anim["default_civilian"]["run_weights"] = common_scripts\utility::get_cumulative_weights(var_0);
    level.scr_anim["default_civilian"]["idle_noncombat"][0] = % unarmed_cowerstand_idle;
    level.scr_anim["default_civilian"]["idle_combat"][0] = % casual_crouch_v2_idle;
    level.scr_anim["default_civilian"]["idle_combat"][1] = % unarmed_cowercrouch_idle_duck;
    anim.civilianflashedarray[0] = % unarmed_cowerstand_react;
    anim.civilianflashedarray[1] = % unarmed_cowercrouch_react_a;
    anim.civilianflashedarray[2] = % unarmed_cowercrouch_react_b;
  }

  var_1 = undefined;

  if(isDefined(self.civilian_walk_animation)) {
    self.animname = self.civilian_walk_animation;
    attachprops(self.civilian_walk_animation);
    self.alertlevel = "noncombat";
    startnoncombat();
  } else {
    self.animname = "default_civilian";
    self.alertlevel = "alert";
    startcombat();
  }

  thread checkcombatstate();
  self.dropweapon = 0;
  animscripts\shared::dropaiweapon();
  self.saved = 0;
}

attachprops(var_0) {
  if(isDefined(self.hasattachedprops)) {
    return;
  }
  initcivilianprops();
  var_1 = anim.civilianprops[var_0];

  if(isDefined(var_1)) {
    self attach(var_1, "tag_inhand", 1);
    self.hasattachedprops = 1;
  }
}

detachprops(var_0) {
  if(isDefined(self.hasattachedprops)) {
    self.hasattachedprops = undefined;
    self detach(anim.civilianprops[var_0], "tag_inhand");
  }
}

initcivilianprops() {
  if(isDefined(anim.civilianprops)) {
    return;
  }
  anim.civilianprops = [];
  anim.civilianprops["civilian_briefcase_walk"] = "com_metal_briefcase";
  anim.civilianprops["civilian_crazy_walk"] = "electronics_pda";
  anim.civilianprops["civilian_cellphone_walk"] = "com_cellphone_on";
  anim.civilianprops["sit_lunch_A"] = "com_cellphone_on";
  anim.civilianprops["civilian_soda_walk"] = "ma_cup_single_closed";
  anim.civilianprops["civilian_paper_walk"] = "paper_memo";
  anim.civilianprops["civilian_coffee_walk"] = "cs_coffeemug02";
  anim.civilianprops["civilian_pda_walk"] = "electronics_pda";
  anim.civilianprops["reading1"] = "open_book";
  anim.civilianprops["reading2"] = "open_book";
  anim.civilianprops["texting_stand"] = "electronics_pda";
  anim.civilianprops["texting_sit"] = "electronics_pda";
  anim.civilianprops["smoking1"] = "prop_cigarette";
  anim.civilianprops["smoking2"] = "prop_cigarette";
}

startnoncombat() {
  self.turnrate = 0.2;

  if(isDefined(self.civilian_walk_animation)) {
    var_0 = % civilian_briefcase_walk_dodge_l;
    var_1 = % civilian_briefcase_walk_dodge_r;

    if(isDefined(level.scr_anim[self.animname]["dodge_left"]))
      var_0 = level.scr_anim[self.animname]["dodge_left"];

    if(isDefined(level.scr_anim[self.animname]["dodge_right"]))
      var_1 = level.scr_anim[self.animname]["dodge_right"];

    animscripts\move::setdodgeanims(var_0, var_1);
  }

  if(isDefined(level.scr_anim[self.animname]["turn_left_90"])) {
    self.pathturnanimoverridefunc = animscripts\civilian\civilian_move::civilian_noncombatmoveturn;
    self.pathturnanimblendtime = 0.1;
    maps\_utility::enable_turnanims();
  } else
    maps\_utility::disable_turnanims();

  self.run_overrideanim = level.scr_anim[self.animname]["run_noncombat"];
  self.walk_overrideanim = self.run_overrideanim;
  self.run_overridebulletreact = undefined;

  if(self.animname == "default_civilian") {
    self.run_override_weights = level.scr_anim[self.animname]["run_weights_noncombat"];
    self.walk_override_weights = self.run_override_weights;
  }
}

startcombat() {
  self notify("combat");
  animscripts\move::cleardodgeanims();
  self.pathturnanimblendtime = undefined;
  maps\_utility::enable_turnanims();
  self.turnrate = 0.3;
  var_0 = randomint(3) < 1;

  if(isDefined(self.force_civilian_stand_run))
    var_0 = 1;
  else if(isDefined(self.force_civilian_hunched_run))
    var_0 = 0;

  if(var_0) {
    self.pathturnanimoverridefunc = animscripts\civilian\civilian_move::civilian_combatmoveturn;
    self.run_overrideanim = level.scr_anim["default_civilian"]["run_combat"];
    self.run_override_weights = level.scr_anim["default_civilian"]["run_weights"];
  } else {
    self.pathturnanimoverridefunc = animscripts\civilian\civilian_move::civilian_combathunchedmoveturn;
    self.run_overrideanim = level.scr_anim["default_civilian"]["run_hunched_combat"];
    self.run_override_weights = level.scr_anim["default_civilian"]["run_hunched_weights"];
  }

  self.run_overridebulletreact = [];
  self.run_overridebulletreact[0] = % run_react_stumble;
  self.walk_overrideanim = self.run_overrideanim;
  self.walk_override_weights = self.run_override_weights;
  detachprops(self.civilian_walk_animation);
}

checkcombatstate() {
  self endon("death");
  self endon("disable_combat_state_check");
  var_0 = self.alertlevelint > 1;

  for(;;) {
    var_1 = self.alertlevelint > 1;

    if(var_0 && !var_1)
      startnoncombat();
    else if(!var_0 && var_1)
      startcombat();

    var_0 = var_1;
    wait 0.05;
  }
}