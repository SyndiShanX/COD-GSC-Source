/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\fulton.gsc
***********************************************/

fulton_init() {
  fulton_initrepository();

  if(!scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    game["dialog"]["plunder_extract_fail_fulton"] = "peff_wzan_plnd";
  else
    game["dialog"]["plunder_extract_fail_fulton"] = "plunder_plunder_extract_fail_fulton";

  level._effect["vfx_fulton_explode"] = loadfx("vfx/iw8_br/gameplay/vfx_br_money_fulton_destr.vfx");
}

#using_animtree("script_model");

fulton_initanims() {
  level.scr_animtree["fulton"] = #animtree;
  level.scr_anim["fulton"]["fulton_open"] = level._id_1A209BD995A7FA83["wm_skyhook_ground_open"];
  level.scr_animname["fulton"]["fulton_open"] = "wm_skyhook_ground_open";
  level.scr_anim["fulton"]["fulton_open_idle"] = level._id_1A209BD995A7FA83["wm_skyhook_ground_idle_open"];
  level.scr_animname["fulton"]["fulton_open_idle"] = "wm_skyhook_ground_idle_open";
  level.scr_anim["fulton"]["fulton_takeoff"] = level._id_1A209BD995A7FA83["wm_skyhook_ground_takeoff"];
  level.scr_animname["fulton"]["fulton_takeoff"] = "wm_skyhook_ground_takeoff";
}

fulton_initrepository() {
  _id_464EB48901113EB0 = _id_6AFF3948CF4CCA03::plunder_getleveldataforrepository("equip_mp_fulton", 1);
  _id_464EB48901113EB0.type = 0;
  _id_464EB48901113EB0.usetime = getdvarfloat("scr_fultonUseTime", 0.75);
  _id_464EB48901113EB0.useeventtype = 2;
  _id_464EB48901113EB0.useeventamount = getdvarint("scr_fultonUseAmount", 250);
  _id_464EB48901113EB0.teamuseonly = 1;
  _id_464EB48901113EB0.teamanchoredwidget = 1;
  _id_464EB48901113EB0.usefailcapacitymsg = "MP/CANNOT_DEPOSIT_CASH_BALLOON_FULL";
  _id_464EB48901113EB0.usefailextractingmsg = "MP/CANNOT_DEPOSIT_CASH_BALLOON_LEAVING";
  _id_464EB48901113EB0.scriptableusepart = "fulton_use_cache";
  _id_464EB48901113EB0.scriptableusestate = "usable";
  _id_464EB48901113EB0.scriptablenousestate = "unusable";
  _id_464EB48901113EB0.extractcountdown = getdvarint("scr_fultonCountdown", 20);
  _id_464EB48901113EB0.extractcountdownmsg = "MP/CASH_BALLOON_LEAVING_IN_N";
  _id_464EB48901113EB0.capacity = getdvarint("scr_fultonCapacity", 1500);
  _id_464EB48901113EB0.countdownendcallback = ::fulton_repositorycountdownendcallback;
  _id_464EB48901113EB0.extractcallback = ::fulton_repositoryextractcallback;
  _id_464EB48901113EB0.atcapacitycallback = ::fulton_repositoryatcapacitycallback;
  _id_464EB48901113EB0.extractionmethod = "fulton";
  _id_464EB48901113EB0.dropplunder = getdvarint("dvar_491B43C08B40FE8C", 1) > 0;
  _id_464EB48901113EB0.cantakedamage = getdvarint("dvar_480475A0DEC18661", 1) > 0;
}

fulton_create(grenade) {
  fulton = spawn("script_model", grenade.origin);
  fulton setautoboxcalculationusingdobj(1);
  _id_CB09FAFEA872C96D = "military_skyhook_far_mp";

  if(istrue(level._id_005A2620A56CF4BB))
    _id_CB09FAFEA872C96D = "military_skyhook_far_plunder";

  fulton setModel(_id_CB09FAFEA872C96D);
  fulton.angles = grenade.angles;
  fulton.owner = self;
  fulton.team = self.team;

  if(isDefined(grenade.moving_platform))
    fulton.moving_platform = grenade.moving_platform;

  fulton.animname = "fulton";
  fulton scripts\common\anim::setanimtree();
  self.fulton = fulton;
  fulton thread fulton_planted();
}

fulton_destroy(damagedata) {
  _id_464EB48901113EB0 = _id_6AFF3948CF4CCA03::plunder_getleveldataforrepository("equip_mp_fulton");
  thread _id_1E4A61DB11011446::teamsplashbr("br_fulton_balloon_shot_down", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp");
  _id_6AFF3948CF4CCA03::entityplunderlosealldeposited(_id_464EB48901113EB0.dropplunder);
  playFX(scripts\engine\utility::getfx("vfx_fulton_explode"), self.origin, anglesToForward(self.angles));
  playsoundatpos(self.origin, "br_fulton_extract_exp");
  thread fulton_deletenextframe();
}

fulton_deletenextframe() {
  self notify("death");

  if(isDefined(self.owner))
    self.owner.fulton = undefined;

  self hide();
  scripts\mp\damage::monitordamageend();
  self setscriptablepartstate("fulton_use_cache", "unusable", 0);
  self setscriptablepartstate("fulton_use_extract", "unusable", 0);
  self setscriptablepartstate("effects", "neutral", 0);
  _id_6AFF3948CF4CCA03::plunder_deregisterrepositoryinstance(self);
  self stopanimScripted();

  if(isDefined(self.scenenode))
    self.scenenode delete();

  waitframe();

  if(isDefined(self))
    self delete();
}

fulton_used(grenade) {
  self endon("death_or_disconnect");

  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    if(getdvarint("dvar_269506FF08A558CD", 1) == 1)
      fulton_check_for_moving_platform(grenade, stuckto);

    if(!isDefined(grenade.moving_platform)) {
      self playlocalsound("br_pickup_deny");
      scripts\mp\hud_message::showerrormessage("MP/CASH_BALLOON_CANNOT_PLACE");

      if(isDefined(self.super))
        fulton_refundsuper();

      grenade delete();
      return;
    }
  }

  if(!fulton_cancreate(grenade)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/CASH_BALLOON_BLOCKED");

    if(isDefined(self.super))
      fulton_refundsuper();

    grenade delete();
    return;
  } else if(1 && isDefined(self.fulton)) {
    self playlocalsound("br_pickup_deny");
    scripts\mp\hud_message::showerrormessage("MP/CASH_BALLOON_TOO_MANY");

    if(isDefined(self.super))
      fulton_refundsuper();

    grenade delete();
    return;
  }

  if(isDefined(self.super))
    scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);

  thread fulton_create(grenade);

  if(isDefined(grenade))
    grenade delete();
}

fulton_check_for_moving_platform(grenade, stuckto) {
  if(isDefined(stuckto.linked_brush)) {
    if(isDefined(stuckto.linked_brush.targetname)) {
      if(stuckto.linked_brush.targetname == "train_wz")
        grenade.moving_platform = stuckto;
    }
  } else if(isDefined(stuckto.targetname) && stuckto.targetname == "train_wz")
    grenade.moving_platform = stuckto;
}

fulton_planted() {
  self endon("death");
  self endon("start_extract");
  playsoundatpos(self.origin, "iw9_extraction_balloon_drop");
  thread _id_1E4A61DB11011446::teamsplashbr("br_fulton_device_placed", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp");
  players = scripts\mp\utility\teams::getfriendlyplayers(self.team);
  _id_6AFF3948CF4CCA03::plunder_registerrepositoryinstance(self, "equip_mp_fulton");
  thread _id_6AFF3948CF4CCA03::plunder_repositorywatchcountdown(self, players);
  _id_6AFF3948CF4CCA03::plunder_updateanchoredwidgetforplayers(self, players);
  scenenode = spawn("script_model", self.origin);
  scenenode setModel("tag_origin");
  scenenode.angles = self.angles * (0, 1, 0);
  scenenode.fulton = self;
  self.scenenode = scenenode;

  if(isDefined(self.moving_platform)) {
    self linkTo(self.moving_platform);
    scenenode linkTo(self.moving_platform);
  }

  fulton_open();
  _id_464EB48901113EB0 = _id_6AFF3948CF4CCA03::plunder_getleveldataforrepository("equip_mp_fulton", 1);

  if(_id_464EB48901113EB0.cantakedamage)
    thread scripts\mp\damage::monitordamage(300, "", ::fulton_handlefataldamage, ::fulton_handledamage);
}

fulton_open() {
  self setscriptablepartstate("effects", "fillUp", 0);
  self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_open");
  childthread _id_F71B5E7DFCFA8820();
  childthread fulton_openidle();
}

fulton_openidle() {
  for(;;)
    self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_open_idle");
}

_id_F71B5E7DFCFA8820() {
  self endon("death");
  _id_72B2451562363925 = "iw9_extraction_balloon_idle_lp";
  scripts\engine\utility::play_loop_sound_on_entity(_id_72B2451562363925, (0, 0, 72));
  self waittill("fulton_takeoff");
  scripts\engine\utility::stop_loop_sound_on_entity(_id_72B2451562363925, (0, 0, 72));
}

fulton_handledamage(damagedata) {
  damage = damagedata.damage;

  if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(damagedata.attacker, self.owner)))
    damage = 0;
  else {
    damage = scripts\mp\damage::handleshotgundamage(damagedata.objweapon, damagedata.meansofdeath, damagedata.damage);
    hitstokill = undefined;

    if(damagedata.meansofdeath == "MOD_MELEE")
      damage = int(ceil(self.maxhealth / 6));
    else if(isexplosivedamagemod(damagedata.meansofdeath)) {
      if(damagedata.damage >= 50)
        damage = int(ceil(self.maxhealth / 1));
    }
  }

  return damage;
}

fulton_handlefataldamage(damagedata) {
  thread fulton_destroy(damagedata);
}

fulton_repositoryusecallback(entity, player, amount) {
  _id_464EB48901113EB0 = _id_6AFF3948CF4CCA03::plunder_getleveldataforrepository("equip_mp_fulton");
  player thread _id_6AFF3948CF4CCA03::playerplunderevent(amount, _id_464EB48901113EB0.useeventtype, entity);
}

fulton_repositorycountdownendcallback(entity, _id_C76F5BA0AD745444) {
  if(isDefined(entity.owner))
    entity.owner.fulton = undefined;

  _id_6AFF3948CF4CCA03::plunder_repositoryextract(entity);
}

fulton_repositoryextractcallback(entity) {
  entity endon("death");
  _id_464EB48901113EB0 = _id_6AFF3948CF4CCA03::plunder_getleveldataforrepository("equip_mp_fulton");
  data = undefined;
  entity scripts\mp\damage::monitordamageend();
  data = _id_6AFF3948CF4CCA03::entityplunderbankalldeposited();
  thread _id_1E4A61DB11011446::teamsplashbr("br_fulton_balloon_successfully_away", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp");
  self notify("fulton_takeoff");
  self playsoundonmovingent("iw9_extraction_balloon_takeoff");
  self.scenenode scripts\common\anim::anim_single_solo(self, "fulton_takeoff");
  thread fulton_deletenextframe();
}

fulton_repositoryatcapacitycallback(entity) {
  thread _id_1E4A61DB11011446::teamsplashbr("br_fulton_balloon_full", entity.owner, entity.team, undefined, "splash_list_br_plunder_iw9_mp");
}

fulton_cancreate(grenade) {
  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    return 1;

  _id_57F6E7D1BE00D5F9 = 25;
  _id_76AB620FD7CC70BD = scripts\cp_mp\parachute::getc130height();
  start = grenade.origin + (0, 0, _id_57F6E7D1BE00D5F9 + 1);
  end = (grenade.origin[0], grenade.origin[1], _id_76AB620FD7CC70BD);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(start, end, _id_57F6E7D1BE00D5F9, grenade, contents);
  return _id_E96577032A7740FC["fraction"] == 1.0;
}

fulton_refundsuper() {
  _id_5B95DD8B798C16E1();
  self notify("super_use_finished_lb");
  self notify("super_use_finished");
  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();
  scripts\mp\supers::setsuperisinuse(0);
  scripts\mp\supers::setsuperexpended(0);
  _id_19163E14365D9264.wasrefunded = 1;
  scripts\mp\supers::setsuperbasepoints(scripts\mp\supers::getsuperpointsneeded());
}

_id_5B95DD8B798C16E1() {
  if(scripts\mp\equipment::hasequipment("equip_extract"))
    scripts\mp\equipment::incrementequipmentammo("equip_extract", 1);
}