/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\shoot\script_funcs.gsc
***********************************************/

handleburstdelay(asmname, statename) {
  self endon(statename + "_finished");

  if(!istrue(self.ignoreburstdelay))
    burstdelay();

  scripts\asm\asm::asm_fireevent(asmname, "burst_delay_finished");
}

chooseshootidle(asmname, statename, params) {
  desired_speed = self aigetdesiredspeed();
  alias = "shoot_idle";

  if(!isalive(self.enemy) || desired_speed <= 120 || istrue(self._id_E9908CA3CB35ACCF)) {
    if(scripts\asm\asm::asm_hasalias(statename, "cqb_shoot_idle"))
      alias = "cqb_shoot_idle";
  }

  return scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
}

shootstylesingle(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._blackboard.shootparams_shotsperburst == 1;
}

doshoot_mgturret(rate) {
  turret = self getturret();
  turret startfiring();
  turret endon("death");
  turret endon("turretstatechange");
  _id_89F949A75D92E1A4 = self._blackboard.shootparams_shotsperburst;

  while(_id_89F949A75D92E1A4 > 0) {
    turret shootturret();
    _id_89F949A75D92E1A4--;
    self._blackboard._id_060DCAA3D3BE97AB = gettime();
    wait(rate);
  }

  turret stopfiring();
}

doshoot_lmg(asmname, statename, rate) {
  _id_89F949A75D92E1A4 = self._blackboard.shootparams_shotsperburst;
  _id_6CB4F7CEF3D89781 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_9F75AC06FC45A7D1 = scripts\asm\asm::asm_getxanim(statename, _id_6CB4F7CEF3D89781);
  _id_07B60BC0EAB3FD1E = getanimlength(_id_9F75AC06FC45A7D1);
  _id_07B60BC0EAB3FD1E = _id_07B60BC0EAB3FD1E / rate;
  _id_D180B535A33B044D = 0.2;
  self updateplayersightaccuracy();

  while(_id_89F949A75D92E1A4 > 0) {
    _id_89F949A75D92E1A4--;
    _id_2B79931B08683E0A::shootenemywrapper(0);

    if(!isagent(self))
      self setflaggedanimknobrestart(statename, _id_9F75AC06FC45A7D1, 1, _id_D180B535A33B044D, _id_07B60BC0EAB3FD1E);

    scripts\asm\shared\utility::decrementbulletsinclip();
    wait(rate);
  }

  self shootstopsound();
}

shootstylemgturret(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._blackboard.shootparams_style == "mg" && (isDefined(self getturret()) || istrue(self.juggernaut));
}

shoot_mg(asmname, statename, params) {
  self endon(statename + "_finished");
  self._blackboard.shoot_firstshot = 0;
  rate = shoot_getrate();

  if(isDefined(self getturret()))
    doshoot_mgturret(rate);
  else {
    self _meth_82DC9AE1B5CADB32();
    doshoot_lmg(asmname, statename, rate);
  }

  self._blackboard.shootparams_numburstsleft--;
  scripts\asm\asm::asm_fireephemeralevent("shoot", "shoot_finished");
  scripts\asm\asm::asm_fireevent(asmname, "shoot_finished");
}

shoot_mg_cleanup(asmname, statename, params) {
  self shootstopsound();
}

_id_DF456D335FE508DA(asmname, statename, params) {
  if(isDefined(self._id_36973996C2FB0DF7))
    self[[self._id_36973996C2FB0DF7]](asmname, statename, params);
}

shoot_shotgunpumpsound(statename) {
  end = statename + "_shotgun_sound";
  _id_CD69A6672AF7CC61 = statename + "kill_shotgun_sound";
  thread shoot_timeout(end, _id_CD69A6672AF7CC61, 2);
  self endon(end);
  self waittillmatch(statename, "rechamber");
  self notify(_id_CD69A6672AF7CC61);
}

shootatshootentorpos(_id_9BC9D0EE2A8A46F5) {
  if(isDefined(self._blackboard.shootparams_ent) && self._blackboard.shootparams_buseentinshootcalc) {
    if(isDefined(self.enemy) && self._blackboard.shootparams_ent == self.enemy)
      self[[anim.shootenemywrapper_func]](_id_9BC9D0EE2A8A46F5);
  } else
    self[[anim.shootposwrapper_func]](self._blackboard.shootparams_pos, _id_9BC9D0EE2A8A46F5);
}

shoot_timeout(_id_182E5287AA4C3F47, _id_CB57658B734D4B0C, t) {
  self endon(_id_CB57658B734D4B0C);
  wait(t);
  self notify(_id_182E5287AA4C3F47);
}

shoot_getrate() {
  style = self._blackboard.shootparams_style;
  rate = 1.0;

  if(isDefined(self.shootrateoverride))
    rate = self.shootrateoverride;
  else if(style == "mg")
    rate = 0.1;
  else if(style == "full")
    rate = _id_76FF4BA096A6F8AA::autoshootanimrate() * randomfloatrange(0.5, 1.0);
  else if(style == "burst")
    rate = _id_76FF4BA096A6F8AA::burstshootanimrate();
  else if(_id_2B79931B08683E0A::isusingsidearm())
    rate = 3.0;
  else if(_id_2B79931B08683E0A::isusingshotgun())
    rate = scripts\asm\shared\utility::shotgunfirerate();
  else if(_id_2B79931B08683E0A::weapon_genade_launcher())
    rate = scripts\asm\shared\utility::grenadelauncherfirerate();

  return rate;
}

shoot_updateparams(asmname, statename, params) {
  self._blackboard.shootparams_readid = self._blackboard.shootparams_writeid;

  if(!isDefined(self._blackboard.shootparams_numburstsleft))
    self._blackboard.shootparams_numburstsleft = self._blackboard.shootparams_burstcount;

  scripts\code\ai_shooting::choosenumshotsandbursts();
}

burstdelay() {
  if(scripts\asm\asm_bb::bb_shootparams_idsmatch() && self._blackboard.shootparams_style == "full" && !self._blackboard.shootparams_fastburst) {
    if(self._blackboard._id_060DCAA3D3BE97AB == gettime())
      waitframe();

    return;
  }

  _id_74B5B12BB6514385 = self getremainingburstdelaytime();

  if(_id_74B5B12BB6514385)
    wait(_id_74B5B12BB6514385);
}

using_a_turret() {
  if(!isDefined(self.turret))
    return 0;

  return self.turret.owner == self;
}