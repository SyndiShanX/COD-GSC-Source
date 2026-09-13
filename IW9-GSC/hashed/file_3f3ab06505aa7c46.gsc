/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3f3ab06505aa7c46.gsc
***********************************************/

_id_E96CD5024F2AC563(group, _id_DDDD88E48AEB927C, _id_A751544EB51F1B8C, _id_04A727EA336A56CB, _id_ACDDCBF392BA30BF) {
  self endon("death");
  scripts\common\utility::demeanor_override("sprint");
  self._id_98ADD129A7ECB962 = 0;
  self.demeanoroverride = "combat";
  scripts\engine\utility::set_movement_speed(200 * self.speedscalemult);
  self.goalradius = 10;
  self notify("basic_combat");
  wait 1;

  if(!isDefined(_id_A751544EB51F1B8C))
    _id_A751544EB51F1B8C = &"CP_BOMBER_AI/ENEMY_BOMB";

  _id_AF312CE71F69D8E6 = scripts\engine\utility::getStructArray("c4_plant_interact_spot", "targetname");
  _id_57D269B6B9CBFB6E = 350;
  _id_1A9894427B039642 = scripts\engine\utility::getStruct(_id_DDDD88E48AEB927C, "script_noteworthy");
  _id_25B46AF3D1913848 = [];
  _id_0883878D93A127B2 = [];

  foreach(_id_01523AF5F3C759F1 in _id_AF312CE71F69D8E6) {
    if(isDefined(_id_01523AF5F3C759F1) && scripts\engine\utility::distance_2d_squared(_id_1A9894427B039642.origin, _id_01523AF5F3C759F1.origin) < _id_57D269B6B9CBFB6E * _id_57D269B6B9CBFB6E) {
      if(!istrue(_id_01523AF5F3C759F1.planted))
        _id_0883878D93A127B2[_id_0883878D93A127B2.size] = _id_01523AF5F3C759F1;

      _id_25B46AF3D1913848[_id_25B46AF3D1913848.size] = _id_01523AF5F3C759F1;
    }
  }

  if(_id_0883878D93A127B2.size == 0)
    _id_0883878D93A127B2 = _id_25B46AF3D1913848;

  _id_0883878D93A127B2 = sortbydistance(_id_0883878D93A127B2, self.origin);
  plant_spot = _id_0883878D93A127B2[0];
  plant_spot.planted = 1;
  thread _id_89B8AAE52D1F4386(plant_spot);

  if(!isDefined(plant_spot.model)) {
    plant_spot.model = spawn("script_model", scripts\engine\utility::getStruct(plant_spot.target, "targetname").origin);
    plant_spot.model setModel("tag_origin");
    plant_spot.model.angles = scripts\engine\utility::getStruct(plant_spot.target, "targetname").angles;
  }

  _id_A78C9A57DFD33FDB = "armsrace_c4" + self.unique_id;
  _id_6638147FD86D86D6 = scripts\cp\cp_objectives::requestworldid(_id_A78C9A57DFD33FDB, 15);
  plant_spot _id_5FB800376C00C814(_id_6638147FD86D86D6, self, _id_A78C9A57DFD33FDB, _id_ACDDCBF392BA30BF);
  thread _id_66228280A68F73AE();
  _id_7036E98DD61378B5(plant_spot.model);

  if(!isDefined(_id_04A727EA336A56CB))
    _id_04A727EA336A56CB = 30;

  level thread _id_7FD887033FD9AD08(plant_spot, self, _id_A751544EB51F1B8C, _id_A78C9A57DFD33FDB, _id_6638147FD86D86D6, _id_04A727EA336A56CB);
}

_id_89B8AAE52D1F4386(plant_spot) {
  level endon("game_ended");
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(plant_spot) && istrue(plant_spot.planted))
    plant_spot.planted = undefined;
}

_id_66228280A68F73AE() {
  level endon("game_ended");
  self endon("bomb_planted");
  self waittill("death");

  if(istrue(level._id_E151D3B4EBF727DA)) {
    return;
  }
  radiusdamage(self.origin, 128, 700, 700, undefined, "MOD_EXPLOSIVE");
  thread _id_E92B323B6314FDE1(self.origin, self.angles);
}

_id_E92B323B6314FDE1(origin, angles) {
  level endon("game_ended");
  scripts\cp\utility\cp_controlled_callbacks::runcontrolledcallback("Earthquake", 1.0, 0.6, origin, 512);
  earthquake(1.0, 0.6, origin, 512);
  _id_EFDFC6EBE7A152C5 = spawnfx(level._effect["vfx_javelin_expl"], origin, anglesToForward(angles) * -1.0, (0, 0, 1));
  triggerfx(_id_EFDFC6EBE7A152C5);

  if(soundexists("breach_c4_expl_trans"))
    playsoundatpos(origin, "breach_c4_expl_trans");

  wait 2;
  _id_EFDFC6EBE7A152C5 delete();
}

_id_7FD887033FD9AD08(plant_spot, owner, _id_A751544EB51F1B8C, _id_A78C9A57DFD33FDB, _id_6638147FD86D86D6, timer) {
  level endon("game_ended");

  if(!isDefined(plant_spot) || !isDefined(plant_spot.model) || !isDefined(plant_spot.model.charge)) {
    return;
  }
  _id_FBFB7B9728A7FC1B = plant_spot.model.charge;
  _id_FBFB7B9728A7FC1B.detonation_time = timer;
  _id_FBFB7B9728A7FC1B thread _id_A79AC9057CB9CE18(plant_spot, _id_A751544EB51F1B8C, _id_6638147FD86D86D6, _id_A78C9A57DFD33FDB);
  hintstring = &"CP_BOMBER_AI/DEFUSE";
  _id_FBFB7B9728A7FC1B scripts\cp\utility::create_cursor_hint("tag_origin", undefined, hintstring, 180, 256, 64, 1, undefined, undefined, undefined, "duration_medium");
  _id_FBFB7B9728A7FC1B endon("detonated");
  _id_FBFB7B9728A7FC1B endon("death");
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_BOMBER_AI/DEFUSE_BOMB", "allies", 5);
  _id_FBFB7B9728A7FC1B.outlineid = scripts\cp\cp_outline_utility::outlineenableforall(_id_FBFB7B9728A7FC1B, "outline_depth_red", "level_script");
  _id_FBFB7B9728A7FC1B thread _id_731DA7A31D5AEE3C();
  _id_6BEBD25AB1514349 = undefined;

  for(;;) {
    _id_FBFB7B9728A7FC1B waittill("trigger", player);

    if(isDefined(player) && isPlayer(player)) {
      _id_6BEBD25AB1514349 = player;
      break;
    }
  }

  _id_FBFB7B9728A7FC1B notify("defused");

  if(isDefined(plant_spot.planted))
    plant_spot.planted = undefined;

  if(isDefined(_id_FBFB7B9728A7FC1B.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(_id_FBFB7B9728A7FC1B.outlineid, _id_FBFB7B9728A7FC1B);

  _id_3EBDAD96DEAAAC9E(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB);
  _id_FBFB7B9728A7FC1B delete();
}

_id_731DA7A31D5AEE3C() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger_progress", player);

    if(isDefined(player) && isPlayer(player) && !isDefined(self._id_4F536CE64174FAE6))
      self._id_4F536CE64174FAE6 = gettime();
  }
}

_id_091BDCD29D2BCB28(_id_FF03DED389B65A7D, player) {
  level endon("game_ended");
  _id_E020078567E41613 = player launchgrenade("c4_mp", _id_FF03DED389B65A7D.origin, (0, 0, 0), 120);
  _id_E020078567E41613.owner = player;
  _id_E020078567E41613 waittill("missile_stuck");
  _id_E020078567E41613 thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1, 1);
}

_id_A79AC9057CB9CE18(plant_spot, _id_A751544EB51F1B8C, _id_6638147FD86D86D6, _id_A78C9A57DFD33FDB) {
  self endon("death");
  self endon("defused");
  level endon("game_ended");
  detonation_time = self.detonation_time;
  time = detonation_time;
  progress = detonation_time;
  objective_state(_id_6638147FD86D86D6, "current");
  objective_onentity(_id_6638147FD86D86D6, plant_spot.model);
  objective_icon(_id_6638147FD86D86D6, "icon_waypoint_bomb_defuse");
  objective_setlabel(_id_6638147FD86D86D6, &"CP_BOMBER_AI/DEFUSE");
  objective_setzoffset(_id_6638147FD86D86D6, 50);

  while(progress > 0) {
    progress--;
    objective_setprogress(_id_6638147FD86D86D6, progress / time);

    if(soundexists("breach_warning_beep_05")) {
      foreach(player in level.players)
      player playSound("breach_warning_beep_05");
    }

    wait 1;
  }

  if(isDefined(self._id_4F536CE64174FAE6)) {
    if(self._id_4F536CE64174FAE6 + 1000 > gettime()) {
      waittime = (self._id_4F536CE64174FAE6 + 1000 - gettime()) / 1000 + 0.1;
      wait(waittime);
    }
  }

  _id_88ECD0F6A89D1BE0 = "frag";
  _id_04C38D923A22CEB8 = 0.1;
  c4 = magicgrenademanual(_id_88ECD0F6A89D1BE0, self.origin + (0, 0, 6), (0, 0, 0), _id_04C38D923A22CEB8);
  c4.angles = self.angles;
  self notify("detonated");

  if(isDefined(plant_spot.planted))
    plant_spot.planted = undefined;

  if(isDefined(self.outlineid))
    scripts\cp\cp_outline_utility::outlinedisable(self.outlineid, self);

  playFX(level._effect["breach_explode"], self.origin);
  self playSound("rocket_explode");
  _id_3EBDAD96DEAAAC9E(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB);
  wait 1;
  level notify("ai_bomb_detonated");
  self delete();
}

_id_7036E98DD61378B5(_id_DE1467AC3ED1D213) {
  self endon("death");
  _id_DE1467AC3ED1D213.planted = 0;
  self.going_to_object = _id_DE1467AC3ED1D213;
  _id_327190E5347A2645 = self.goalradius;
  _id_A90C498C87162E1C(self, _id_DE1467AC3ED1D213);
  _id_83E1EDF5F0DF2F32(_id_DE1467AC3ED1D213);
  _id_DE1467AC3ED1D213.planted = 1;
  self.goalradius = _id_327190E5347A2645;
  self.script_radius = _id_327190E5347A2645;
  self.going_to_object = undefined;
  self.ignoreall = 0;
  self.allowpain = 1;
  _id_4BA9D827B5E74D78();
  closestplayer = scripts\engine\utility::getclosest(self.origin, level.players);
  _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(closestplayer.origin));
}

_id_A90C498C87162E1C(agent, _id_DE1467AC3ED1D213) {
  animindex = agent scripts\asm\asm::asm_lookupanimfromalias("animscripted", "sdr_plant_bomb");
  xanim = agent scripts\asm\asm::asm_getxanim("animscripted", animindex);
  org = _id_DE1467AC3ED1D213 gettagorigin("tag_origin");
  _id_8BC14603A27FA3E7 = _id_DE1467AC3ED1D213 gettagangles("tag_origin");
  pos = spawnStruct();
  pos.origin = getstartorigin(org, _id_8BC14603A27FA3E7, xanim);
  pos.angles = getstartangles(org, _id_8BC14603A27FA3E7, xanim);
  pos.animindex = animindex;
  pos.xanim = xanim;
  pos.origin = _id_DE1467AC3ED1D213.origin;
  pos.angles = scripts\engine\utility::ter_op(isDefined(_id_DE1467AC3ED1D213.angles), _id_DE1467AC3ED1D213.angles, (0, 0, 0));
  agent _id_C1806437F556850B(pos, 0);
}

_id_83E1EDF5F0DF2F32(_id_DE1467AC3ED1D213) {
  charge = spawn("script_model", self.origin);
  charge.angles = self.angles;
  charge setModel("offhand_wm_c4");
  charge scriptmodelplayanimdeltamotion("wm_equip_c4_attach_c4");
  _id_DE1467AC3ED1D213.charge = charge;
  thread _id_E3684CBEDF14EC57(_id_DE1467AC3ED1D213, charge);
  charge thread _id_07D0B5769898BC74();
  _id_E8037FBE27FE9F82("sdr_plant_bomb", _id_DE1467AC3ED1D213);

  if(soundexists("cp_bomb_plant"))
    _id_DE1467AC3ED1D213 playSound("cp_bomb_plant");

  waitframe();
  self notify("bomb_planted");
}

_id_07D0B5769898BC74() {
  self endon("death");
  self hide();
  wait 0.5;
  self show();
}

_id_E3684CBEDF14EC57(_id_DE1467AC3ED1D213, charge) {
  self endon("bomb_planted");
  self waittill("death");

  if(isDefined(charge))
    charge delete();
}

_id_5FB800376C00C814(_id_6638147FD86D86D6, owner, _id_A78C9A57DFD33FDB, _id_ACDDCBF392BA30BF) {
  if(!isDefined(_id_6638147FD86D86D6)) {
    return;
  }
  if(!istrue(_id_ACDDCBF392BA30BF)) {
    scripts\cp\cp_objectives::objective_set_play_intro(_id_6638147FD86D86D6, 1);
    objective_state(_id_6638147FD86D86D6, "current");
  } else
    objective_state(_id_6638147FD86D86D6, "active");

  objective_setlabel(_id_6638147FD86D86D6, &"CP_BOMBER_AI/KILL");
  objective_setshowprogress(_id_6638147FD86D86D6, 1);
  objective_icon(_id_6638147FD86D86D6, "icon_waypoint_target_empsite");
  objective_setprogress(_id_6638147FD86D86D6, 1);
  objective_setownerteam(_id_6638147FD86D86D6, "axis");
  objective_onentity(_id_6638147FD86D86D6, owner);
  objective_setzoffset(_id_6638147FD86D86D6, 50);
  owner thread _id_8495DA30119A4079(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB);
}

_id_8495DA30119A4079(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB) {
  level endon("game_ended");
  self endon("bomb_planted");
  self waittill("death");
  _id_3EBDAD96DEAAAC9E(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB);
}

_id_3EBDAD96DEAAAC9E(_id_6638147FD86D86D6, _id_A78C9A57DFD33FDB) {
  if(isDefined(_id_6638147FD86D86D6)) {
    objective_delete(_id_6638147FD86D86D6);
    scripts\cp\cp_objectives::freeworldid(_id_A78C9A57DFD33FDB);
  }
}

_id_4BA9D827B5E74D78() {
  self allowedstances("stand", "prone", "crouch");
  scripts\asm\shared\mp\utility::animscripted_clear();
  self.dont_enter_combat = 0;
  self.ignoreall = 0;
  self.scripted_mode = 0;
  self.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

_id_22A07A15C5CB2516(origin, radius) {
  if(!isDefined(origin)) {
    return;
  }
  while(distancesquared(self.origin, origin) > radius)
    wait 0.1;
}

_id_C1806437F556850B(goal, _id_EE91862B850C90E5) {
  self.goalradius = 8;
  self.script_radius = 8;
  _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(goal.origin));
  _id_22A07A15C5CB2516(goal.origin, squared(384));
  self.goalradius = 8;
  self.script_radius = 8;
  self.ignoreall = 1;
  self.allowpain = 0;
  self waittill("goal");

  if(!isDefined(goal.angles))
    goal.angles = (0, 0, 0);

  self setplayerangles(goal.angles);
  self forceteleport(goal.origin, goal.angles);

  if(istrue(_id_EE91862B850C90E5)) {
    self.anchor = spawn("script_origin", goal.origin);
    self.anchor.angles = goal.angles;
    self linkTo(self.anchor);
  }
}

_id_E8037FBE27FE9F82(animalias, ent) {
  _id_6D6445DF8BCD57B4();
  scripts\asm\shared\mp\utility::animscripted_single_relative(animalias, ent);
  _id_92BEE443F71ED79F();
}

_id_6D6445DF8BCD57B4() {
  self.old_weapon = self.weapon;
  self.anim_weapon = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(self.anim_weapon);
  self takeweapon(self.old_weapon);
  self setspawnweapon(self.anim_weapon);
}

_id_92BEE443F71ED79F() {
  self giveweapon(self.old_weapon);
  self takeweapon(self.anim_weapon);
  self setspawnweapon(self.old_weapon);
}