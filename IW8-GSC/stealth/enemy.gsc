/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\enemy.gsc
***********************************************/

main() {
  init_settings();
  init_flags();
  scripts\stealth\group::addtogroup(self.script_stealthgroup, self);
  setpatrolstyle_base();
  scripts\stealth\event::event_init_entity();
  thread monitor_damage_thread(level.stealth.damage_auto_range, level.stealth.damage_sight_range);
  set_alert_level("_encstr_88F20627959BCAE8");
  bt_set_stealth_state("_encstr_A7C5056BD931D1");
  stealth_init_goal_radius();

  if(isDefined(level.stealth.fninitenemygame))
    self thread[[level.stealth.fninitenemygame]]();
}

init_flags() {
  scripts\engine\utility::ent_flag_init("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::ent_flag_init("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
  scripts\engine\utility::ent_flag_init("_encstr_994C161B88E37E9393234F6048787B0931B883323053B5E3");
  scripts\engine\utility::ent_flag_init("_encstr_8F910FDCA32BB0D81D34AFB08ED1856CD6");
  scripts\engine\utility::ent_flag_init("_encstr_99451420EB6B9139B0E877273010BFF2013548B00F12");
  scripts\engine\utility::ent_flag_init("_encstr_93C3216A8D73AAAC4B88AF6B988199C2AFABB5A3FD8733E171B81B4780D86FBAB5B1F8");
  scripts\engine\utility::ent_flag_init("_encstr_A6192688E38188E001F8DF25F4C7DAF909FF2FDD9553C90B3BF088ABF46379E91F4837196872964B");
  scripts\engine\utility::ent_flag_init("_encstr_81F31AAF416FE91B1BD480D6C7551172ACB2C250503F3712D8D8F954");
  scripts\stealth\utility::group_flag_init("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  scripts\stealth\utility::group_flag_init("_encstr_99451420EB6B9139B0E877273010BFF2013548B00F12");
  scripts\stealth\utility::group_flag_init("_encstr_832817682395C131A3C4787E1D6A7589ECF738C0E33C18FD7A");
  scripts\stealth\utility::group_flag_init("_encstr_A6192688E38188E001F8DF25F4C7DAF909FF2FDD9553C90B3BF088ABF46379E91F4837196872964B");
}

stealth_init_goal_radius() {
  if(isDefined(self.script_radius)) {
    self.goalradius = self.script_radius;
    return;
  }

  if(!isDefined(self getgoalvolume()))
    self.goalradius = level.default_goalradius;
}

init_settings() {
  self.stealth = spawnStruct();
  self.stealth.funcs = [];
  self.stealth.max_warnings = 2;
  self.stealth.reachedinvestigate = 0;
  self.newenemyreactiondistsq = squared(level.stealth.ai_event["_encstr_8AE11B8940CF772508B50461239F13C0506781867B72200EF2E290C888"]["_encstr_95DF070DD22319CA9B"]);
  scripts\stealth\corpse::corpse_init_entity();
  self.stealth.event_escalation_scalar = 0.0;

  if(!isDefined(level.stealth.damage_auto_range))
    level.stealth.damage_auto_range = 175;

  if(!isDefined(level.stealth.damage_sight_range))
    level.stealth.damage_sight_range = 600;

  self.grenadeawareness = 0.0;
  self.canacquirenearbytacvisenemies = 0;
  self.stealth.bsmstate = -1;
}

death_cleanup() {
  if(isDefined(self))
    scripts\stealth\threat_sight::threat_sight_set_state("_encstr_AD75063D571AE108");
  else {
    foreach(var_1 in level.players) {
      foreach(var_4, var_3 in var_1.stealth.threat_entities) {
        if(!isDefined(var_3))
          var_1.stealth.threat_entities[var_4] = undefined;
      }

      foreach(var_4, var_3 in var_1.stealth.threat_sighted) {
        if(!isDefined(var_3))
          var_1.stealth.threat_sighted[var_4] = undefined;
      }
    }
  }

  if(isDefined(self.stealth_vo_ent))
    self.stealth_vo_ent thread death_vo_cleanup();
}

death_vo_cleanup() {
  self stopsounds();
  waitframe();
  self delete();
}

add_active_sense_function(var_0) {
  if(!isDefined(self.stealth.active_sense_funcs))
    self.stealth.active_sense_funcs = [];

  self.stealth.active_sense_funcs[self.stealth.active_sense_funcs.size] = var_0;
}

proximity_check() {
  if(self.ignoreall) {
    return;
  }
  if(!isDefined(level.stealth)) {
    return;
  }
  var_0 = self getapproxeyepos();
  var_1 = (self.origin + var_0) / 2;
  var_2 = (0, 0, 35);

  if(isDefined(self.proximity_bump_dist_sqr_override))
    var_3 = self.proximity_bump_dist_sqr_override;
  else
    var_3 = 1764;

  var_4 = 11025;
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in level.players) {
    var_9 = 0;
    var_10 = 0;

    if(!isalive(var_8)) {
      continue;
    }
    if(issentient(var_8) && (var_8.ignoreme || var_8.notarget)) {
      continue;
    }
    var_11 = distancesquared(var_1, var_8.origin + var_2);

    if(distance2dsquared(self.origin, var_8.origin) < var_3) {
      var_12 = self.origin[2] - var_8.origin[2];

      if(var_12 * var_12 < 5184) {
        var_10 = 1;
        var_9 = 1;
      }
    }

    if(!var_9 && isDefined(level.stealth.proximity_combat_radius_fake_sight) && level.stealth.proximity_combat_radius_fake_sight > 0) {
      if(var_11 < level.stealth.proximity_combat_radius_fake_sight * level.stealth.proximity_combat_radius_fake_sight) {
        if(!isDefined(self.stealth.blind)) {
          var_13 = var_8.origin - self.origin;
          var_13 = (var_13[0], var_13[1], 0);
          var_14 = anglesToForward((0, self.angles[1], 0));

          if(vectordot(var_14, var_13) > 0) {
            var_10 = 1;
            var_9 = 1;
          }
        }
      }
    }

    if(!var_9 && isDefined(level.stealth.proximity_combat_radius_bump) && level.stealth.proximity_combat_radius_bump > 0) {
      if(var_11 < level.stealth.proximity_combat_radius_bump * level.stealth.proximity_combat_radius_bump) {
        var_15 = length2dsquared(var_8 getvelocity());

        if(var_15 > var_4) {
          var_10 = 1;
          var_9 = 1;
        }
      }
    }

    if(!var_9 && isDefined(level.stealth.proximity_combat_radius_sight) && level.stealth.proximity_combat_radius_sight > 0) {
      if(var_11 < level.stealth.proximity_combat_radius_sight * level.stealth.proximity_combat_radius_sight) {
        if(self cansee(var_8, 0))
          var_9 = 1;
      }
    }

    if(var_9 && var_10)
      var_9 = scripts\engine\trace::ray_trace_passed(self getapproxeyepos(), var_8 getEye(), [self, var_8]);

    if(var_9) {
      self aieventlistenerevent("_encstr_83650AB19BA26B100D3CE35A", var_8, var_8.origin);
      scripts\engine\utility::delaycall(0.05, ::getenemyinfo, var_8);
      return;
    }
  }
}

set_blind(var_0, var_1) {
  if(!isDefined(self.stealth)) {
    return;
  }
  if(!var_0 && !isDefined(self.stealth.blind)) {
    return;
  }
  var_2 = isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]();
  var_3 = isDefined(self.fnisinstealthhunt) && self[[self.fnisinstealthhunt]]();
  var_4 = var_2 || var_3;

  if(var_0 && (!var_4 || istrue(var_1))) {
    self.stealth.blind = 1;
    set_sight_state("_encstr_82AB06C6D0103612");
  } else {
    self.stealth.blind = undefined;

    if(var_4)
      set_sight_state("_encstr_8ADA089BC1B78EE8B246");
    else
      set_sight_state("_encstr_95DF070DD22319CA9B");
  }
}

set_sight_state(var_0) {
  switch (var_0) {
    case "_encstr_82AB06C6D0103612":
      scripts\stealth\threat_sight::threat_sight_set_state("_encstr_82AB06C6D0103612");
      self.fovcosine = 0.98;
      self.fovcosinebusy = 0.98;
      self.fovcosinez = 0;
      self.fovground = 0;
      self.fovcosineperiph = 0.99;
      self.fovcosineperiphmaxdistsq = 1;
      break;
    case "_encstr_97C8081B2DD9BB0FE35F":
    case "_encstr_95DF070DD22319CA9B":
    case "_encstr_A7C5056BD931D1":
      scripts\stealth\threat_sight::threat_sight_set_state("_encstr_95DF070DD22319CA9B");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      scripts\stealth\threat_sight::threat_sight_set_state("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "_encstr_8B9A0CD8F65B98581DBE86AE738E":
    case "_encstr_9ACC05B4156DF3":
      scripts\stealth\threat_sight::threat_sight_set_state("_encstr_8B9A0CD8F65B98581DBE86AE738E");
      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 90000;
      break;
    case "_encstr_8ADA089BC1B78EE8B246":
    case "_encstr_AA7C07466F9DA30713":
      scripts\stealth\threat_sight::threat_sight_set_state("_encstr_8ADA089BC1B78EE8B246");
      self.fovcosine = 0.01;
      self.fovcosinebusy = 0.574;
      self.fovcosinez = 0;
      self.fovground = 0;
      self.fovcosineperiph = 0.01;
      self.fovcosineperiphmaxdistsq = 16384;
      break;
    case "_encstr_844113531177F3A8D89877BC1369E19AC0A9D78BE7":
      break;
    case "_encstr_B1330AC370DBFDA8EF48AB08":
      break;
    case "_encstr_A71709C730F92E4A89D577":
      break;
  }
}

alertlevel_normal(var_0) {
  thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_BE3E0AF35EB5509D9B2AB9AB", "_encstr_BA560BB0B1594EA34E59CD5647");
  set_alert_level("_encstr_88F20627959BCAE8");
  bt_set_stealth_state("_encstr_A7C5056BD931D1");
  scripts\stealth\utility::goto_last_goal();
}

set_alert_level(var_0) {
  if(!scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
    return;
  }
  if(isDefined(self.alertlevelscript) && self.alertlevelscript == var_0) {
    return;
  }
  self notify("_encstr_A52F1033B02371114165BBC366CBB7ECB3E8");
  self endon("_encstr_A52F1033B02371114165BBC366CBB7ECB3E8");
  self endon("_encstr_AD75063D571AE108");
  self.alertlevelscript = var_0;

  while(isDefined(self.syncedmeleetarget))
    wait 0.05;

  scripts\stealth\utility::set_stealth_state(var_0);
  self notify("_encstr_81051A6E1DCAB01BA3A1D72C8DB2C93A1B569D561B7D36D058B9CEAC", var_0);
  self.alertlevel = scripts\stealth\utility::alertlevel_script_to_exe(var_0);
  var_1 = self.alertlevelint > 2;
  scripts\stealth\event::event_entity_core_set_enabled(!var_1);
  self.ignoreexplosionevents = !var_1;
}

set_default_stealth_funcs() {
  level scripts\stealth\utility::set_stealth_func("_encstr_8A08105942CF95D071CE4759EDA9C8D7FF0B", ::go_to_node_wait);
  level scripts\stealth\utility::set_stealth_func("_encstr_AF4012A437C790A8B7757830ABAF178A23D24BD0", ::go_to_node_arrived);
  level scripts\stealth\utility::set_stealth_func("_encstr_B4451547E5C7C10FC11647B19B196F68931B803FF287E5", ::go_to_node_post_wait);
  level scripts\stealth\utility::set_stealth_func("_encstr_88F20627959BCAE8", ::alertlevel_normal);
  level scripts\stealth\utility::set_stealth_func("_encstr_966911B3879419DFFA231DDFBBE1A688415DF9", scripts\stealth\utility::set_patrol_style);
  level scripts\stealth\utility::set_stealth_func("_encstr_A9E414C318213FF71B489FD61FA3D9C34F33212704FD", ::trigger_cover_blown);
  level scripts\stealth\utility::set_stealth_func("_encstr_AD020AE62BA37D4C8D5A9B32", ::set_blind);
  level scripts\stealth\utility::set_stealth_func("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", ::bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9", ::bt_event_handler_severity);
  level scripts\stealth\utility::set_stealth_func("_encstr_AA7C07466F9DA30713", ::bt_event_handler_severity);
}

monitor_damage_thread(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill("_encstr_B2BE0788BAF573592F", var_4, var_5, var_6, var_7);
    check_kill_damage(var_4, var_5, var_7);
    var_8 = self.origin;

    if(isalive(self) && !scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
      continue;
    }
    if(isalive(var_5))
      var_2 = var_5;

    if(!isDefined(var_2)) {
      continue;
    }
    self aieventlistenerevent("_encstr_B2BE0788BAF573592F", var_2, var_2.origin);

    if(isPlayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }

    if(isDefined(var_2.classname) && var_2.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
      if(var_2.isbarrel) {
        break;
      }
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.stealth.override_damage_auto_range))
    var_0 = self.stealth.override_damage_auto_range;
  else if(isDefined(level.stealth.override_damage_auto_range))
    var_0 = level.stealth.override_damage_auto_range;

  if(isDefined(self.stealth.override_damage_sight_range))
    var_1 = self.stealth.override_damage_sight_range;
  else if(isDefined(level.stealth.override_damage_sight_range))
    var_1 = level.stealth.override_damage_sight_range;

  if(isalive(self))
    scripts\stealth\event::event_broadcast_axis("_encstr_932A0D49F9D229A6CA936BFE4F60F3", "_encstr_9B0115477948C121E82BF3B39F7858D36C1B38097EE9CB", var_2, var_0, var_1);
  else
    scripts\stealth\event::event_broadcast_axis("_encstr_B81D0CB08D63977DB65AB18D5932", "_encstr_9B0115477948C121E82BF3B39F7858D36C1B38097EE9CB", var_2, var_0, var_1);
}

check_kill_damage(var_0, var_1, var_2) {
  if(isDefined(self.disableeasystealthheadshot)) {
    return;
  }
  if(var_0 > 0 && self.damagemod != "_encstr_8DED0A21C79B660BC7588981" && self.alertlevelscript != "_encstr_999A07C61338F9A23A" && self.alertlevelscript != "_encstr_AA7C07466F9DA30713") {
    var_3 = self getEye();

    if(distancesquared(var_2, var_3) < squared(level.stealth.head_shot_dist))
      self dodamage(self.health, var_2, var_1, var_1, "_encstr_87280E1FB705D168313D1FD197B1A799");
  }
}

shotisreasonablysafe(var_0) {
  var_1 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");
  var_2 = [];
  var_3 = squared(level.stealth.damage_auto_range);
  var_4 = squared(level.stealth.damage_sight_range);

  foreach(var_6 in var_1) {
    if(var_6 == var_0) {
      continue;
    }
    var_7 = distancesquared(var_0.origin, var_6.origin);

    if(var_7 < var_3)
      return 0;

    if(var_7 < var_4) {
      if(var_6 getthreatsight(self) > 0)
        return 0;

      if(var_6 scripts\engine\math::point_in_fov(var_0.origin, 0) && var_6 hastacvis(var_0))
        return 0;

      var_2[var_2.size] = var_6;
    }
  }

  foreach(var_6 in var_2) {
    if(var_6 cansee(var_0))
      return 0;
  }

  return 1;
}

shotisbadidea(var_0) {
  var_1 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");
  var_2 = [];
  var_3 = squared(level.stealth.damage_auto_range);
  var_4 = squared(level.stealth.damage_sight_range);

  foreach(var_6 in var_1) {
    if(var_6 == var_0) {
      continue;
    }
    var_7 = distancesquared(var_0.origin, var_6.origin);

    if(var_7 < var_3)
      return 1;

    if(var_7 < var_4) {
      if(var_6 getthreatsight(self) > 0)
        return 1;

      if(var_6 scripts\engine\math::point_in_fov(var_0.origin, 0)) {
        if(var_6 hastacvis(var_0))
          return 1;

        var_2[var_2.size] = var_6;
      }
    }
  }

  foreach(var_6 in var_2) {
    if(var_6 cansee(var_0))
      return 1;
  }

  return 0;
}

headtrack_player_toggle(var_0) {
  if(var_0) {
    if(!isDefined(self.stealth.allowplayerheadtracking))
      self.stealth.allowplayerheadtracking = 1;
    else if(!self.stealth.allowplayerheadtracking) {
      return;
    }
    if(!isDefined(self.stealth.looking_at_entity))
      self.stealth.looking_at_entity = level.player;

    scripts\common\utility::lookatentity(level.player);
  } else if(isDefined(self.stealth.looking_at_entity)) {
    self.stealth.looking_at_entity = undefined;
    scripts\common\utility::lookatentity();
  }
}

lock_player_headtracking_off(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_85A11601ED02E7C640B71030DB72D92F6A94881C497AB5A9");
  self endon("_encstr_85A11601ED02E7C640B71030DB72D92F6A94881C497AB5A9");
  disable_player_headtracking();
  wait(var_0);
  enable_player_headtracking();
}

disable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 0;
  headtrack_player_toggle(0);
}

enable_player_headtracking() {
  self.stealth.allowplayerheadtracking = 1;
}

event_handler_should_ignore(var_0) {
  var_1 = self.stealth.event_severity_min;

  if(!isDefined(var_1))
    var_1 = level.stealth.event_severity_min;

  if(isDefined(var_1)) {
    var_2 = scripts\stealth\event::event_severity_compare(var_1, var_0.type);

    if(var_2 > 0)
      return 1;
  }

  if(istrue(level.stealth.disguised) && event_override_disguise(var_0))
    return 1;

  if(var_0.typeorig == "_encstr_860808CB78E2984063BA") {
    if(isDefined(var_0.entity) && isDefined(var_0.entity.team) && var_0.entity.team == self.team)
      return 1;
  }

  if(var_0.typeorig == "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C") {
    if(should_ignore_sprint_footstep(var_0))
      return 1;
  }

  if(var_0.typeorig == "_encstr_AA300EBF415D43B0F85A6159731058AB") {
    if(isPlayer(var_0.entity) && distancesquared(var_0.entity getEye(), var_0.origin) > 1296)
      return 1;
  }

  if(var_0.typeorig == "_encstr_92FD082A30066B713094" || var_0.typeorig == "_encstr_928E112F37025EA89FEB168B577948992A9B93" || var_0.typeorig == "_encstr_A5490D5E05C3F8B363F3C8D83B3E43") {
    if(isai(var_0.entity) && var_0.entity isinscriptedstate())
      return 1;
  }

  if(istrue(scripts\stealth\callbacks::stealth_call("_encstr_976914ED16F7A881B94338F8DB8D69461FAFE0508A9F", var_0)))
    return 1;

  var_3 = scripts\stealth\callbacks::stealth_get_func("_encstr_BACE07D36E4F603577" + var_0.type);

  if(isDefined(var_3))
    return scripts\stealth\callbacks::stealth_call("_encstr_BACE07D36E4F603577" + var_0.type, var_0);

  return 0;
}

should_ignore_sprint_footstep(var_0) {
  var_1 = (0, 0, 18);
  var_2 = level.stealth.cantracetoaiignoreents;

  if(isDefined(self.stealth.cantracetoaiignoreents))
    var_2 = scripts\engine\utility::array_combine(var_2, self.stealth.cantracetoaiignoreents);

  if(isPlayer(var_0.entity) && scripts\engine\utility::can_trace_to_ai(var_0.origin + var_1, self, var_2)) {
    var_3 = distancesquared(self.origin, var_0.origin);
    var_4 = 250;

    if(isDefined(self.sprintfootstepradius))
      var_4 = self.sprintfootstepradius;

    if(var_3 < var_4 * var_4)
      return 0;

    var_5 = self cansee(var_0.entity);

    if(!var_5 && var_0.entity scripts\stealth\threat_sight::player_is_sprinting_at_me(self))
      return 0;
  }

  return 1;
}

event_override_disguise(var_0) {
  if(issentient(var_0.entity)) {
    switch (var_0.typeorig) {
      case "_encstr_AA140ECCF6BD3A9BA35983D7BB1663DA":
      case "_encstr_8C8E09632740B3834849C2":
      case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
      case "_encstr_83650AB19BA26B100D3CE35A":
        thread scripts\stealth\threat_sight::threat_sight_force_visible(var_0.entity, 1.0);
        return 1;
    }
  }

  return 0;
}

event_override_controlling_robot(var_0) {
  if(issentient(var_0.entity)) {
    switch (var_0.typeorig) {
      case "_encstr_83650AB19BA26B100D3CE35A":
        return 1;
      case "_encstr_AA300EBF415D43B0F85A6159731058AB":
      case "_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D":
      case "_encstr_92FD082A30066B713094":
      case "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA":
      case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
      case "_encstr_860808CB78E2984063BA":
        var_0.type = "_encstr_AA7C07466F9DA30713";
        return 0;
    }
  }

  if(var_0.type != "_encstr_AA7C07466F9DA30713")
    return 1;

  return 0;
}

event_anyone_within_radius(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = getaiunittypearray("_encstr_A549095E11E39EB7231310", "_encstr_AF1904A7F929");

  foreach(var_5 in var_3) {
    if(distancesquared(var_0, var_5.origin) <= var_2)
      return 1;
  }

  return 0;
}

event_handler_translate_severity(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.typeorig)) {
    return;
  }
  if(self[[self.fnisinstealthhunt]]()) {
    if(var_0.type == "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2")
      var_0.type = "_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9";
  }

  switch (var_0.typeorig) {
    case "_encstr_B84F06CBD04CA31B":
      if(self.subclass == "_encstr_AA180446F6EC")
        var_0.type = "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2";
      else if(isDefined(self.stealth.threat_sight_lost)) {
        var_1 = undefined;

        if(isDefined(var_0.entity) && issentient(var_0.entity))
          var_1 = var_0.entity getentitynumber();

        if(isDefined(var_1) && isDefined(self.stealth.threat_sight_lost[var_1]) && self.stealth.threat_sight_lost[var_1] == 0) {
          var_2 = var_0.entity;

          if(isPlayer(var_0.entity)) {
            var_3 = var_0.entity scripts\stealth\utility::quickdropnewitem();

            if(isDefined(var_3) && !self cansee(var_0.entity))
              var_2 = var_3;
          }

          self getenemyinfo(var_2);
          var_0.type = "_encstr_AA7C07466F9DA30713";
        }
      }

      break;
    case "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA":
      if(event_anyone_within_radius(var_0.origin, 128))
        var_0.type = "_encstr_AA7C07466F9DA30713";

      break;
    case "_encstr_860808CB78E2984063BA":
      if(event_anyone_within_radius(var_0.origin, 192))
        var_0.type = "_encstr_AA7C07466F9DA30713";
      else if(distancesquared(var_0.origin, self.origin) <= 1048576)
        var_0.type = "_encstr_AA7C07466F9DA30713";

      break;
    case "_encstr_92FD082A30066B713094":
      if(distancesquared(var_0.origin, self.origin) < 640000)
        var_0.type = "_encstr_AA7C07466F9DA30713";

      break;
    case "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001":
      if(self hastacvis(var_0.origin, 0) && distance2dsquared(var_0.origin, self.origin) < 36864)
        var_0.type = "_encstr_AA7C07466F9DA30713";

      break;
  }
}

trigger_cover_blown(var_0, var_1) {
  if(!isDefined(self.stealth)) {
    return;
  }
  self.stealth.bcoverhasbeenblown = 1;
  self.stealth.bdocoverblownreaction = var_1;
}

react_announce(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_1 = randomfloatrange(0.5, 1.1);

  switch (var_0.type) {
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_BE3E0AF35EB5509D9B2AB9AB", "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", var_1);
      return 1;
    case "_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9":
      thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_BE3E0AF35EB5509D9B2AB9AB", "_encstr_82110B2AE8581B0B42C5D8CFB8", var_1);
      return 1;
    case "_encstr_AA7C07466F9DA30713":
      thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_AA7C07466F9DA30713", 1);
      return 1;
  }

  return 0;
}

react_announce_specific(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(var_0.typeorig)) {
    var_1 = randomfloatrange(0.5, 1.0);

    switch (var_0.typeorig) {
      case "_encstr_B84F06CBD04CA31B":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_B84F06CBD04CA31B", var_1);
        return 1;
      case "_encstr_860808CB78E2984063BA":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_8E440A950FE01BB76E96BDE6", var_1);
        return 1;
      case "_encstr_91CE0F3102DBEA5A50B550D0737DFA5FFA":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_A52C0FB108673D1145651EC2A1C3BF659D", var_1);
        return 1;
      case "_encstr_AB130CB9AC56DA7D31C2C6B5D507":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", "_encstr_AB130CB9AC56DA7D31C2C6B5D507", randomfloatrange(2, 2.5), var_0);
        return 1;
      case "_encstr_A59A0DF1E5353075B9DF8785AB43CD":
      case "_encstr_AB180B9B2B50397F40B3033BB9":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", var_0.typeorig, var_1);
        return 1;
      case "_encstr_8ECE1603386D65B748BF059EDC15C90F01409FF07BC71495":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", "_encstr_8ECE1603386D65B748BF059EDC15C90F01409FF07BC71495");
        return 1;
      case "_encstr_A5490D5E05C3F8B363F3C8D83B3E43":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_A5490D5E05C3F8B363F3C8D83B3E43", 0.2, var_0);
        return 1;
      case "_encstr_AA300EBF415D43B0F85A6159731058AB":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_813E0A9B36CD28F5F3729173", "_encstr_AA300EBF415D43B0F85A6159731058AB", randomfloatrange(0.8, 1.3), var_0);
        return 1;
      case "_encstr_92FD082A30066B713094":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_92FD082A30066B713094", 0.2, var_0);
        return 1;
      case "_encstr_928E112F37025EA89FEB168B577948992A9B93":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_928E112F37025EA89FEB168B577948992A9B93", 0.2, var_0);
        return 1;
      case "_encstr_932A0D49F9D229A6CA936BFE4F60F3":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_92FD082A30066B713094", randomfloatrange(0.8, 1.3), var_0);
        return 1;
      case "_encstr_B81D0CB08D63977DB65AB18D5932":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_B81D0CB08D63977DB65AB18D5932", 0.5);
        return 1;
      case "_encstr_83650AB19BA26B100D3CE35A":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_873E0AB31EF510DDDB6AF96B", "_encstr_83650AB19BA26B100D3CE35A", 0.5);
        return 1;
      case "_encstr_8C8E09632740B3834849C2":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_BE3E0AF35EB5509D9B2AB9AB", "_encstr_8C8E09632740B3834849C2", var_1);
        return 1;
      case "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_BE3E0AF35EB5509D9B2AB9AB", "_encstr_91A3101DBF15687E13EABB46935BB6C8ED1C", var_1);
        return 1;
      case "_encstr_93380D1B2D3B43A3BEB59636C65919":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", "_encstr_93380D1B2D3B43A3BEB59636C65919", var_1);
        return 1;
      case "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", "_encstr_B45E1007B968BAA7C0F92AB303AE1FF09001", var_1);
        return 1;
      case "_encstr_AC360CDD2DDC91F677F57B1C59DC":
        thread scripts\stealth\utility::addeventplaybcs("_encstr_830E086EE82B0B361D86", "_encstr_923E0AB31EF510DDDB6AF9CB", "_encstr_AC360CDD2DDC91F677F57B1C59DC", var_1);
        return 1;
      case "_encstr_B2BE0788BAF573592F":
        return 1;
      default:
    }
  }

  return 0;
}

go_to_node_wait_investigate(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = !var_2;

  while(scripts\stealth\utility::stealth_behavior_active() || !var_3) {
    scripts\stealth\utility::stealth_behavior_wait();
    self[[var_0]](var_1);
    var_3 = 1;
    self waittill("_encstr_8B7205D9ED5958");
  }
}

go_to_node_wait(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self._blackboard.idlenode = undefined;
  go_to_node_wait_investigate(var_0, var_1);
}

go_to_node_post_wait(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_A521139FD0E312B0B0216379129A1EA30F878348BB");

  if(isDefined(self.stealth.idle) && isDefined(var_1.target)) {}

  if(isDefined(var_1.target))
    self._blackboard.idlenode = undefined;
}

go_to_node_arrived(var_0, var_1) {
  go_to_node_wait_investigate(var_0, var_1, 0);

  if(isDefined(var_1.script_moveplaybackrate))
    self.moveplaybackrate = var_1.script_moveplaybackrate;

  if((istrue(var_1.script_delay) || istrue(var_1.script_delay_min) || istrue(var_1.script_wait) || isDefined(var_1.script_idle) || istrue(var_1.patrol_stop) || !isDefined(var_1.target)) && isDefined(var_1.angles)) {
    self._blackboard.idlenode = var_1;

    if(!istrue(var_1.script_delay) && !istrue(var_1.script_wait))
      waitframe();
  }

  if(isDefined(var_1.script_animation)) {
    var_2 = var_1.script_animation;
    scripts\stealth\utility::animgenericcustomanimmode(self, "_encstr_8AD6086722F1FB98F58B", var_2);
  } else if(isDefined(var_1.script_idle))
    self._blackboard.idlenode = var_1;

  if(isDefined(var_1.script_animation_exit))
    scripts\stealth\utility::animgenericcustomanimmode(self, "_encstr_8AD6086722F1FB98F58B", var_1.script_animation_exit);
}

setpatrolstyle_base() {
  var_0 = scripts\stealth\utility::get_patrol_style_default();
  var_1 = isDefined(var_0) && var_0 != "_encstr_97C8081B2DD9BB0FE35F";
  var_2 = scripts\stealth\group::getgroup(self.script_stealthgroup);

  if(var_1 || isDefined(self.stealth.bcoverhasbeenblown) || isDefined(var_2.bcoverhasbeenblown)) {
    var_3 = isDefined(self.stealth.bdocoverblownreaction) && self.stealth.bdocoverblownreaction;
    var_4 = scripts\asm\asm::asm_getdemeanor() == "_encstr_96080730D8534E0A28" && var_3;
    scripts\stealth\utility::set_patrol_style("_encstr_85BB067A08A3FAB3", var_4, undefined, "_encstr_A972062F7FDAF9B0");
  } else
    scripts\stealth\utility::set_patrol_style("_encstr_97C8081B2DD9BB0FE35F");
}

bt_set_stealth_state(var_0, var_1) {
  self[[self.fnsetstealthstate]](var_0, var_1);
}

bt_event_handler_severity(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0.entity) && var_0.typeorig == "_encstr_B84F06CBD04CA31B") {
    var_2 = var_0.entity scripts\stealth\utility::quickdropnewitem();

    if(isDefined(var_2) && !self cansee(var_0.entity))
      var_1 = var_2;
  }

  var_0.investigate_pos = var_0.origin;

  if(isDefined(self.enemy) && isDefined(var_0.entity) && var_0.entity == self.enemy)
    var_0.investigate_pos = self lastknownpos(self.enemy);
  else if(isDefined(var_0.entity) && var_0.typeorig == "_encstr_A5490D5E05C3F8B363F3C8D83B3E43")
    var_0.investigate_pos = var_0.entity.origin;
  else if(isDefined(var_1))
    var_0.investigate_pos = var_1.origin;

  event_handler_translate_severity(var_0);

  if(event_handler_should_ignore(var_0))
    return 0;

  if(isDefined(var_1))
    var_0.entity = var_1;

  self.stealth.last_severity_time = gettime();

  if(!scripts\stealth\utility::bcisincombat()) {
    if(!react_announce_specific(var_0))
      react_announce(var_0);
  }

  switch (var_0.type) {
    case "_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2":
      thread bt_event_investigate(var_0);
      break;
    case "_encstr_AD3D0CB1DBB32BE4EBC4C6F6BBB9":
      thread bt_event_cover_blown(var_0);
      break;
    case "_encstr_AA7C07466F9DA30713":
      thread bt_event_combat(var_0);
      break;
  }

  level notify("_encstr_9A560E4FDCFFA8A94B1266291BE750F8", var_0, self);
  var_3 = scripts\stealth\callbacks::stealth_get_func(var_0.typeorig);

  if(isDefined(var_3) && var_3 != ::bt_event_handler_severity)
    self thread[[var_3]](var_0);

  return 1;
}

bt_event_investigate(var_0) {
  set_alert_level("_encstr_BE7D09F301B846B228D7D6");
  bt_set_stealth_state("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", var_0);
}

bt_event_cover_blown(var_0) {
  set_alert_level("_encstr_927D09879B6EB23938A9B2");

  if(isDefined(var_0.entity) && isDefined(var_0.entity.classname) && var_0.entity.classname == "_encstr_A5B51BFBDEDD13E15347209DB31FE968EAC172298707E02A40B255116B") {
    return;
  }
  if(istrue(level.stealth.disguised)) {
    switch (var_0.typeorig) {
      case "_encstr_AA300EBF415D43B0F85A6159731058AB":
      case "_encstr_92FD082A30066B713094":
      case "_encstr_860808CB78E2984063BA":
        scripts\stealth\utility::set_disguised(0);
        level scripts\engine\utility::delaythread(20, scripts\stealth\utility::set_disguised, 1);
        break;
    }
  }

  if(var_0.typeorig == "_encstr_93380D1B2D3B43A3BEB59636C65919") {
    var_0.look_pos = var_0.investigate_pos;
    var_0.investigate_pos = scripts\engine\utility::drop_to_ground(var_0.investigate_pos, 24, -256);
  }

  if(!self[[self.fnisinstealthcombat]]()) {
    if(self[[self.fnisinstealthhunt]]()) {
      var_1 = scripts\stealth\group::group_updatepodhuntorigin(self, var_0.investigate_pos);

      if(!isDefined(self.pathgoalpos) || distancesquared(var_1, self.pathgoalpos) > 576) {
        scripts\asm\asm::asm_fireephemeralevent("_encstr_9ACC05B4156DF3", "_encstr_AB2B09689D67B03813A7C7", var_0.investigate_pos);
        scripts\stealth\utility::set_patrol_react(var_0.investigate_pos, "_encstr_A972062F7FDAF9B0");
        return;
      }
    } else
      bt_set_stealth_state("_encstr_BE1A0C5ADCD9569B3A96CEB0A3B2", var_0);
  }
}

bt_event_combat(var_0) {
  self notify("_encstr_8F6A15A5CDECB2CD1DB4D916A359AF1356A10BB35AEDC9");
  self notify("_encstr_AFF5136B4BEAA2CF4A38B86349D06B40CED5D004B0");
  set_alert_level("_encstr_999A07C61338F9A23A");
  bt_set_stealth_state("_encstr_AA7C07466F9DA30713", var_0);

  if(isDefined(var_0) && issentient(var_0.entity)) {
    if(!isDefined(self.enemy))
      self resetthreatupdate();

    thread set_provide_cover_fire();
  }

  scripts\engine\utility::ent_flag_set("_encstr_8F910FDCA32BB0D81D34AFB08ED1856CD6");
}

set_provide_cover_fire() {
  self.providecoveringfire = 1;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_ADEA141F347D87A0B150CF92DD3B1813133CD4A115B5");
  self endon("_encstr_A7E10D92957551DBC464E0094DFE0C");
  self endon("_encstr_99A30FCD3ACAB0D8471AAF6CB76B89853A");
  wait 5;
  self.providecoveringfire = 0;
}