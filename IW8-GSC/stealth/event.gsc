/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\event.gsc
***********************************************/

event_init_entity() {
  thread event_listener_thread();
  event_entity_core_set_enabled(1);
}

event_entity_core_set_enabled(var_0) {
  if(!isDefined(level.stealth.core_events))
    level.stealth.core_events = ["_encstr_A5490D5E05C3F8B363F3C8D83B3E43", "_encstr_860808CB78E2984063BA", "_encstr_8C8E09632740B3834849C2", "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C", "_encstr_AA140ECCF6BD3A9BA35983D7BB1663DA", "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA", "_encstr_92FD082A30066B713094", "_encstr_928E112F37025EA89FEB168B577948992A9B93", "_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D", "_encstr_AA300EBF415D43B0F85A6159731058AB", "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001"];

  if(var_0) {
    foreach(var_2 in level.stealth.core_events)
    self addaieventlistener(var_2);
  } else {
    foreach(var_2 in level.stealth.core_events)
    self removeaieventlistener(var_2);
  }
}

event_init_level() {
  if(!isDefined(level.stealth.event_priority))
    level.stealth.event_priority = [];

  level.stealth.event_priority["_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2"] = 0;
  level.stealth.event_priority["_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9"] = 1;
  level.stealth.event_priority["_encstr_AA7C07466F9DA30713"] = 2;
  level scripts\stealth\utility::set_stealth_func("_encstr_8C6C0A96607FFB09E977B6B5", ::event_broadcast_generic);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_8C8E09632740B3834849C2", 15, 0.07);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C", 10, 0.1);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_AA140ECCF6BD3A9BA35983D7BB1663DA", 20, 0.05);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_8ECE1603386D65B748BF059EDC15C90F01409FF07BC71495", 20, 0.05);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_AC360CDD2DDC91F677F57B1C59DC", 0, 0.2);
  event_severity_set("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", "_encstr_9B0115477948C121E82BF3B39F7858D36C1B38097EE9CB", 0, 0.1);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_B84F06CBD04CA31B", 2, 0.45);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_AB180B9B2B50397F40B3033BB9", 0, 0.3);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_A59A0DF1E5353075B9DF8785AB43CD", 0, 0.3);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_928E112F37025EA89FEB168B577948992A9B93", 10, 0.1);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_AA300EBF415D43B0F85A6159731058AB", 5, 0.23);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_92FD082A30066B713094", 3, 0.4);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_860808CB78E2984063BA", 2, 0.8);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_AB130CB9AC56DA7D31C2C6B5D507", 0, 0.0);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA", 0, 0.9);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001", 2, 0.5);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_93380D1B2D3B43A3BEB59636C65919", 3, 0.4);
  event_severity_set("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", "_encstr_A5490D5E05C3F8B363F3C8D83B3E43", 3, 0.4);
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D");
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_999A07C61338F9A23A");
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_B2BE0788BAF573592F");
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_83650AB19BA26B100D3CE35A");
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_932A0D49F9D229A6CA936BFE4F60F3");
  event_severity_set("_encstr_AA7C07466F9DA30713", "_encstr_B81D0CB08D63977DB65AB18D5932");
}

event_severity_compare(var_0, var_1) {
  var_2 = level.stealth.event_priority[var_0] - level.stealth.event_priority[var_1];
  return var_2;
}

event_severity_shift(var_0, var_1) {
  var_2 = level.stealth.event_priority[var_0] + var_1;

  foreach(var_5, var_4 in level.stealth.event_priority) {
    if(var_4 == var_2)
      return var_5;
  }

  return var_0;
}

event_severity_set(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0.0;

  if(!isDefined(level.stealth.event_severity))
    level.stealth.event_severity = [];

  if(!isDefined(level.stealth.event_escalation))
    level.stealth.event_escalation = [];

  if(!isDefined(level.stealth.event_escalation_scalars))
    level.stealth.event_escalation_scalars = [];

  if(!isDefined(level.stealth.event_escalation_to_combat))
    level.stealth.event_escalation_to_combat = [];

  level.stealth.event_severity[var_1] = var_0;
  level.stealth.event_escalation[var_1] = var_2;
  level.stealth.event_escalation_scalars[var_1] = var_3;
  level.stealth.event_escalation_to_combat[var_1] = var_4;
}

event_severity_get(var_0) {
  return level.stealth.event_severity[var_0];
}

event_escalation_get(var_0) {
  return level.stealth.event_escalation[var_0];
}

event_escalation_scalar_get(var_0) {
  return level.stealth.event_escalation_scalars[var_0];
}

event_escalation_to_combat_get(var_0) {
  return level.stealth.event_escalation_to_combat[var_0];
}

event_escalation_clear() {
  self.stealth.event_escalation_count = undefined;
  self.stealth.event_escalation_scalar = 0.0;
}

event_listener_thread() {
  self notify("_encstr_8DD516A52DE85D1B60584AD36345BB5788974C20BD402603");
  self endon("_encstr_8DD516A52DE85D1B60584AD36345BB5788974C20BD402603");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    scripts\engine\utility::ent_flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    self waittill("_encstr_B4580A0740984DFBF2C57BEB", var_0);

    if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    if(self.ignoreall || self isragdoll()) {
      continue;
    }
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.entity)) {
        continue;
      }
      if(issentient(var_2.entity) && (var_2.entity.ignoreme || var_2.entity.notarget)) {
        continue;
      }
      if(isDefined(var_2.entity.ownervehicle)) {
        if(var_2.entity.ownervehicle.vehicletype == "_encstr_9AD20DFB279B37934BE0894328B34A")
          continue;
      }

      var_2.typeorig = var_2.type;
      var_2.receiver = self;
      var_3 = event_severity_get(var_2.type);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_3)) {
        if(!isDefined(self.disableescalation) && var_3 != "_encstr_AA7C07466F9DA30713") {
          var_4 = event_escalation_get(var_2.type);
          var_5 = event_escalation_scalar_get(var_2.type);
          var_6 = event_escalation_to_combat_get(var_2.type);

          if(var_4 > 0) {
            if(!isDefined(self.stealth.event_escalation_count))
              self.stealth.event_escalation_count = [];

            if(!isDefined(self.stealth.event_escalation_count[var_2.type]))
              self.stealth.event_escalation_count[var_2.type] = 0;

            if(isDefined(var_6) && self.stealth.event_escalation_count[var_2.type] + 1 >= var_6)
              var_3 = event_severity_shift(var_3, 2);
            else if(self.stealth.event_escalation_count[var_2.type] + 1 >= var_4)
              var_3 = event_severity_shift(var_3, 1);
            else if(self.stealth.event_escalation_scalar + var_5 >= 1.0)
              var_3 = event_severity_shift(var_3, 1);
          }
        }

        var_2.type = var_3;
      }

      var_7 = scripts\stealth\callbacks::stealth_call_thread(var_2.type, var_2);

      if(istrue(var_7) && isDefined(var_4) && var_2.type != "_encstr_AA7C07466F9DA30713") {
        if(var_4 > 0)
          self.stealth.event_escalation_count[var_2.typeorig]++;

        self.stealth.event_escalation_scalar = self.stealth.event_escalation_scalar + var_5;
      }
    }
  }
}

entity_is_approved(var_0) {
  switch (var_0.classname) {
    case "_encstr_A5B51BFBDEDD13E15347209DB31FE968EAC172298707E02A40B255116B":
      return 1;
    default:
      return 0;
  }
}

event_broadcast_axis(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");
  var_6 = squared(var_3);
  var_7 = squared(var_4);
  var_8 = self.team;

  if(!isDefined(var_8))
    var_8 = self.agentteam;

  foreach(var_10 in var_5) {
    if(!isalive(var_10)) {
      continue;
    }
    if(var_10 == self) {
      continue;
    }
    if(var_10.team != var_8) {
      continue;
    }
    if(!isDefined(var_10.stealth)) {
      continue;
    }
    var_11 = 0;
    var_12 = distancesquared(var_10.origin, self.origin);

    if(var_12 <= var_6)
      var_11 = self hastacvis(var_10);

    if(!var_11 && var_12 <= var_7) {
      if(var_10 scripts\stealth\utility::is_visible(self) || var_10 scripts\stealth\utility::is_visible(var_2))
        var_11 = 1;
    }

    if(var_10[[var_10.fnisinstealthcombat]]()) {
      if(var_11)
        var_10 getenemyinfo(var_2);

      continue;
    }

    if(var_11) {
      if(var_10 lastknowntime(var_2) == 0)
        var_10 aieventlistenerevent(var_0, var_2, self.origin);
      else
        var_10 aieventlistenerevent(var_0, var_2, var_2.origin);

      continue;
    }

    if(var_10 canseeperipheral(self))
      var_10 aieventlistenerevent(var_1, var_2, self.origin);
  }
}

event_broadcast_generic(var_0, var_1, var_2, var_3) {
  var_4 = getaiunittypearray("_encstr_A549095E11E39EB7231310");

  if(!isDefined(var_3))
    var_3 = level.player;

  var_5 = squared(var_2);

  foreach(var_7 in var_4) {
    if(!isalive(var_7)) {
      continue;
    }
    if(!isDefined(var_7.stealth)) {
      continue;
    }
    if(distancesquared(var_7.origin, var_1) <= var_5)
      var_7 aieventlistenerevent(var_0, var_3, var_1);
  }
}

event_broadcast_axis_by_tacsight(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4))
    var_4 = 1;

  var_9 = undefined;

  if(isDefined(var_6))
    var_9 = var_6 * var_6;

  if(!isDefined(var_5))
    var_5 = var_2;

  foreach(var_11 in var_7) {
    if(!isalive(var_11)) {
      continue;
    }
    if(!isDefined(var_11.stealth)) {
      continue;
    }
    var_12 = distancesquared(var_11.origin, var_2);

    if(var_12 > var_8) {
      continue;
    }
    var_13 = var_4;

    if(var_4 && isDefined(var_9) && var_12 <= var_9)
      var_13 = 0;

    if(!var_11 hastacvis(var_5, var_13)) {
      continue;
    }
    var_11 aieventlistenerevent(var_0, var_1, var_2);
  }
}

event_broadcast_axis_by_sight(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread event_broadcast_axis_by_sight_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

event_broadcast_axis_by_sight_thread(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");
  var_8 = var_3 * var_3;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = var_2;

  var_9 = 3;
  var_10 = 0;

  foreach(var_12 in var_7) {
    if(!isalive(var_12)) {
      continue;
    }
    if(!isDefined(var_12.stealth)) {
      continue;
    }
    var_13 = distancesquared(var_12.origin, var_2);

    if(var_13 > var_8) {
      continue;
    }
    if(isDefined(var_6) && var_13 <= var_6 * var_6) {
      var_12 aieventlistenerevent(var_0, var_1, var_2);
      continue;
    }

    if(!var_12 hastacvis(var_5, var_4)) {
      if(var_4 && !var_12 aipointinfov(var_2)) {
        continue;
      }
      var_10++;

      if(var_10 > var_9) {
        waitframe();
        var_10 = 0;
      }

      if(!sighttracepassed(var_12 getEye(), var_2, 0, var_1))
        continue;
    }

    var_12 aieventlistenerevent(var_0, var_1, var_2);
  }
}