/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3950.gsc
***********************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  lib_03B1::func_DEE8();
  lib_0F39::func_2371();

  if(!isDefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.species_funcs["seeker"] = [];
  level.agent_definition["seeker"]["setup_func"] = ::setupagent;
  level._effect["seeker_warning_beacon"] = loadfx("vfx\iw7\_requests\mp\vfx_light_blink_red.vfx");
  level._effect["seeker_sparks"] = loadfx("vfx\misc\sparks\vfx_transformer_sparks_b_nolight");
  level._effect["seeker_explosion"] = loadfx("vfx\iw7\_requests\mp\power\vfx_spider_gren_exp.vfx");
}

setupcallbacks() {
  level.agent_funcs["seeker"]["on_killed"] = ::func_C58D;
  level.agent_funcs["seeker"]["on_damaged"] = ::func_C58B;
}

setupagent() {
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 360;
  self.desiredenemydistmin = 340;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.fastcrawlanimscale = 12;
  self.forcefastcrawldist = 340;
  self.fastcrawlmaxhealth = 40;
  self.dismemberchargeexplodedistsq = 2500;
  self.explosionradius = 75;
  self.explosiondamagemin = 30;
  self.explosiondamagemax = 50;
  self.meleerangesq = 9216;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 250;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 30;
  self.meleemaxdamage = 45;
  self.nocorpse = 1;
  thread func_FAEF();
}

func_FAEF() {
  self endon("death");
  wait 0.1;
  self func_8504(1, "bot_move_forward", "bot_jump", "bot_double_jump");
}

func_1090C(var_0, var_1, var_2) {
  scripts\mp\utility::printgameaction("spider grenade spawn", var_2);
  var_3 = scripts\mp\mp_agent::spawnnewagent("seeker", var_2.team, var_0, var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  scripts\mp\equipment\spider_grenade::spidergrenade_addtoactiveagentarray(var_3);
  var_3.owner = var_2;
  var_3.var_9F72 = 1;
  var_3.var_9F46 = 1;

  if(var_3.owner scripts\mp\utility::_hasperk("specialty_rugged_eqp")) {
    var_3.hasruggedeqp = 1;
    var_3 scripts\mp\mp_agent::set_agent_health(30);
  }

  var_3 setotherent(var_2);
  var_3 setsolid(0);
  return var_3;
}

func_C58B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self.owner;
  var_13 = var_1;

  if(isDefined(var_1) && isDefined(var_1.owner)) {
    var_13 = var_1.owner;
  }

  if(isDefined(level.weaponmapfunc)) {
    var_5 = [[level.weaponmapfunc]](var_5, var_0);
  }

  if(var_4 == "MOD_FALLING") {
    var_2 = 0;
  } else if(var_4 == "MOD_MELEE") {
    var_2 = 0;
  } else if(scripts\mp\weapons::func_66AA(var_5, var_4)) {
    var_2 = 0;
  } else if(isDefined(var_0) && !scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_0)) {
    var_2 = 0;
  } else if(isDefined(var_1)) {
    if(!isDefined(var_0) && !scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_13)) {
      var_2 = 0;
    } else if(!level.friendlyfire && var_12 != var_13 && !scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_12, var_13))) {
      var_2 = 0;
    }
  }

  if(var_2) {
    var_14 = getseekermaxhealth();
    var_15 = 1;

    if(scripts\mp\utility::isfmjdamage(var_5, var_4)) {
      var_15 = 2;
    } else if(var_2 >= scripts\mp\weapons::minegettwohitthreshold()) {
      var_15 = 2;
    }

    var_2 = var_15 * var_14;

    if(isPlayer(var_13)) {
      var_16 = scripts\engine\utility::ter_op(scripts\mp\utility::istrue(self.hasruggedeqp), "hitequip", "");
      var_13 scripts\mp\damagefeedback::updatedamagefeedback(var_16, var_2 >= self.maxhealth);
    }

    scripts\mp\powers::equipmenthit(var_12, var_13, var_5, var_4);

    if(var_2 >= self.health) {
      if(isDefined(var_13) && isDefined(var_12) && scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_13, var_12))) {
        var_13 thread scripts\mp\utility::giveunifiedpoints("destroyed_equipment");
      }

      if(isDefined(self.owner)) {
        thread scripts\mp\equipment\spider_grenade::spidergrenade_explode();
        return;
      }
    }
  }

  self finishagentdamage(var_0, var_1, int(var_2), var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

func_C58D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  scripts\mp\equipment\spider_grenade::spidergrenade_removefromactiveagentarray(self);
  scripts\mp\mp_agent::deactivateagent();
}

getseekermaxhealth() {
  return 15;
}

getseekermaxhealthrugged() {
  return 30;
}