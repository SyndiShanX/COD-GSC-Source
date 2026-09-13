/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\riotshield\riotshield.gsc
*****************************************************/

riotshield_init_cp(taskid) {
  if(istrue(self.briotshieldinitialized))
    return anim.success;

  self.secondaryweapon = makeweapon("iw9_me_riotshield_mp");

  if(self.secondaryweapon.basename != "none") {
    scripts\common\utility::initweapon(self.secondaryweapon);
    self.riotshieldmodel = "weapon_wm_riotshield_p34";
    self.riotshieldmodeltag = "tag_weapon_left";
    self attachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);
    self.bhasriotshieldattached = 1;
    self.briotshieldinitialized = 1;
    riotshield_common();
    return anim.success;
  } else
    return anim.failure;
}

riotshield_init_sp(taskid) {
  if(istrue(self.briotshieldinitialized))
    return anim.success;

  self.script_combatmode = "no_cover";
  self.script_goalheight = 80;

  if(self.secondaryweapon.basename != "none") {
    scripts\common\utility::initweapon(self.secondaryweapon);
    self.riotshieldmodel = getweaponmodel(self.secondaryweapon);
    self.riotshieldmodeltag = "tag_weapon_left";
    self attach(self.riotshieldmodel, self.riotshieldmodeltag);
    self.bhasriotshieldattached = 1;
    self.briotshieldinitialized = 1;
    self.deathfunction = ::_id_7C68BA91C6E5A2D2;
    self._id_334AB06981BC61AA = 1;
    riotshield_common();
    return anim.success;
  } else
    return anim.failure;
}

_id_7C68BA91C6E5A2D2() {
  if(!istrue(self.dropweapon))
    return 0;

  _id_0D2346943E5CB1F5 = spawn("weapon_" + getcompleteweaponname(self.secondaryweapon), self gettagorigin(self.riotshieldmodeltag));
  _id_0D2346943E5CB1F5.angles = self gettagangles(self.riotshieldmodeltag);
  _id_0D2346943E5CB1F5 physicslaunchserveritem(_id_0D2346943E5CB1F5.origin, (0, 0, 15));
  return 0;
}

riotshield_common() {
  self allowedstances("stand");
  self.minpaindamage = 0;
  self._id_9AA77AB756FDCA82 = 0;
  self.aggressivemode = 1;
  self.disablereload = 1;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = 2500;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.dontmeleeme = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self.maxfaceenemydist = 1200;
  self._id_54294E8BB0D07CDA = 0;
  self._id_98ADD129A7ECB962 = 0;
  self _meth_ AE41FBF799BA43F(1, "entity");
  self.ignoresuppression = 0;
  self._id_C49F0583B7C9F401 = 0.03;
  self.suppressiondecrement = 0.005;
  self.suppressionthreshold = 0.5;
  self._id_9440DC8A2AA90AED = 3000;
  self._id_7D606BEC79308EB5 = 512;
  self._id_85A0F6383A5DD784 = 360;
  self._id_A67833FEA11A521C = 360;
  self._id_0427CBD3288A2F59 = 128;
  self._id_5E7D402B7B6E5C12 = 25;
  self._id_20833644CC82839F = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self._id_717EB05B8FB85CFF = 40;
  self._id_E2B553399F5FF8A3 = 1000;
  self._id_E2D849399F862A5D = 2000;
  self._id_7878EF8B36BC3525 = 1000;
  self._id_789BF98B36E292DB = 2000;
  self.combat_func_active = 1;
  self enabletraversals(1);
  self _meth_CF599733554B4D9A(self.secondaryweapon);
}

terminateriotshield() {
  self allowedstances("stand", "crouch", "prone");
  self.minpaindamage = 0;
  self.aggressivemode = 0;
  self.ignoresuppression = 0;
  self.disablereload = 0;
  self.meleedamageoverride = undefined;
  self.meleemaxzdiff = 36;
  self.meleeignoreplayerstance = 0;
  self.dontsyncmelee = undefined;
  self.dontmeleeme = 0;
  self.disablebulletwhizbyreaction = 0;
  self.combatmode = "cover";
  self.disablerunngun = 0;
  self.disabledodge = 0;
  self.pathenemyfightdist = 0;
  self enabletraversals(1);
}

resetstuckthermite() {
  self.bhasthermitestucktoshield = 0;
  self.thermitestucktoshield = undefined;
  self.thermitestuckpains = undefined;
}

removeriotshield() {
  if(istrue(self.bhasriotshieldattached)) {
    if(scripts\common\utility::issp())
      self detach(self.riotshieldmodel, self.riotshieldmodeltag);
    else
      self detachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);

    self.riotshieldmodel = undefined;
    self.riotshieldmodeltag = undefined;
    self.bhasriotshieldattached = undefined;
  }
}

_id_A43626A85E6614F0(taskid) {
  if(!self.bdroppingshield)
    thread dropshield();
}

_id_97DBC630C790BFB3(taskid) {
  if(self.bdroppingshield) {
    self._blackboard.weaponrequest = "mg";
    self setbtgoalpos(4, self.origin);
    return anim.running;
  }

  return anim.failure;
}

dropshield() {
  self endon("death");
  self.bdroppingshield = 1;
  _id_18D67196C117E2C1 = 10000;
  _id_0047A17CB6C73A2A = gettime();

  while(!self asmeventfired(self.asmname, "drop_shield") && _id_0047A17CB6C73A2A + _id_18D67196C117E2C1 > gettime())
    waitframe();

  _id_DCD0A521994E1C50 = _id_0047A17CB6C73A2A + _id_18D67196C117E2C1 <= gettime();

  if(_id_DCD0A521994E1C50) {
    resetstuckthermite();
    self._blackboard.weaponrequest = "none";
    self.bdroppingshield = 0;
    self clearbtgoal(4);
    return;
  }

  self setbasearchetype("soldier");
  self setoverridearchetype("default", "soldier");
  scripts\asm\soldier\script_funcs::initanimspeedthresholds_soldier("soldier");
  _id_9CCC24389A9EDDEE = self gettagorigin(self.riotshieldmodeltag);
  _id_3E3F178F45C14044 = self gettagangles(self.riotshieldmodeltag);

  if(!istrue(level._id_E97D3DE5B99775A6)) {
    _id_0D2346943E5CB1F5 = spawn("weapon_" + getcompleteweaponname(self.secondaryweapon), self gettagorigin(self.riotshieldmodeltag));
    _id_0D2346943E5CB1F5.angles = self gettagangles(self.riotshieldmodeltag);
    _id_0D2346943E5CB1F5 physicslaunchserveritem(_id_0D2346943E5CB1F5.origin, (0, 0, 15));
    _id_0D2346943E5CB1F5 thread deleteaftertime(10);
  } else {
    _id_F7761D0F4CCE4B51 = spawn("script_model", _id_9CCC24389A9EDDEE);
    _id_F7761D0F4CCE4B51.angles = _id_3E3F178F45C14044;
    _id_F7761D0F4CCE4B51 setModel(self.riotshieldmodel);
    _id_F7761D0F4CCE4B51 physicslaunchserver(_id_9CCC24389A9EDDEE, anglesToForward(self.angles) * 5);
    _id_F7761D0F4CCE4B51 thread deleteaftertime(3);
  }

  if(isDefined(self.thermitestucktoshield)) {
    foreach(_id_65AB49AC224010E3 in self.thermitestucktoshield) {
      if(isDefined(_id_65AB49AC224010E3))
        _id_65AB49AC224010E3 delete();
    }
  }

  self._id_98ADD129A7ECB962 = 1;
  removeriotshield();
  resetstuckthermite();
  self.bdroppingshield = 0;
  self clearbtgoal(4);
  terminateriotshield();
  self._blackboard.weaponrequest = "none";
  scripts\aitypes\bt_util::bt_terminateandreplace("soldier_agent");
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  _id_3433EE6B63C7E243::updateweaponarchetype(_id_0DD6BF5F9DBA888C);
}

deleteaftertime(t) {
  self endon("death");
  wait(t);
  self delete();
}