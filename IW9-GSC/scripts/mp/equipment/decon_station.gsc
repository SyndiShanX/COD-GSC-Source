/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\decon_station.gsc
**************************************************/

main() {
  level thread _id_1842BAD814634447();
}

_id_1842BAD814634447() {
  level endon("game_ended");
  _id_A443E13B4A9BEE87();
  level waittill("init_supers");
  scripts\mp\supers::_id_53110A12409D01DA("super_decon_station", undefined, undefined, ::_id_CE2F43EB5B7C337F, undefined, undefined);
  scripts\cp_mp\utility\script_utility::registersharedfunc("decon_station", "grenadeUsed", ::_id_C06383227E374B98);

  if(isDefined(level.equipment)) {
    level.equipment.callbacks["equip_decon_station"] = [];
    level.equipment.callbacks["equip_decon_station"]["onGive"] = ::_id_DC6ECBB23E5B4429;
    level.equipment.callbacks["equip_decon_station"]["onTake"] = ::_id_B94E33A716E29D14;
  }

  _id_9748251D23375C78();
}

_id_CE2F43EB5B7C337F() {
  return 1;
}

_id_A443E13B4A9BEE87() {
  level._effect["vfx_br_decontamination_station_circle_aura"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_aura");
  level._effect["vfx_decon_station_screen_fx"] = loadfx("vfx/iw8_br/island/equip/decon/vfx_br3_decon_scrnfx");
}

_id_9748251D23375C78() {
  if(!isDefined(level._id_FC37203C4B661705)) {
    level._id_FC37203C4B661705 = spawnStruct();
    level._id_FC37203C4B661705.instances = [];
  }

  level._id_FC37203C4B661705.lifetime = getdvarfloat("dvar_DCC4C6ADCB09A2BB", 15.0);
  level._id_FC37203C4B661705._id_692805D1A62A81A5 = getdvarfloat("dvar_22132F9A26C58F74", 0.1);
  level._id_FC37203C4B661705.infinite_ammo = getdvarint("dvar_CA77644DC451154F", 0);
  level._id_FC37203C4B661705._id_1DE6DCEA466CCF7C = getdvarint("dvar_EC721CC3212BBDDD", 1);
}

_id_694DAAEC66C48DA3() {
  self._id_A7A269CB421B50A8 = undefined;
  maxcharges = scripts\mp\equipment::getequipmentmaxammo("equip_decon_station");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < maxcharges; _id_AC0E594AC96AA3A8++)
    _id_E23B83B471293B7B();
}

_id_E23B83B471293B7B(ammo) {
  if(!isDefined(self._id_A7A269CB421B50A8))
    self._id_A7A269CB421B50A8 = [];

  if(self._id_A7A269CB421B50A8.size < _id_207605E0C7C3B7AC()) {
    if(!isDefined(ammo))
      ammo = 3;

    self._id_A7A269CB421B50A8[self._id_A7A269CB421B50A8.size] = ammo;
  }
}

_id_ECA0C791270EBB3A() {
  if(isDefined(self._id_A7A269CB421B50A8) && self._id_A7A269CB421B50A8.size > 0) {
    trophy = self._id_A7A269CB421B50A8[self._id_A7A269CB421B50A8.size - 1];
    self._id_A7A269CB421B50A8[self._id_A7A269CB421B50A8.size - 1] = undefined;
    return trophy;
  }

  return undefined;
}

_id_91941A6932FC41B7() {
  self._id_A7A269CB421B50A8 = undefined;
}

_id_B94E33A716E29D14(equipmentref, slot) {
  _id_91941A6932FC41B7();
}

_id_DC6ECBB23E5B4429(equipmentref, slot, variantid) {
  _id_694DAAEC66C48DA3();
}

_id_207605E0C7C3B7AC() {
  return scripts\mp\equipment::getequipmentmaxammo("equip_decon_station");
}

_id_B675A78BC2FC89CC() {
  _id_CE125B637EF3E995(undefined, 0);
}

_id_8FE25BD617773044() {
  _id_CE125B637EF3E995(undefined, 0);
}

_id_C06383227E374B98(instance) {
  instance endon("death");
  self endon("disconnect");
  instance.owner = self;
  instance setotherent(instance.owner);
  instance setnodeploy(1);
  instance.issuper = isDefined(instance.owner.super) && instance.owner.super.staticdata.weapon == "decon_station_mp";
  instance.superid = level.superglobals.staticsuperdata["super_decon_station"].id;
  instance.usedcount = 0;
  instance scripts\cp_mp\ent_manager::registerspawn(2, ::_id_B675A78BC2FC89CC);
  instance thread _id_E11BA21269CCD5AA();
  instance thread _id_292EAB686B6B2A43(instance.owner);
  instance waittill("missile_stuck", stuckto);
  instance.owner thread scripts\mp\weapons::monitordisownedgrenade(instance.owner, instance);
  scripts\mp\utility\print::printgameaction("trophy spawned", self);

  if(!istrue(instance.issuper)) {
    instance.ammo = _id_ECA0C791270EBB3A();

    if(!isDefined(instance.ammo))
      instance.ammo = 3;

    instance thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else
    instance.ammo = 3;

  instance.owner scripts\mp\weapons::onequipmentplanted(instance, "equip_decon_station", ::_id_8FE25BD617773044);
  instance thread scripts\mp\weapons::monitordisownedequipment(instance.owner, instance);
  instance scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", instance.owner);
  instance.explosion = _id_CF193B9F9BE4558A();
  _id_307667D0142F2035 = instance.owner scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(_id_307667D0142F2035)
    instance.hasruggedeqp = 1;

  maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 200, 100);
  damagefeedback = "hitequip";
  instance thread scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ::_id_3787DFFC5737DAB7, ::_id_E216E49842F16C3E, 0);
  instance scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_85E5FD047D8781FF);
  instance setscriptablepartstate("visibility", "show", 0);
  instance thread _id_34F8BE6E5619DE8E();
}

_id_34F8BE6E5619DE8E() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");
  thread _id_9258952190753EB6();
  _id_24DA645FF5F35063();
  wait 0.2;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  self._id_240F097A821F6FCC = gettime();
  self._id_BDCF531A96C87295 = gettime() + level._id_FC37203C4B661705.lifetime * 1000;
  level._id_FC37203C4B661705.instances = scripts\engine\utility::array_add(level._id_FC37203C4B661705.instances, self);
  trigger = spawn("trigger_radius", self.origin, 19, 250, 250);
  scripts\mp\utility\trigger::makeenterexittrigger(trigger, ::_id_128A4FEE743DA6B8, ::_id_702DC1894784F5D6, undefined, undefined, ::_id_5982C547B3946148);
  waitframe();
  trigger.instance = self;
  trigger enablelinkTo();
  trigger linkTo(self);
  trigger._id_AFC8A0438F536281 = [];
  trigger.registeredvehicles = [];
  self.trigger = trigger;
  scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Decon_Station_Br", self.origin, 250);
  scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
  wait(level._id_FC37203C4B661705.lifetime);
  _id_CE125B637EF3E995(undefined, 0);
  _id_EE7DB96B190A4B50();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::_id_CE125B637EF3E995, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
}

_id_A51ACF6AEC4E93F6(instance) {
  level endon("game_ended");
  self notify("entered_decon_station_aura");
  self endon("entered_decon_station_aura");
  _id_8DD275FB9EAF444F = "exit_decon_station_aura" + instance getentitynumber();
  self endon(_id_8DD275FB9EAF444F);
  self._id_A6637F42471575BC = 1;
  _id_1C39CB7E142659CB();

  while(isalive(self))
    waitframe();

  self._id_A6637F42471575BC = 0;
}

_id_6B5FE5BB09EB8D12(instance) {
  _id_4C48D1D9CFCB8A2C = "exit_decon_station_aura" + instance getentitynumber();
  self notify(_id_4C48D1D9CFCB8A2C);
  self._id_A6637F42471575BC = 0;
  _id_9F9A669CC625C8FD();
}

_id_128A4FEE743DA6B8(ent, trigger) {
  if(_id_5AAC0A0B99E895E6(ent)) {
    player = ent;
    player._id_A6637F42471575BC = 1;
    player thread _id_A51ACF6AEC4E93F6(trigger.instance);

    if(scripts\cp_mp\gasmask::hasgasmask(player)) {
      player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("br_circle");
      player _id_7E52B56769FA7774::_id_8206BC54A1ED73CB("city_killer");
    }
  }
}

_id_702DC1894784F5D6(ent, trigger) {
  if(_id_5AAC0A0B99E895E6(ent)) {
    player = ent;
    player _id_6B5FE5BB09EB8D12(trigger.instance);
  }
}

_id_5982C547B3946148(ent, trigger) {
  if(_id_5AAC0A0B99E895E6(ent) || isDefined(ent.vehicletype))
    return 0;

  return 1;
}

_id_5AAC0A0B99E895E6(ent) {
  return isPlayer(ent) || isagent(ent) || isbot(ent);
}

_id_24DA645FF5F35063() {
  if(istrue(level._id_FC37203C4B661705._id_1DE6DCEA466CCF7C))
    playFXOnTag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, "tag_origin");

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= 6; _id_AC0E594AC96AA3A8++) {
    partname = "canister" + scripts\engine\utility::string(_id_AC0E594AC96AA3A8);
    self setscriptablepartstate(partname, "active");
  }

  self._id_8904BF911DCE8250 = 6;
  thread _id_6712A3A393684237();
}

_id_6712A3A393684237() {
  self endon("death");
  self endon("stop_canisters");
  level endon("game_ended");
  _id_8DFC0A6A9058E951 = level._id_FC37203C4B661705.lifetime / float(6);

  for(_id_F32964E4D7F1F9D3 = 1; _id_F32964E4D7F1F9D3 <= 6; _id_F32964E4D7F1F9D3++) {
    partname = "canister" + scripts\engine\utility::string(_id_F32964E4D7F1F9D3);
    wait(_id_8DFC0A6A9058E951);
    self setscriptablepartstate(partname, "hidden");
    self._id_8904BF911DCE8250--;
  }
}

_id_E05E6E05F45BADD7() {
  self endon("death");
  level endon("game_ended");
  self notify("stop_canisters");

  if(self._id_8904BF911DCE8250 > 0) {
    _id_8DFC0A6A9058E951 = 0.1 / float(6);

    for(_id_F32964E4D7F1F9D3 = 6 - self._id_8904BF911DCE8250 + 1; _id_F32964E4D7F1F9D3 <= 6; _id_F32964E4D7F1F9D3++) {
      partname = "canister" + scripts\engine\utility::string(_id_F32964E4D7F1F9D3);
      self setscriptablepartstate(partname, "hidden");
      self._id_8904BF911DCE8250--;

      if(self._id_8904BF911DCE8250 > 0)
        wait(_id_8DFC0A6A9058E951);
    }
  }

  waitframe();
  self notify("canisters_popped");
}

_id_77B0E78777CAB441() {
  if(istrue(level._id_FC37203C4B661705._id_1DE6DCEA466CCF7C))
    killfxontag(scripts\engine\utility::getfx("vfx_br_decontamination_station_circle_aura"), self, "tag_origin");
}

_id_9258952190753EB6() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait(_id_1A0E76814E6CD04E());
  self setscriptablepartstate("effects", "activeDeployEnd");
}

#using_animtree("scriptables");

_id_1A0E76814E6CD04E() {
  return getanimlength(%wm_decon_station_deploy_landing);
}

_id_85E5FD047D8781FF(data) {
  instance = data.victim;
  instance _id_AA96F22F194ADEFA(data.attacker);
  instance _id_EE7DB96B190A4B50();
  instance thread _id_CE125B637EF3E995(data.attacker, 1);
}

_id_1C39CB7E142659CB() {
  self._id_918ACEDCC9B7577E = 1;
  _id_0027145322A64CF6 = playfxontagforclients(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "tag_origin", self);
  _id_0AE77C9542367530 = "decon_station_inside";

  if(istrue(getdvarint("dvar_31B48E981C2816FC", 0)))
    _id_0AE77C9542367530 = "decon_station_inside_gas";

  self visionsetnakedforplayer(_id_0AE77C9542367530, 0.2);
}

_id_9F9A669CC625C8FD(_id_E072C05875ED0029) {
  if(!istrue(self._id_918ACEDCC9B7577E)) {
    return;
  }
  if(istrue(_id_E072C05875ED0029))
    killfxontag(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "tag_origin");

  stopfxontagforclients(scripts\engine\utility::getfx("vfx_decon_station_screen_fx"), self, "tag_origin", self);
  self visionsetnakedforplayer("", 0.2);
  self._id_918ACEDCC9B7577E = 0;
}

_id_E216E49842F16C3E(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB);
  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);
  return _id_702BFC08FABD86CB;
}

_id_EE7DB96B190A4B50() {
  foreach(player in self.trigger.triggerenterents) {
    player _id_9F9A669CC625C8FD();
    player _id_6B5FE5BB09EB8D12(self);
  }

  _id_77B0E78777CAB441();
  level._id_FC37203C4B661705.instances = scripts\engine\utility::array_remove(level._id_FC37203C4B661705.instances, self);
  self.trigger notify("disperse");
  self.trigger delete();
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  self notify("disperse");
}

_id_3787DFFC5737DAB7(data) {
  attacker = data.attacker;
  _id_AA96F22F194ADEFA(attacker);
  thread _id_CE125B637EF3E995(attacker, 1);
}

_id_CE125B637EF3E995(attacker, _id_4FAC8B8CE36E09F1, delay) {
  level endon("game_ended");
  thread _id_E05E6E05F45BADD7();
  self waittill("canisters_popped");
  thread _id_F828F503FE8F1AC8(attacker, 0.1, _id_4FAC8B8CE36E09F1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(!isDefined(delay))
    delay = 0.1;

  wait(delay);
  self.explosion delete();

  if(isDefined(self))
    self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

_id_F828F503FE8F1AC8(attacker, _id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1) {
  level endon("game_ended");
  self notify("disperse");
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);

  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\mp\weapons::makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("trophy_update", 0);
    self.owner scripts\mp\weapons::removeequip(self);
  }

  _id_EE7DB96B190A4B50();
  self setscriptablepartstate("anims", "neutral", 0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  scripts\cp_mp\ent_manager::deregisterspawn();
}

_id_AA96F22F194ADEFA(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::giveunifiedpoints("destroyed_equipment");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

_id_CF193B9F9BE4558A() {
  explosion = spawn("script_model", self.origin);
  explosion.killcament = self;
  explosion.owner = self.owner;
  explosion.team = self.team;
  explosion.equipmentref = self.equipmentref;
  explosion.weapon_name = self.weapon_name;
  explosion setotherent(explosion.owner);
  explosion setentityowner(explosion.owner);
  explosion setModel("trophy_system_mp_explode");
  explosion.explode1available = 1;
  return explosion;
}

_id_E11BA21269CCD5AA() {
  self endon("death");
  self endon("missile_stuck");
  _id_722684AF55E05749 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait(_id_722684AF55E05749);
  self setscriptablepartstate("visibility", "show", 0);
}

_id_292EAB686B6B2A43(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = scripts\engine\utility::waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }
  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  _id_3A7F0173B03F5767 = -2000.0;
  _id_8B39E5984DA1FFAF = self.origin + (0.0, 0.0, _id_3A7F0173B03F5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(is_train_ent(groundentity))
        self.origin = player.origin;
    }
  }
}

is_train_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == _id_1D9FB21B4F3023F3)
        return 1;
      else if(isDefined(ent.linked_model) && ent.linked_model == _id_1D9FB21B4F3023F3)
        return 1;
    }
  }

  return 0;
}

_id_D58FC580F1954AD2() {
  if(self.owner scripts\mp\equipment::hasequipment("equip_decon_station"))
    self.owner _id_E23B83B471293B7B(self.ammo);
}