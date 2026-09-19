/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1367.gsc
**************************************/

_id_786C() {
  level._id_ABE8 = [];
  level._id_7874 = [];
  level._id_0BD7 = [];
  level._id_08CC = [];
  level._id_ABE7 = spawnStruct();
  level._id_ABE7._id_5870 = [];
  level._id_782E = 0;

  if(1) {
    var_0 = _id_0547::getzombiemapsetting("QuestHintTable");
    level.questhinttablepath = var_0;
    var_1 = _func_27B(var_0);
    var_2 = _func_27A(var_0);
    level._id_ABEF = [];
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2; var_4++) {
      var_5 = _func_1B0(var_0, var_4, var_3);
      level._id_ABEF[var_4] = var_5;
    }

    level thread _id_5F3C();
  }

  level thread quest_analytics_match_summary();
  level thread maps\mp\_utility::_id_6F74(::_id_782A);
}

zmb_hint_system_disabled() {
  return _id_0547::_id_5565(level.zmb_uses_hint_notebook, 0);
}

removed_quest_hint() {
  return undefined;
}

quest_ensure_proper_hints(var_0) {
  if(common_scripts\utility::_id_562E(level.quest_assert_no_hints) && isDefined(var_0))
    var_0 = undefined;

  return var_0;
}

_id_7846(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_5))
    var_5 = 1;

  if(!isDefined(var_6))
    var_6 = 1;

  var_3 = quest_ensure_proper_hints(var_3);
  var_7 = spawnStruct();
  var_7.name = var_0;
  var_7._id_6F77 = [];
  var_7._id_2917 = [];
  var_7._id_939C = [];
  var_7._id_933D = "not started";
  var_7._id_939A = undefined;
  var_7._id_782C = var_1;
  var_7._id_4DAC = var_3;
  var_7._id_3007 = undefined;
  var_7._id_3008 = undefined;
  var_7._id_8BDE = var_5;
  var_7._id_8BE1 = var_6;
  var_7._id_76A7 = common_scripts\utility::_id_98E7(isDefined(var_2), var_2, []);
  level._id_ABE8[var_0] = var_7;

  if(isDefined(var_4))
    var_8 = common_scripts\utility::_id_0F79(["mp_zombie_nest_01", "mp_zombie_training"], maps\mp\_utility::_id_4571());
  else
    var_4 = "ZOMBIES_EMPTY_STRING";

  var_7._id_4DAD = var_4;
  common_scripts\utility::flag_init(var_0);
}

_id_782F(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_6C17 = var_0;
  var_3._id_7840 = [];
  var_3._id_37C5 = [];
  var_3._id_6925 = [];
  var_3._id_2AF8 = var_2;

  if(isDefined(var_1)) {
    if(!_func_0C0(var_1))
      var_1 = [var_1];

    foreach(var_5 in var_1) {
      if(!_id_5642(var_5)) {
        continue;
      }
      var_3._id_37C5 = common_scripts\utility::_id_0F6F(var_3._id_37C5, var_5);
    }
  }

  level._id_0BD7 = common_scripts\utility::_id_0F6F(level._id_0BD7, var_3);

  if(isDefined(var_0))
    var_3._id_7B06 = var_0;
  else if(var_3._id_37C5.size)
    var_3._id_7B06 = var_3._id_37C5[0].origin;

  var_3 _id_7844(var_3._id_7B06, "objective_create");
  return var_3;
}

_id_781D(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = _id_7832(var_0);

  if(var_3._id_933D != "in progress") {
    return;
  }
  if(var_2)
    var_3._id_2917 = common_scripts\utility::_id_0F6F(var_3._id_2917, var_1);
  else
    var_3._id_6F77 = common_scripts\utility::_id_0F6F(var_3._id_6F77, var_1);

  var_1._id_7840 = common_scripts\utility::_id_0F6F(var_1._id_7840, var_0);

  if(var_1._id_7840.size != 1) {
    return;
  }
  level._id_08CC = common_scripts\utility::_id_0F6F(level._id_08CC, var_1);

  foreach(var_5 in _id_42B9())
  _id_783A(var_5, var_1);
}

_id_7847(var_0, var_1) {
  var_2 = _id_7832(var_0);
  _id_783D(var_1, var_2);
}

_id_781E(var_0, var_1, var_2, var_3, var_4) {
  _id_781F(var_0);
  var_5 = _id_7832(var_0);
  var_4 = quest_ensure_proper_hints(var_4);
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6._id_A09A = var_2;
  var_6._id_00D4 = var_5._id_939C.size;
  var_6._id_4DAC = var_4;
  var_6._id_9399 = common_scripts\utility::_id_98E7(_func_0C0(var_3), var_3, [var_3]);
  var_5._id_939C[var_6._id_00D4] = var_6;
  common_scripts\utility::flag_init(_id_7838(var_0, var_1));
}

_id_7848(var_0) {
  _id_781F(var_0);
  var_1 = _id_7832(var_0);
  level thread _id_7849(var_1);
}

_id_7870(var_0, var_1) {
  common_scripts\utility::_id_3C9F(_id_7838(var_0, var_1));
}

_id_782D(var_0, var_1) {
  common_scripts\utility::flag_set(_id_7838(var_0, var_1));
}

_id_783E(var_0, var_1) {
  return common_scripts\utility::_id_3C77(_id_7838(var_0, var_1));
}

_id_7838(var_0, var_1, var_2) {
  if(!common_scripts\utility::_id_562E(var_2))
    _id_7820(var_0, var_1);

  return "flag " + var_0 + " " + var_1;
}

_id_30D8(var_0) {}

_id_1D88(var_0) {
  var_1 = _id_7836(var_0);
  var_2 = common_scripts\utility::_id_0F7E(level._id_7874, var_0);

  if(var_0._id_8BDE && isDefined(var_0._id_4DAC) || isDefined(var_1) && var_0._id_8BE1 && isDefined(var_1._id_4DAC))
    _id_378C(var_0);
  else if(isDefined(var_2)) {
    level._id_7874 = common_scripts\utility::_id_0F93(level._id_7874, var_0);

    if(var_2 < 3) {
      _id_7CAF(var_0);
      _id_7CB6(var_0);

      if(level._id_7874.size >= 3)
        _id_378D(level._id_7874[2]);

      _id_7ACA();
    }
  }
}

_id_9A78(var_0) {
  _id_8564(var_0, !_id_42D6(var_0));
}

_id_9A7C(var_0) {
  _id_8596(var_0, !_id_434E(var_0));
}

_id_42D6(var_0) {
  return _id_7834(var_0)._id_8BDE;
}

_id_434E(var_0) {
  return _id_7834(var_0)._id_8BE1;
}

_id_8564(var_0, var_1) {
  var_2 = _id_7834(var_0);
  var_2._id_8BDE = var_1;
  _id_1D88(var_2);
}

_id_8596(var_0, var_1) {
  var_2 = _id_7834(var_0);
  var_2._id_8BE1 = var_1;
  _id_1D88(var_2);
}

_id_20BA(var_0, var_1) {
  var_2 = _id_7834(var_0);
  _id_7CAF(var_2);
  var_1 = quest_ensure_proper_hints(var_1);
  var_2._id_4DAC = var_1;
  _id_1D88(var_2);
}

_id_20BC(var_0, var_1, var_2) {
  var_3 = _id_7834(var_0);
  var_4 = _id_7835(var_3, var_1);
  var_2 = quest_ensure_proper_hints(var_2);

  if(_id_0547::_id_5565(var_4._id_00D4, var_3._id_939A))
    _id_7822(var_0, var_2);
  else
    var_4._id_4DAC = var_2;
}

_id_7822(var_0, var_1) {
  var_2 = _id_7834(var_0);
  _id_7CB6(var_2);
  var_3 = _id_7836(var_2);
  var_1 = quest_ensure_proper_hints(var_1);

  if(isDefined(var_3))
    var_3._id_4DAC = var_1;

  _id_1D88(var_2);
}

_id_782A() {
  var_0 = self;
  var_0 waittill("spawned_player");
  var_0 quest_omnvar_init();
  var_0 thread quest_omnvar_handle_player_respawn();

  foreach(var_2 in level._id_ABE7._id_5870) {
    if(var_2.type == 2) {
      _id_782B(var_0, var_2);
      continue;
    }

    if(var_2.type == 1)
      zombie_collectable_internal_global_collect_on_join(var_2);
  }
}

_id_782B(var_0, var_1) {
  var_0 thread _id_AB8A(var_1);
}

_id_AB8C(var_0) {
  var_4 = spawnStruct();
  var_4._id_3C8C = var_0;
  var_4._id_3E41 = 0;
  var_4.type = 1;
  var_4._id_00D4 = level._id_ABE7._id_5870.size;
  level._id_ABE7._id_5870 = common_scripts\utility::_id_0F6F(level._id_ABE7._id_5870, var_4);
  level thread _id_AB89(var_4);
}

_id_AB8D(var_0, var_1) {
  var_5 = spawnStruct();
  var_5._id_3C8C = var_0;
  var_5._id_3E41 = 0;
  var_5.type = 2;
  var_5._id_00D4 = level._id_ABE7._id_5870.size;
  level._id_ABE7._id_5870 = common_scripts\utility::_id_0F6F(level._id_ABE7._id_5870, var_5);
}

_id_AB88(var_0) {
  common_scripts\utility::flag_set(var_0);
}

should_write_match_data(var_0, var_1) {
  if(common_scripts\utility::_id_562E(level._id_783F))
    return 0;

  if(!isDefined(var_0))
    return 0;

  if(var_0 >= var_1)
    return 0;

  return 1;
}

quest_should_write_match_data(var_0) {
  return should_write_match_data(var_0, 32);
}

step_should_write_match_data(var_0) {
  return should_write_match_data(var_0, 100);
}

quest_analytics_objective_step(var_0, var_1) {
  var_2 = getmatchdata("objective_step_count");
  setmatchdata("objective_step_count", maps\mp\_utility::_id_2315(var_2 + 1));

  if(step_should_write_match_data(var_2)) {
    var_3 = _id_0485::getmatchtimepassed();
    setmatchdata("objective_steps", var_2, "step", var_0);
    setmatchdata("objective_steps", var_2, "time_ms", var_3);
    setmatchdata("objective_steps", var_2, "objective", var_1);

    if(isDefined(level.player)) {
      var_4 = level.player _id_055A::_id_462D();

      if(!isDefined(var_4))
        var_4 = "none";

      setmatchdata("objective_steps", var_2, "area", var_4);
    }
  }
}

quest_analytics_match_summary() {
  level waittill("game_ended");
  var_0 = gettime();
  var_1 = _id_0485::getmatchtimepassed();

  foreach(var_3 in level._id_ABE8) {
    var_4 = 0.0000166667;
    var_5 = undefined;

    if(isDefined(var_3._id_924E)) {
      var_6 = var_0;

      if(isDefined(var_3._id_3BA1))
        var_6 = var_3._id_3BA1;

      var_5 = (var_6 - var_3._id_924E) * var_4;
    }

    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = _id_7836(var_3);

    if(isDefined(var_10)) {
      var_7 = var_10.name;
      var_8 = (var_0 - var_10._id_924E) * var_4;
      var_9 = level._id_A980;
    }

    var_11 = _id_0547::_id_AC4B(undefined, "questsummary");
    var_11 _id_0547::_id_AC48("quest_name", var_3.name);
    var_11 _id_0547::_id_AC48("quest_status", var_3._id_933D);
    var_11 _id_0547::_id_AC44("quest_start_wave", var_3._id_92AF);
    var_11 _id_0547::_id_AC44("quest_finish_wave", var_3._id_3BA4);
    var_11 _id_0547::_id_AC43("quest_min", var_5);
    var_11 _id_0547::_id_AC48("step_name", var_7);
    var_11 _id_0547::_id_AC43("step_min", var_8);
    var_11 _id_0547::_id_AC44("step_wave", var_9);
    var_11 _id_0547::_id_AC4D();

    if(quest_should_write_match_data(var_3.objective_index)) {
      var_12 = var_1;

      if(isDefined(var_3.finish_game_ms))
        var_12 = var_3.finish_game_ms;

      var_13 = var_1;

      if(isDefined(var_3.start_game_ms))
        var_13 = var_3.start_game_ms;

      if(!isDefined(var_7))
        var_7 = "unknown";

      setmatchdata("objectives", var_3.objective_index, "description", var_3.name);
      setmatchdata("objectives", var_3.objective_index, "start_time_ms", var_13);
      setmatchdata("objectives", var_3.objective_index, "end_time_ms", var_12);
      setmatchdata("objectives", var_3.objective_index, "step", var_7);
    }
  }
}

_id_7844(var_0, var_1, var_2, var_3) {
  var_4 = "";

  if(isDefined(var_2))
    var_4 = var_2.name;

  if(isDefined(var_2) && !isDefined(var_3))
    var_3 = _id_7836(var_2);

  var_5 = "";

  if(isDefined(var_3))
    var_5 = var_3.name;

  var_6 = "";

  if(isDefined(self._id_2AF8))
    var_6 = self._id_2AF8;

  if(!isDefined(var_1))
    var_1 = "";

  var_7 = _id_0547::_id_AC4B(var_0, "questsubevent");
  var_7 _id_0547::_id_AC48("category", var_1);
  var_7 _id_0547::_id_AC48("quest", var_4);
  var_7 _id_0547::_id_AC48("step", var_5);
  var_7 _id_0547::_id_AC48("debug_name", var_6);
  var_7 _id_0547::_id_AC4A();
  var_7 _id_0547::_id_AC4D();
}

_id_7837() {
  var_0 = "";

  if(isDefined(level._id_ABE8)) {
    foreach(var_3, var_2 in level._id_ABE8) {
      if(var_2._id_933D == "in progress") {
        if(var_0 != "")
          var_0 = var_0 + ",";

        var_0 = var_0 + var_3;

        if(isDefined(var_2._id_939A))
          var_0 = var_0 + ("/" + var_2._id_939C[var_2._id_939A].name);
      }
    }
  }

  return var_0;
}

_id_7849(var_0) {
  waittillframeend;
  var_0.objective_index = quest_allocate_match_data_counter();

  if(quest_should_write_match_data(var_0.objective_index)) {
    setmatchdata("objectives", var_0.objective_index, "description", var_0.name);
    setmatchdata("objectives", var_0.objective_index, "description_id", var_0._id_4DAD);
    setmatchdata("objectives", var_0.objective_index, "is_hardcore", 0);
    setmatchdata("objectives", var_0.objective_index, "start_time_ms", -1);
  }

  common_scripts\utility::_id_3CA1(var_0._id_76A7);
  var_0._id_933D = "in progress";
  var_0._id_924E = gettime();
  var_0.start_game_ms = _id_0485::getmatchtimepassed();
  var_0._id_92AF = level._id_A980;
  _id_7844(undefined, "quest_start", var_0, undefined);
  _id_20BA(var_0.name, var_0._id_4DAC);

  if(quest_should_write_match_data(var_0.objective_index))
    setmatchdata("objectives", var_0.objective_index, "start_time_ms", var_0.start_game_ms);

  for(var_0._id_939A = 0; var_0._id_939A < var_0._id_939C.size; var_0._id_939A++) {
    var_4 = var_0._id_939C[var_0._id_939A];

    if(isDefined(var_4._id_A09A))
      level childthread[[var_4._id_A09A]]();

    var_4._id_924E = gettime();
    var_4._id_92AF = level._id_A980;
    _id_7844(undefined, "step_start", var_0, var_4);
    _id_7822(var_0.name, var_4._id_4DAC);
    _id_7870(var_0.name, var_4.name);
    _id_7822(var_0.name, undefined);
    var_4._id_3BA1 = gettime();
    var_4._id_3BA4 = level._id_A980;
    _id_7844(undefined, "step_end", var_0, var_4);
    quest_analytics_objective_step(var_4.name, var_0.objective_index);

    while(var_0._id_2917.size > 0) {
      var_5 = var_0._id_2917[0];
      _id_783D(var_5, var_0);
    }

    foreach(var_7 in var_4._id_9399) {
      if(isDefined(var_7))
        level childthread[[var_7]]();
    }
  }

  var_0._id_939A = undefined;
  var_0._id_933D = "completed";
  _id_20BA(var_0.name, undefined);
  var_0._id_3BA1 = gettime();
  var_0.finish_game_ms = _id_0485::getmatchtimepassed();
  var_0._id_3BA4 = level._id_A980;
  _id_7844(undefined, "quest_end", var_0, undefined);

  if(quest_should_write_match_data(var_0.objective_index)) {
    setmatchdata("objectives", var_0.objective_index, "end_time_ms", var_0.finish_game_ms);
    setmatchdata("objectives", var_0.objective_index, "is_completed", 1);
  }

  while(var_0._id_6F77.size > 0) {
    var_5 = var_0._id_6F77[0];
    _id_783D(var_5, var_0);
  }

  if(isDefined(var_0._id_782C))
    level childthread[[var_0._id_782C]]();

  common_scripts\utility::flag_set(var_0.name);
}

_id_7832(var_0) {
  var_1 = level._id_ABE8[var_0];
  return var_1;
}

_id_7833(var_0, var_1) {
  foreach(var_3 in var_0._id_939C) {
    if(var_3.name == var_1)
      return var_3;
  }
}

_id_7835(var_0, var_1) {
  var_2 = _id_7833(var_0, var_1);
  return var_2;
}

_id_7831(var_0) {
  var_1 = _id_7832(var_0);
  return isDefined(var_1);
}

_id_781F(var_0) {}

_id_7850(var_0, var_1) {
  var_2 = _id_7832(var_0);

  if(!isDefined(var_2))
    return 0;

  var_3 = _id_7833(var_2, var_1);
  return isDefined(var_3);
}

_id_7820(var_0, var_1) {}

_id_7836(var_0) {
  if(!isDefined(var_0._id_939A)) {
    return;
  }
  var_1 = var_0._id_939C[var_0._id_939A];
  return var_1;
}

_id_7834(var_0) {
  _id_781F(var_0);
  return _id_7832(var_0);
}

quest_allocate_match_data_counter() {
  var_0 = level._id_782E;
  level._id_782E++;

  if(var_0 < 32)
    setmatchdata("objective_count", level._id_782E);
  else {}

  return var_0;
}

_id_419A() {
  if(level._id_7874.size < 3)
    return level._id_7874.size;

  return 3;
}

_id_7ACA() {
  if(1) {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players)
      _id_5F3D(var_1);
    }
  }
}

_id_378D(var_0) {
  if(!isDefined(var_0._id_3007))
    var_0._id_3007 = var_0._id_4DAC;

  var_1 = _id_7836(var_0);

  if(isDefined(var_1) && !isDefined(var_0._id_3008) && isDefined(var_1._id_4DAC))
    var_0._id_3008 = var_1._id_4DAC;
}

_id_7CB6(var_0) {
  if(isDefined(var_0._id_3008))
    var_0._id_3008 = undefined;
}

_id_7CAF(var_0) {
  if(isDefined(var_0._id_3007))
    var_0._id_3007 = undefined;
}

_id_378C(var_0) {
  var_1 = common_scripts\utility::_id_0F7E(level._id_7874, var_0);
  var_2 = 0;

  if(isDefined(var_1)) {
    if(var_1 >= 3) {
      level._id_7874 = common_scripts\utility::_id_0F93(level._id_7874, var_0);
      level._id_7874 = common_scripts\utility::_id_0F73([var_0], level._id_7874);
      var_2 = 1;
    }
  } else {
    level._id_7874 = common_scripts\utility::_id_0F73([var_0], level._id_7874);
    var_2 = 1;
  }

  if(var_2 && level._id_7874.size > 3)
    _id_7CAF(level._id_7874[3]);

  _id_378D(var_0);
  _id_7ACA();
}

_id_5F3B(var_0, var_1) {
  if(!var_1)
    return 0;

  if(!isDefined(var_0))
    return 0;

  var_2 = common_scripts\utility::_id_0F7E(level._id_ABEF, var_0);
  return var_2;
}

_id_5F3D(var_0) {
  if(zmb_hint_system_disabled()) {
    return;
  }
  var_1 = _id_419A();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = level._id_7874[var_2];
    var_4 = _id_5F3B(var_3._id_3007, var_3._id_8BDE);
    var_0 _meth_82FF("ui_zm_quest_hint_" + var_2, var_4);
    var_5 = _id_5F3B(var_3._id_3008, var_3._id_8BE1);
    var_0 _meth_82FF("ui_zm_step_hint_" + var_2, var_5);
  }

  while(var_2 < 3) {
    var_0 _meth_82FF("ui_zm_quest_hint_" + var_2, 0);
    var_0 _meth_82FF("ui_zm_step_hint_" + var_2, 0);
    var_2++;
  }

  var_0 _meth_85EF(&"update_zm_quest_hints", 0);
}

_id_A8D6(var_0) {
  var_1 = var_0 getentitynumber();
  var_0 waittill("disconnect");

  foreach(var_3 in level._id_0BD7) {
    foreach(var_5 in var_3._id_37C5) {
      if(!_id_5642(var_5)) {
        continue;
      }
      if(isDefined(var_5._id_6F47))
        var_5._id_6F47[var_1] = undefined;
    }

    var_7 = var_3._id_6925[var_1];

    if(!isDefined(var_7)) {
      continue;
    }
    var_3._id_6925[var_1] = undefined;
    var_8 = var_7._id_A98D;

    if(!isDefined(var_8)) {
      continue;
    }
    var_8 notify("gain_ownership");
    var_8 destroy();
  }
}

_id_42B9() {
  if(!isDefined(level.players))
    return [];

  var_0 = [];

  foreach(var_2 in level.players) {
    if(!common_scripts\utility::_id_562E(var_2._id_5602)) {
      continue;
    }
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  return var_0;
}

_id_A8DC(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0._id_5602 = 0;
  var_1 = "on togglescore";
  var_0 _meth_82E1(var_1, "togglescores");
  level thread _id_A8D6(var_0);

  for(;;) {
    var_0 waittill(var_1);
    var_0._id_5602 = !var_0._id_5602;

    if(var_0._id_5602 && maps\mp\_utility::_id_585F())
      var_0._id_4DC4++;

    level notify(var_1);

    if(zmb_hint_system_disabled()) {
      continue;
    }
    if(var_0._id_5602) {
      if(isDefined(level.plr_custom_on_scoreboard_open_func))
        level thread[[level.plr_custom_on_scoreboard_open_func]](var_0);

      foreach(var_3 in level._id_08CC)
      _id_783A(var_0, var_3);

      continue;
    }

    if(isDefined(level.plr_custom_on_scoreboard_off_func))
      level thread[[level.plr_custom_on_scoreboard_off_func]](var_0);

    foreach(var_3 in level._id_08CC)
    _id_783C(var_0, var_3, 1.5);
  }
}

_id_5F3C() {
  if(isDefined(level.players)) {
    foreach(var_1 in level.players)
    _id_5F3D(var_1);
  }

  for(;;) {
    level waittill("connected", var_1);
    _id_5F3D(var_1);
    level thread _id_A8DC(var_1);
  }
}

_id_5642(var_0) {
  if(_func_279(var_0) || !isDefined(var_0))
    return 0;

  return 1;
}

_id_783A(var_0, var_1) {
  if(zmb_hint_system_disabled()) {
    return;
  }
  var_2 = var_0 getentitynumber();
  var_3 = 0;
  var_4 = 1;

  foreach(var_6 in var_1._id_37C5) {
    if(!_id_5642(var_6)) {
      continue;
    }
    if(!isDefined(var_6._id_6F47))
      var_6._id_6F47 = [];

    if(!isDefined(var_6._id_6F47[var_2]))
      var_6._id_6F47[var_2] = 0;

    var_6._id_6F47[var_2]++;

    if(var_6._id_6F47[var_2] != 1) {
      continue;
    }
    var_6 _meth_8427(var_0, var_3, !var_4);
  }

  if(!isDefined(var_1._id_6925[var_2]))
    var_1._id_6925[var_2] = spawnStruct();

  var_8 = var_1._id_6925[var_2];

  if(!isDefined(var_1._id_6C17)) {
    return;
  }
  var_9 = var_8._id_A98D;

  if(isDefined(var_9)) {
    var_9 notify("gain_ownership");
    var_9._id_5578 = 0;
  } else {
    var_9 = _func_19B(var_0);
    var_9 setshader("objpoint_default", 1, 1);
    var_9.alpha = 0;
    var_9.color = (1, 1, 1);
    var_9.x = var_1._id_6C17[0];
    var_9.y = var_1._id_6C17[1];
    var_9._id_01D9 = var_1._id_6C17[2];
    var_9 _meth_80CB(0, 1, 0);
    var_8._id_A98D = var_9;
  }

  var_9 fadeovertime(0.5);
  var_9.alpha = 0.9;
}

_id_A98E(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_0 endon("disconnect");
  var_3 = 100;
  var_4 = 350;

  for(;;) {
    wait 0.1;
    var_5 = _func_0E1(var_1._id_6C17, var_0.origin);
    var_6 = 0.9;

    if(common_scripts\utility::_id_562E(var_2._id_5578) || var_5 < var_3 || var_5 > var_4)
      var_6 = 0;

    if(var_6 == var_2.alpha) {
      continue;
    }
    var_2 fadeovertime(0.5);
    var_2.alpha = var_6;
  }
}

_id_783B(var_0, var_1, var_2) {
  var_3 = var_1._id_6925[var_0 getentitynumber()];
  var_4 = var_3._id_A98D;

  if(!isDefined(var_4)) {
    return;
  }
  var_4 endon("gain_ownership");
  var_0 endon("disconnect");
  wait(var_2);
  var_4._id_5578 = 1;
  var_4 fadeovertime(0.5);
  var_4.alpha = 0;
  wait 0.5;
  var_4 destroy();
  var_3._id_A98D = undefined;
}

_id_783C(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();

  if(zmb_hint_system_disabled()) {
    return;
  }
  foreach(var_5 in var_1._id_37C5) {
    if(!_id_5642(var_5)) {
      continue;
    }
    var_5._id_6F47[var_3]--;

    if(var_5._id_6F47[var_3]) {
      continue;
    }
    var_5 _meth_8428(var_0);
  }

  level thread _id_783B(var_0, var_1, var_2);
}

_id_783D(var_0, var_1) {
  var_2 = 0;

  if(common_scripts\utility::_id_0F79(var_1._id_2917, var_0)) {
    var_1._id_2917 = common_scripts\utility::_id_0F93(var_1._id_2917, var_0);
    var_2++;
  }

  if(common_scripts\utility::_id_0F79(var_1._id_6F77, var_0)) {
    var_1._id_6F77 = common_scripts\utility::_id_0F93(var_1._id_6F77, var_0);
    var_2++;
  }

  var_0._id_7840 = common_scripts\utility::_id_0F93(var_0._id_7840, var_1.name);

  if(var_0._id_7840.size != 0) {
    return;
  }
  level._id_08CC = common_scripts\utility::_id_0F93(level._id_08CC, var_0);

  foreach(var_4 in _id_42B9())
  _id_783C(var_4, var_0, 0);

  _id_7844(var_0._id_7B06, "objective_remove", var_1);
}

_id_AB89(var_0) {
  waitframe();
  common_scripts\utility::_id_3C9F(var_0._id_3C8C);
  var_0._id_3E41 = 1;
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_objective_completed");

  foreach(var_3 in level.players) {
    var_3 quest_omnvar_mark_completed(var_0._id_00D4, 1);
    var_3 thread maps\mp\gametypes\_hud_message::_id_9102(var_0._id_3C8C);
  }
}

zombie_collectable_internal_global_collect_on_join(var_0) {
  var_1 = self;

  if(var_0._id_3E41)
    var_1 quest_omnvar_mark_completed(var_0._id_00D4, 1);
}

_id_AB8A(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  waitframe();
  common_scripts\utility::_id_379C(var_0._id_3C8C);
  var_0._id_3E41 = 1;
  quest_omnvar_mark_completed(var_0._id_00D4, 1);
  thread maps\mp\gametypes\_hud_message::_id_9102(var_0._id_3C8C);
}

_id_4BCA(var_0, var_1) {
  var_2 = level.zombiehcanalyticcounters[var_0];

  if(quest_should_write_match_data(var_2)) {
    var_3 = _id_0485::getmatchtimepassed();
    setmatchdata("objectives", var_2, "is_completed", var_1);
    setmatchdata("objectives", var_2, "end_time_ms", var_3);
    setmatchdata("objectives", var_2, "step", var_0);
    quest_analytics_objective_step(var_0, var_2);
  }

  if(_id_0547::_id_AC4C()) {
    var_4 = _id_0547::_id_AC4B(undefined, "hc_objective");
    var_4 _id_0547::_id_AC48("Desc", var_0);
    var_4 _id_0547::_id_AC42("Succeeded", var_1);
    var_4 _id_0547::_id_AC4D();
  }

  level notify(get_hc_analytics_reported_notify(var_0));
}

_id_4BCB(var_0) {
  level endon(get_hc_analytics_reported_notify(var_0));
  level waittill("game_ended");
  _id_4BCA(var_0, 0);
}

_id_4BC8(var_0) {
  var_1 = common_scripts\utility::_id_98E7(_func_0C0(var_0), var_0, [var_0]);

  foreach(var_3 in var_1) {
    if(common_scripts\utility::_id_3C77(var_3)) {
      continue;
    }
    common_scripts\utility::flag_set(var_3);
    _id_4BCA(var_3, 1);
  }
}

hc_analytics_register_match_data(var_0, var_1, var_2) {
  waitframe();
  var_3 = quest_allocate_match_data_counter();
  var_4 = _id_0485::getmatchtimepassed();

  if(quest_should_write_match_data(var_3)) {
    setmatchdata("objectives", var_3, "description", var_1);
    setmatchdata("objectives", var_3, "description_id", var_2);
    setmatchdata("objectives", var_3, "is_hardcore", 1);
    setmatchdata("objectives", var_3, "start_time_ms", var_4);
    setmatchdata("objectives", var_3, "step", var_0);
  }

  level.zombiehcanalyticcounters[var_0] = var_3;
}

_id_4BC9(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(var_3)) {
    if(!isDefined(var_1))
      var_1 = var_0;

    if(!isDefined(var_2))
      var_2 = "ZOMBIES_EMPTY_STRING";
  } else
    common_scripts\utility::flag_init(var_0);

  if(isDefined(var_1))
    level thread hc_analytics_register_match_data(var_0, var_1, var_2);

  thread hc_analytics_watch_autocompletion(var_0);
  thread _id_4BCB(var_0);
}

hc_analytics_watch_autocompletion(var_0) {
  level endon(get_hc_analytics_reported_notify(var_0));
  common_scripts\utility::_id_3C9F(var_0);
  _id_4BCA(var_0, 1);
}

get_hc_analytics_reported_notify(var_0) {
  return "analytics reported for " + var_0;
}

quest_omnvar_init() {
  var_0 = self;
  var_1 = int(1.95652) + 1;
  var_0.questprogressbitfield = [];

  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0.questprogressbitfield[var_2] = 0;

  var_0 _id_23DB("ui_zm_has_quest_item_bits_", 46);
}

quest_omnvar_mark_completed(var_0, var_1) {
  var_2 = self;
  var_3 = int(var_0 / 23);
  var_4 = var_0 - var_3 * 23;

  if(var_1)
    var_2.questprogressbitfield[var_3] = var_2.questprogressbitfield[var_3] | 1 << var_4;
  else
    var_2.questprogressbitfield[var_3] = var_2.questprogressbitfield[var_3] &~(1 << var_4);

  var_5 = "ui_zm_has_quest_item_bits_" + var_3;
  self _meth_82FF(var_5, var_2.questprogressbitfield[var_3]);
}

quest_omnvar_handle_player_respawn() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("spawned_player");

    for(var_1 = 0; var_1 < var_0.questprogressbitfield.size; var_1++) {
      var_2 = "ui_zm_has_quest_item_bits_" + var_1;
      var_0 _meth_82FF(var_2, var_0.questprogressbitfield[var_1]);
    }
  }
}

_id_23DB(var_0, var_1) {
  var_2 = int((var_1 - 1) / 23) + 1;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_0 + var_3;
    self _meth_82FF(var_4, 0);
  }
}

_id_8650(var_0, var_1, var_2) {
  var_3 = int(var_1 / 23);
  var_4 = var_1 - var_3 * 23;
  var_5 = var_0 + var_3;
  var_6 = self _meth_844A(var_5);

  if(var_2)
    var_6 = var_6 | 1 << var_4;
  else
    var_6 = var_6 &~(1 << var_4);

  self _meth_82FF(var_5, var_6);
}

manage_mtx5_event() {
  level endon("game_ended");

  if(!getdvarint("spv_zmb_event_mtx5_active", 0)) {
    return;
  }
  level thread maps\mp\_utility::_id_6F74(::giveplayereventbuff);
}

giveplayereventbuff() {
  var_0 = self;
  var_0 waittill("zombie_player_spawn_finished");
  var_0 endon("disconnect");
  var_1 = ["blunderbuss_zm"];
  var_2 = _id_0548::_id_454B(var_0, _id_0547::_id_AAF9(common_scripts\utility::random(var_1)));
  _id_0548::_id_A7D6(var_0, var_2);
  _id_0533::_id_0F37(2, 1, 0);
}