/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\elf\s4_mp_codmas_elf.gsc
******************************************************/

init() {
  level._id_11ED["actor_s4_mp_codmas_elf"]["setup_model_func"] = ::_id_D75D;
}

_id_D75D(var_0) {
  self._id_189C = "soldier";
  self._id_10691 = "unitednations";
  self setModel("c_s4_mp_elf_01");
  self _meth_8352("c_s4_mp_elf_01");
}

_id_D795() {
  level._id_11EF["actor_s4_mp_codmas_elf"] = level._id_11EF["player"];
  level._id_11EF["actor_s4_mp_codmas_elf"]["spawn"] = ::spawn_krampus;
  level._id_11EF["actor_s4_mp_codmas_elf"]["on_killed"] = ::_id_AA44;
  level._id_11EF["actor_s4_mp_codmas_elf"]["on_damaged"] = _id_0016::_id_AA45;
  level._id_11EF["actor_s4_mp_codmas_elf"]["on_damaged_finished"] = ::_id_AA50;
  level._id_11EF["actor_s4_mp_codmas_elf"]["think"] = ::scripts\mp\agents\krampus\think::main;
}

spawn_krampus(var_0, var_1, var_2, var_3) {
  if(!(isDefined(var_0) && isDefined(var_1))) {
    var_4 = self[[level._id_6D4A]]();
    var_0 = var_4.origin;
    var_1 = var_4.angles;
  }

  self._id_E3D8 = "human";
  var_5 = _id_07F7::_id_E32A(var_3, var_0, var_1);

  if(isDefined(var_2)) {
    _id_09EF::_id_D136(var_2.team);
    self _meth_8851(3, var_2.team);
  }

  level notify("spawned_agent", self);
  scripts\mp\agents\krampus\think::init();
  self takeallweapons();
  wait 0.1;
}

_id_AA44(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.isactive = 0;
  self._id_7552 = 0;
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
    if(isDefined(self._id_1DFA) && self._id_1DFA != "attacking") {
      if(distancesquared(self.origin, var_1.origin) <= self._id_4CC7) {
        _id_0B00::_id_D55D(var_1);
      }
    }
  }

  _id_07F7::_id_457A(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}