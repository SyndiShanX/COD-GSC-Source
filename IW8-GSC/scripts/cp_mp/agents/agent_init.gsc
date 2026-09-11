/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\agents\agent_init.gsc
***********************************************/

function agent_init() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  scripts\anim\shared::initanimvars();
  scripts\anim\shared::initadvancetoenemy();
  scripts\anim\shared::initmeleecharges();
  scripts\anim\shared::initwindowtraverse();
  scripts\anim\shared::initdeaths();
  scripts\anim\shared::setuprandomtable();
  scripts\anim\shared::init_squadmanager();
  setupgrenades();
  initanimcallbacks();
  initstealthfuncsmp();
  scripts\anim\face::initlevelface();
  scripts\cp\vehicle::ref_1422b();
}

function setupgrenades() {
  anim.grenadetimers["AI_frag_grenade_mp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade_mp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_smoke_grenade_mp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_concussion_grenade_mp"] = randomintrange(5000, 20000);
  anim.grenadetimers["AI_splash_grenade_mp"] = randomintrange(5000, 20000);
  anim.grenadetimers["AI_molotov_mp"] = randomintrange(5000, 20000);
  anim.grenadetimers["AI_semtex_mp"] = randomintrange(5000, 20000);
  anim.grenadetimers["AI_gas_mp"] = randomintrange(5000, 20000);
}

function initanimcallbacks() {
  if(!isDefined(anim.callbacks)) {
    anim.callbacks = [];
  }

  anim.callbacks["PlaySoundAtViewHeight"] = &play_sound_at_viewheightmp;
}

function play_sound_at_viewheightmp(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!soundexists(var_0)) {
    return;
  }

  self playsoundonmovingent(var_0);

  if(isDefined(var_1)) {
    wait lookupsoundlength(var_0) / 1000;
    self notify(var_1);
    return;
  }
}

function initstealthfuncsmp() {
  level.stealthinit = &initstealthmp;
}

function getcorpsearraymp() {
  return [];
}

function setcorpseremovetimerfuncmp() {}

function initstealthmp() {
  level.fngetcorpsearrayfunc = &getcorpsearraymp;
  level.fnsetcorpseremovetimerfunc = &setcorpseremovetimerfuncmp;
}