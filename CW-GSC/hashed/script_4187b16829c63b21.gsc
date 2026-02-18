/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4187b16829c63b21.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_unitrigger;
#namespace namespace_5ce39742;

function init() {
  var_bbad5c42 = struct::get_array("turret_trigger_pos", "targetname");

  if(isDefined(var_bbad5c42)) {
    foreach(turret_pos in var_bbad5c42) {
      turret_pos.var_e12c4557 = 1;
      turret_pos.activate = 0;
      turret_pos.in_use = 0;
      var_a9504f50 = turret_pos zm_unitrigger::create(&function_a5680385, 64, &function_5b0907b8);
      var_a9504f50.turret_pos = turret_pos;
      var_51c78859 = getent(turret_pos.target, "targetname");

      if(isDefined(var_51c78859)) {
        turret_pos.var_51c78859 = var_51c78859;
        var_51c78859 function_619a5c20();
      }
    }
  }
}

function function_a5680385(e_player) {
  e_player globallogic::function_d96c031e();

  if(isPlayer(e_player)) {
    if(!level flag::get("power_on" + self.stub.turret_pos.script_int)) {
      self sethintstringforplayer(e_player, #"hash_39f4be8dba832f61");
      return true;
    } else if(is_true(self.stub.turret_pos.activate) && !is_true(self.stub.turret_pos.in_use)) {
      self sethintstringforplayer(e_player, #"hash_fcbeeb83bef84fa");
      return true;
    } else if(!is_true(self.stub.turret_pos.var_e12c4557)) {
      self sethintstringforplayer(e_player, #"hash_44085f35e03f91c7");
      return true;
    } else if(!is_true(self.stub.turret_pos.activate)) {
      self sethintstringforplayer(e_player, #"hash_782f31c93c442bc6", 1000);

      if(!e_player zm_score::can_player_purchase(1000)) {
        e_player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
      }

      return true;
    } else {
      return false;
    }
  }

  return false;
}

function function_5b0907b8() {
  level endon(#"end_game");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(!is_true(self.stub.turret_pos.activate) && level flag::get("power_on" + self.stub.turret_pos.script_int)) {
      if(player zm_score::can_player_purchase(1000) && is_true(self.stub.turret_pos.var_e12c4557)) {
        self.stub.turret_pos.var_e12c4557 = 0;
        self.stub.turret_pos.activate = 1;
        self.stub.turret_pos.in_use = 1;
        player thread zm_score::minus_to_player_score(1000);
        self.stub.turret_pos thread function_bc566f03();
        self.stub.turret_pos thread function_2fbfe4fb(player);
      }

      continue;
    }

    if(!is_true(self.stub.turret_pos.in_use) && is_true(self.stub.turret_pos.activate)) {
      self.stub.turret_pos thread function_2fbfe4fb(player);
      self.stub.turret_pos.in_use = 1;
    }
  }
}

function function_2fbfe4fb(player) {
  player endon(#"player_down", #"death");
  self.var_51c78859 makevehicleusable();
  self.var_51c78859 usevehicle(player, 0);
  self.var_3c15443c = player;
  self.var_3c15443c thread zm_equipment::show_hint_text(#"hash_76a210962c3e24eb", 60);
  player waittill(#"exit_vehicle");
  self.in_use = 0;
  self.var_51c78859 makevehicleunusable();

  if(isDefined(self.var_3c15443c)) {
    self.var_3c15443c notify(#"hide_equipment_hint_text");
    self.var_3c15443c = undefined;
  }
}

function function_bc566f03() {
  wait 60;
  self notify(#"time_out");
  self.activate = 0;
  self thread function_6393ca3a();

  if(isDefined(self.var_3c15443c)) {
    self.var_51c78859 usevehicle(self.var_3c15443c, 0);
    self.var_3c15443c = undefined;
  }

  self.var_51c78859 makevehicleunusable();
}

function function_6393ca3a() {
  wait 60;
  self.var_e12c4557 = 1;
}