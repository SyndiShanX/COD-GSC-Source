/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\krampus\s4_krampus.gsc
****************************************************/

init() {
  level._id_11ED["actor_s4_mp_krampus"]["setup_model_func"] = ::setup_krampus_models;
  scripts\engine\utility::_id_0FDC("vfx_codmas_krampus_spawn", "vfx/s4/gameplay/vfx_codmas_krampus_spawn");
  scripts\engine\utility::_id_0FDC("vfx_codmas_krampus_despawn", "vfx/s4/gameplay/vfx_codmas_krampus_despawn");
}

setup_krampus_models(var_0) {
  self._id_189C = "krampus";
  self._id_10691 = "unitednations";
  self setModel("c_s4_mp_krampus_01");
  self _meth_8352("c_s4_mp_krampus_01");
}

_id_D795() {
  level._id_11EF["actor_s4_mp_krampus"] = level._id_11EF["player"];
  level._id_11EF["actor_s4_mp_krampus"]["spawn"] = ::spawn_krampus;
  level._id_11EF["actor_s4_mp_krampus"]["on_killed"] = ::on_agent_krampus_killed;
  level._id_11EF["actor_s4_mp_krampus"]["on_damaged"] = _id_0016::_id_AA45;
  level._id_11EF["actor_s4_mp_krampus"]["on_damaged_finished"] = ::_id_AA50;
  level._id_11EF["actor_s4_mp_krampus"]["think"] = ::scripts\mp\agents\krampus\think::main;
}

spawn_krampus(var_0, var_1, var_2, var_3) {
  if(!(isDefined(var_0) && isDefined(var_1))) {
    var_4 = self[[level._id_6D4A]]();
    var_0 = var_4.origin;
    var_1 = var_4.angles;
  }

  self._id_E3D8 = "human";
  var_5 = _id_07F7::_id_E32A(var_3, var_0, var_1);
  var_5 _id_07F7::_id_D132(50000);
  var_6 = getdvarint("#x38c59c6af30640ce7", 1);

  if(var_6) {
    var_7 = getdvarint("#x3542c2a45b76da68e", 30000);
    var_8 = getdvarint("#x3631d8a611034a92a", 500);
    var_9 = getdvarint("#x3de01b6171fc4b40d", 1000) + var_8 * level.players.size;

    if(var_9 > var_7) {
      var_9 = var_7;
    }

    var_5 _id_07F7::_id_D132(var_9);
  }

  var_10 = getdvarint("#x358d365978f12b9ae", 0);

  if(var_10 > 0) {
    var_5 _id_07F7::_id_D132(var_10);
  }

  _id_09EF::_id_D136("team_nine");
  self _meth_8851(3, "team_nine");
  level notify("spawned_agent", self);
  scripts\mp\agents\krampus\think::init();
  scripts\engine\utility::_id_4A32();
  scripts\mp\agents\krampus\think::_id_F108();
  self takeallweapons();
  wait 0.1;
}

on_agent_krampus_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.isactive = 0;
  self._id_7552 = 0;
  _id_0847::_id_DF08("mp_krampus_death_vanish", self.origin);
  _id_0847::_id_DF21(self.breath_sfx);
  var_1._id_8FFB = gettime();

  if(isDefined(self._id_FE90)) {
    if(isDefined(self.owner)) {
      self._id_FE90 disableplayeruse(self.owner);
    }

    self._id_FE90 delete();
  }

  _id_07F7::_id_AA46(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  _id_09EF::_id_4386();
  self notify("killanimscript");
  scripts\mp\agents\krampus\think::dropkrampuspresent();
  var_1 set_has_damaged_krampus();

  foreach(var_10 in level.players) {
    if(isDefined(var_10)) {
      if(istrue(var_10.hasdamagedkrampus)) {
        var_10 thread _id_07BC::creategametypechallenegeevent("elim_krampus");
        var_10 scripts\mp\hud_message::showsplash("codmas_krampus_killed");
        continue;
      }

      var_10 scripts\mp\hud_message::showsplash("codmas_krampus_gone");
    }
  }

  reset_all_players_have_damaged_krampus();
}

_id_AA50(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self._id_B859)) {}

  var_12 = var_2;

  if(isDefined(var_8) && var_8 == "head") {
    var_12 = int(var_12 * 0.6);

    if(var_2 > 0 && var_12 <= 0) {
      var_12 = 1;
    }
  }

  if(self.health - var_12 > 0) {
    _id_0B00::_id_AA9A(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isPlayer(var_1)) {
    scripts\mp\agents\krampus\think::damageaggrotoattacker(var_1);
  }

  _id_07F7::_id_457A(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);

  if(isPlayer(var_1)) {
    var_1 set_has_damaged_krampus();
  }
}

set_has_damaged_krampus() {
  self.hasdamagedkrampus = 1;
}

reset_all_players_have_damaged_krampus() {
  foreach(var_1 in level.players) {
    var_1.hasdamagedkrampus = undefined;
  }
}