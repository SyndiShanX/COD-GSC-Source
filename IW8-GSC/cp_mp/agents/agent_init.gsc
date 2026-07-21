/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\agents\agent_init.gsc
***********************************************/

agent_init() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }
  anim.notfirsttime = 1;
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::initanimvars();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::initadvancetoenemy();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::initmeleecharges();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::initwindowtraverse();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::initdeaths();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::setuprandomtable();
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::init_squadmanager();
  setupgrenades();
  initanimcallbacks();
  initstealthfuncsmp();
  _encstr_B282169B8DE496C13ACDE52C9BB4B6F29958D8595C3B6E1B::initlevelface();
  scripts\cp\vehicle::_id_1422B();
}

setupgrenades() {
  anim.grenadetimers["_encstr_82EA13A1FBB815B3686F507F12755D371C97F84A63"] = randomintrange(0, 20000);
  anim.grenadetimers["_encstr_84D714386197BF9331AE78574CBB7F4513E0E251F861"] = randomintrange(0, 20000);
  anim.grenadetimers["_encstr_93E714415B1637AD2FB0B229E82DE70B89A5ED27D15B"] = randomintrange(0, 20000);
  anim.grenadetimers["_encstr_881D1914A4AFB1B77336D5CDB92DDBDCBE3B27959BB046CAFAB60E"] = randomintrange(5000, 20000);
  anim.grenadetimers["_encstr_81B7155EABAF23689028E793C1A9220AB5C79FCF0863CB"] = randomintrange(5000, 20000);
  anim.grenadetimers["_encstr_B47B0EB6FC377A8F1547F8C86BCF20E3"] = randomintrange(5000, 20000);
  anim.grenadetimers["_encstr_827F0D259877BE28A58C3B19BF8D48"] = randomintrange(5000, 20000);
  anim.grenadetimers["_encstr_B4BD0A2852BEB385E67DB683"] = randomintrange(5000, 20000);
}

initanimcallbacks() {
  if(!isDefined(anim.callbacks))
    anim.callbacks = [];

  anim.callbacks["_encstr_B2A216D049519FA2AFC0821A59A1AB9789AC409D533963B3"] = ::play_sound_at_viewheightmp;
}

play_sound_at_viewheightmp(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!soundexists(var_0)) {
    return;
  }
  self playsoundonmovingent(var_0);

  if(isDefined(var_1)) {
    wait(lookupsoundlength(var_0) / 1000);
    self notify(var_1);
  }
}

initstealthfuncsmp() {
  level.stealthinit = ::initstealthmp;
}

getcorpsearraymp() {
  return [];
}

setcorpseremovetimerfuncmp() {}

initstealthmp() {
  level.fngetcorpsearrayfunc = ::getcorpsearraymp;
  level.fnsetcorpseremovetimerfunc = ::setcorpseremovetimerfuncmp;
}