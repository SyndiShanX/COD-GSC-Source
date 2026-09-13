/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\throwing_knife.gsc
******************************************************/

throwing_knife_init() {
  level.throwingknifemaxpickups = getdvarfloat("dvar_9CF2C444BA60D047", 12);
  level.throwingknifepickuptimeout = getdvarfloat("dvar_63A7B50937E43D7B", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "init")]]();
}

throwing_knife_ongive(equipmentref, _id_CBB2B3D05E48BD27, variantid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onGive"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onGive")]](equipmentref, _id_CBB2B3D05E48BD27, variantid);
}

throwing_knife_ontake(equipmentref, _id_CBB2B3D05E48BD27) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "onTake"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "onTake")]](equipmentref, _id_CBB2B3D05E48BD27);
}

_id_D763DF6D36A1E34A(equipmentref, _id_3DBC3B058135CBFB) {
  if(isDefined(_id_3DBC3B058135CBFB) && _id_3DBC3B058135CBFB == 0)
    throwing_knife_ongive(equipmentref);
}

throwing_knife_used(grenade) {
  grenade endon("death");
  grenade _id_A39EA6B39FFB2B53();
  grenade._id_AB13877362519A4F = scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5();
  grenade thread _id_BDD18334E29F6933();
  grenade makeunusable();

  if(!isDefined(grenade.equipmentref)) {
    if(grenade.weapon_name == "shuriken_mp" || grenade.weapon_name == "shuriken_mp_inert")
      grenade.equipmentref = "equip_shuriken";
    else
      grenade.equipmentref = "equip_throwing_knife";
  }

  stuckto = undefined;
  _id_16A48D7056E5C472 = undefined;
  grenade_owner_name = self.name;
  grenade endon("throwKnifeCancelStuckWait");
  grenade waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);
  level notify("grenade_exploded_during_stealth", grenade, "throwingknife_mp", grenade_owner_name);
  _id_E13E382321A8580B = isDefined(_id_16A48D7056E5C472) && _id_16A48D7056E5C472 == "tag_flicker";
  _id_E242752B8F2C334F = isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto));

  if(_id_E242752B8F2C334F && _id_E13E382321A8580B)
    stuckto notify("shield_hit", grenade);

  grenade setscriptablepartstate("showLocation", "active", 0);
  grenade throwing_knife_makepickup();
}

_id_BDD18334E29F6933() {
  self endon("explode");
  self endon("death");
  self endon("missile_stuck");

  if(istrue(self._id_38D6C8F64B607150))
    return 0;

  self waittill("missile_water_impact", _id_7842E9E94384087B);
  self._id_AB13877362519A4F = 1;
  thread _id_86B5C08AF20ABC5E();
}

_id_86B5C08AF20ABC5E() {
  level endon("game_end");
  self endon("missile_stuck");
  owner = self.owner;
  _id_AE73793772B8710A = self.origin;
  _id_0F84A0525BCC7D85 = self.weapon_object;
  _id_C653F46EE7EB6B5A = self.angles;
  _id_C6A9083AC855BC53 = "throwingknife_mp_inert";

  if(scripts\engine\utility::is_equal(self.weapon_name, "shuriken_mp"))
    _id_C6A9083AC855BC53 = "shuriken_mp_inert";

  self waittill("missile_change_to_dud", _id_69BC556674E879A4);
  owner notify("throwKnifeCancelStuckWait");

  if(isDefined(_id_69BC556674E879A4))
    _id_AE73793772B8710A = _id_69BC556674E879A4;

  _id_D8D1F946DB0FE780 = owner launchgrenade(_id_C6A9083AC855BC53, _id_AE73793772B8710A, (0, 0, 0), undefined, undefined);
  _id_D8D1F946DB0FE780._id_38D6C8F64B607150 = 1;
  _id_D8D1F946DB0FE780._id_0F84A0525BCC7D85 = _id_0F84A0525BCC7D85;
  _id_D8D1F946DB0FE780.angles = _id_C653F46EE7EB6B5A;
}

_id_3D8B0933DF7505FD(victim) {
  _id_81BD886BA4CAE915 = 45;
  _id_00451F4DC5070C2A = victim.health - 45 <= 0;

  if(_id_00451F4DC5070C2A)
    _id_81BD886BA4CAE915 = int(max(victim.health - 1, 1));

  return _id_81BD886BA4CAE915;
}

getcorpstablestate(_id_16A48D7056E5C472) {
  switch (_id_16A48D7056E5C472) {
    case "j_helmet":
      return "head";
    case "j_head":
      return "head";
    case "j_neck":
      return "head";
    case "j_spineupper":
      return "to_";
    case "j_spinelower":
      return "to_";
    case "j_shoulder_ri":
      return "ar_";
    case "j_shoulder_le":
      return "al_";
    case "j_elbow_ri":
      return "ar_";
    case "j_elbow_le":
      return "al_";
    case "j_wrist_ri":
      return "ar_";
    case "j_wrist_le":
      return "al_";
    case "j_hip_ri":
      return "lr";
    case "j_hip_le":
      return "ll_";
    case "j_knee_ri":
      return "lr";
    case "j_knee_le":
      return "ll_";
    case "j_ankle_ri":
      return "lr";
    case "j_ankle_le":
      return "ll_";
    default:
      return undefined;
  }
}

_id_A39EA6B39FFB2B53() {
  _id_E5F5E8ABCB0B75BC = _id_0CBB0697DE4C5728::_id_0150370C11A6C880(self.weapon_object);

  if(_id_E5F5E8ABCB0B75BC) {
    state = self.owner _id_0CBB0697DE4C5728::_id_8114951A631BD6A6();
    self setscriptablepartstate("soulEater", state);
  }
}

throwing_knife_makepickup() {
  self makeunusable();
  trigger = spawn("trigger_radius", self.origin, 0, 64, 64);
  trigger.targetname = "dropped_knife";
  trigger enablelinkTo();
  trigger linkTo(self);
  self.knife_trigger = trigger;

  if(!isDefined(level.throwingknives))
    level.throwingknives = [];

  _id_5C397C9CF7A06802 = [self];

  foreach(throwingknife in level.throwingknives) {
    if(_id_5C397C9CF7A06802.size >= level.throwingknifemaxpickups) {
      if(isDefined(throwingknife))
        throwingknife throwing_knife_deletepickup();

      continue;
    }

    if(isDefined(throwingknife))
      _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = throwingknife;
  }

  level.throwingknives = _id_5C397C9CF7A06802;
  thread throwing_knife_watchpickup();
  thread throwing_knife_watchpickuptimeout();
}

throwing_knife_watchpickup() {
  self endon("death");
  _id_8B121DD10A442DD2 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("inventory", "isBackpackInventoryEnabled"))
    _id_8B121DD10A442DD2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("inventory", "isBackpackInventoryEnabled")]]();

  for(;;) {
    self.knife_trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.owner) && self.owner != player) {
      continue;
    }
    if(isDefined(self._id_0F84A0525BCC7D85)) {
      if(!player hasweapon(self._id_0F84A0525BCC7D85) && !_id_8B121DD10A442DD2)
        continue;
    } else if(!player hasweapon(self.weapon_object) && !_id_8B121DD10A442DD2) {
      continue;
    }
    variantid = 0;
    weaponobj = self.weapon_object;

    if(isDefined(weaponobj))
      variantid = weaponobj.variantid;

    if(player throwing_knife_trytopickup(self.equipmentref, variantid))
      thread throwing_knife_deletepickup();
  }
}

throwing_knife_watchpickuptimeout() {
  self endon("death");
  wait(level.throwingknifepickuptimeout);
  thread throwing_knife_deletepickup();
}

throwing_knife_deletepickup() {
  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();

  self delete();
}

throwing_knife_trytopickup(equipmentref, variantid) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("throwing_knife", "tryToPickup")) {
    _id_985A9A19392D5FA7 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("throwing_knife", "tryToPickup")]](equipmentref);
    return _id_985A9A19392D5FA7;
  }

  return 1;
}