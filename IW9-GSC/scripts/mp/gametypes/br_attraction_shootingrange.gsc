/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_attraction_shootingrange.gsc
****************************************************************/

init() {
  sr = spawnStruct();
  level.brattractions["sr"] = sr;
  sr.ui_damage_num_next_index = 0;
  sr.ui_damage_num_elems = [];
  sr.ui_damage_nums_global_limit = getdvarint("dvar_E0C51E32DA4B11CB", 30);
  sr.ui_show_dist = getdvarint("dvar_3D2FC106B6E924AA", 1);
  sr.useagents = getdvarint("dvar_40EB6F9F418027EC", 0) != 0;
  sr.agenttargetloadout = createagenttargetloadout();
  sr.ranges = [];

  if(sr.useagents)
    level.agent_funcs["player"]["think"] = ::agentthink;

  init_structs();
  init_ranges();
}

init_structs() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      init_structs_mp_br_mechanics();
      break;
    case "mp_donetsk":
    case "mp_donetsk2":
    case "mp_don3":
      init_structs_mp_don3();
      break;
    default:
      break;
  }
}

init_structs_mp_br_mechanics() {
  root = _id_2B18B5E07EE78187::add_struct("attraction_shootingrange", "test_range_objects");
  root _id_2B18B5E07EE78187::struct_set_fields((-1961, 470, 0), (0, 0, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage");
  s _id_2B18B5E07EE78187::struct_set_fields((-1961, 708, 0), (0, 180, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((-1961, 530, 0), (0, 0, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((-1961, 470, 0), (0, 0, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((-1961, 410, 0), (0, 0, 0));
}

init_structs_mp_don3() {
  root = _id_2B18B5E07EE78187::add_struct("attraction_shootingrange", "military_base_range_1");
  root _id_2B18B5E07EE78187::struct_set_fields((4183, 51989, 1029), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((4225, 52031, 1029), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((4183, 51989, 1029), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((4141, 51947, 1029), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage");
  s _id_2B18B5E07EE78187::struct_set_fields((3941, 51747, 1029), (0, 135, 0));
  root = _id_2B18B5E07EE78187::add_struct("attraction_shootingrange", "military_base_range_3");
  root _id_2B18B5E07EE78187::struct_set_fields((6341, 55005, 1018), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((6299, 54963, 1018), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((6341, 55005, 1018), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((6371, 54975, 1010), (0, -45, 0));
  s = _id_2B18B5E07EE78187::add_struct(root.target, undefined, "show_damage_death");
  s _id_2B18B5E07EE78187::struct_set_fields((6383, 55047, 1018), (0, -45, 0));
}

init_ranges() {
  ranges = scripts\engine\utility::getStructArray("attraction_shootingrange", "targetname");

  foreach(range in ranges)
  init_range(range);
}

init_range(range) {
  _id_94E49A1D99BFD258 = level.brattractions["sr"].ranges.size;
  level.brattractions["sr"].ranges[_id_94E49A1D99BFD258] = range;
  range.type = range.script_noteworthy;

  if(!isDefined(range.type))
    range.type = "standard";

  switch (range.type) {
    case "standard":
      init_standard_range(range, _id_94E49A1D99BFD258);
      break;
    default:
      break;
  }
}

init_standard_range(range, locindex) {
  init_range_targets(range);
  range.icontrigger = _id_6731BE38C3B94FF7::createattractionicontrigger("range", locindex, range.origin, 150, "ui_mp_br_mapmenu_icon_poi_sb_range", 1800, ::playerattractiontriggerenter, ::playerattractiontriggerexit, "br_attraction_sr");
  range.icontrigger _id_6731BE38C3B94FF7::triggeraddobjectivetext(&"MP_BR_INGAME/ATTRACT_SR_NAME");
  range.icontrigger _id_6731BE38C3B94FF7::triggersafearea();
}

playerattractiontriggerenter(player, trigger) {
  _id_5527B5BA26B5064B = !isDefined(player.sr_next_ammo_restock_time) || gettime() > player.sr_next_ammo_restock_time;

  if(_id_5527B5BA26B5064B) {
    scripts\mp\ammorestock::_id_42F888E2E819CC64(player);
    player.sr_next_ammo_restock_time = gettime() + 10000;
  }
}

playerattractiontriggerexit(player, trigger) {}

init_range_targets(range) {
  if(!isDefined(range.target)) {
    return;
  }
  if(useagents()) {
    range.linker = spawn("script_model", range.origin);
    range.linker.angles = (0, 0, 0);
    range.linker setModel("tag_origin");
  }

  targets = scripts\engine\utility::getStructArray(range.target, "targetname");
  range.killable_targets = 0;
  range.dead_target_count = 0;

  foreach(target in targets) {
    target.type = target.script_noteworthy;

    if(!isDefined(target.type)) {
      continue;
    }
    switch (target.type) {
      case "show_damage":
        thread init_range_target_show_damage(range, target, 0);
        break;
      case "show_damage_death":
        range.killable_targets++;
        thread init_range_target_show_damage(range, target, 1);
        break;
      default:
        break;
    }
  }
}

init_range_target_show_damage(range, target, _id_C1EA0BC07133B32D) {
  if(!isent(target)) {
    maxagents = getmaxagents();
    useagents = useagents();

    if(!useagents || maxagents == 0) {
      model_name = target.model;

      if(!isDefined(model_name))
        model_name = "military_action_target_01";

      _id_CB4CA4C438DDCB16 = spawn("script_model", target.origin);
      _id_CB4CA4C438DDCB16 setModel(model_name);
      _id_CB4CA4C438DDCB16.angles = target.angles;
    } else {
      while(!isDefined(level.agentarray) || level.agentarray.size < maxagents)
        waitframe();

      _id_CB4CA4C438DDCB16 = scripts\mp\agents\agents::add_humanoid_agent("player", "axis", "callback", target.origin, target.angles, undefined, 1, 0, undefined, ::agentclasscallback, 0, 1, 1, 1);
      _id_CB4CA4C438DDCB16 scripts\mp\utility\player::_setsuit("iw9_defaultsuit_mp");
      _id_CB4CA4C438DDCB16 enableanimstate(0);
      _id_CB4CA4C438DDCB16.bcdisabled = 1;
      _id_CB4CA4C438DDCB16.skipfriendlyfire = 1;
      _id_CB4CA4C438DDCB16.skipcorpse = 1;
      _id_CB4CA4C438DDCB16 linkTo(range.linker, "tag_origin");
    }
  } else
    _id_CB4CA4C438DDCB16 = target;

  thread target_show_damage_damage_watch(range, _id_CB4CA4C438DDCB16, _id_C1EA0BC07133B32D);
}

target_show_damage_damage_watch(range, target, _id_C1EA0BC07133B32D) {
  target endon("death");

  if(!isagent(target))
    target setCanDamage(1);

  health = 10000;
  _id_CB05DC87238CA21C = 150;
  _id_40B21467F572E707 = 100;
  _id_815F66FFFB610612 = 0;
  _id_0AF794A323D5A8F4 = 0;
  head = undefined;

  if(target.model == "military_action_target_01") {
    _id_85084349E5718B83 = (2, 0, 65);
    head = spawnStruct();
    head.origin = rotatevector(_id_85084349E5718B83, target.angles) + target.origin;
    head.radius = 5;
  }

  for(;;) {
    if(!_id_C1EA0BC07133B32D || !_id_0AF794A323D5A8F4) {
      target.health = health;
      _id_815F66FFFB610612 = 1;
      _id_0AF794A323D5A8F4 = 1;
    }

    target waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);

    if(istrue(target.is_dead)) {
      continue;
    }
    has_armor = target.health > health - _id_CB05DC87238CA21C;
    _id_B2186E65B6999CF3 = target.health > health - _id_CB05DC87238CA21C - _id_40B21467F572E707;
    _id_2CC9F0F9F98029D8 = _id_815F66FFFB610612 && !has_armor;
    _id_6181D0250AFA3CEC = _id_0AF794A323D5A8F4 && !_id_B2186E65B6999CF3;
    headshot = 0;

    if(isDefined(head)) {
      headshot = !_id_2669878CF5A1B6BC::isspreadweapon(weapon) && distance(point, head.origin) < head.radius;

      if(headshot)
        damage = int(damage * 1.4);
    }

    _id_7A541E653B7997DB = attacker;

    if(isDefined(attacker) && !isPlayer(attacker) && isDefined(attacker.owner) && isPlayer(attacker.owner))
      _id_7A541E653B7997DB = attacker.owner;

    if(isDefined(_id_7A541E653B7997DB)) {
      target.attacker = _id_7A541E653B7997DB;
      _id_CDCEDB142F61B43E = "standard";
      _id_A3192D2F80ED4FF8 = scripts\engine\utility::isbulletdamage(meansofdeath);
      _id_B98146816886D3C4 = scripts\engine\utility::ter_op(_id_A3192D2F80ED4FF8 && scripts\mp\utility\weapon::isprimaryweapon(weapon), "standardspread", "standard");

      if(_id_C1EA0BC07133B32D) {
        _id_F3D8C14A53E479F5 = undefined;

        if(has_armor) {
          _id_CDCEDB142F61B43E = "hitarmorlight";
          _id_F3D8C14A53E479F5 = "hit_marker_3d_armor";
        } else if(_id_2CC9F0F9F98029D8) {
          _id_CDCEDB142F61B43E = "hithelmetlightbreak";
          _id_F3D8C14A53E479F5 = "hit_marker_3d_armor_break";
        }

        if(_id_CDCEDB142F61B43E == "hitarmorlightbreak" || _id_CDCEDB142F61B43E == "hitarmormaxplatebreak") {
          armorbreak = 1;

          if(_id_B98146816886D3C4 == "standardspread")
            _id_B98146816886D3C4 = "standardspreadarmor";
          else
            _id_B98146816886D3C4 = "standardarmor";
        }

        _id_7A541E653B7997DB _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, _id_6181D0250AFA3CEC, headshot, _id_B98146816886D3C4);

        if(isDefined(_id_F3D8C14A53E479F5))
          _id_7A541E653B7997DB playlocalsound(_id_F3D8C14A53E479F5);

        if(_id_6181D0250AFA3CEC) {
          if(!isagent(target)) {
            thread target_play_death_anim(range, target);
            thread target_drop_loot(range, target);
          }
        }
      } else
        _id_7A541E653B7997DB _id_5762AC2F22202BA2::updatedamagefeedback(_id_CDCEDB142F61B43E, 0, headshot, _id_B98146816886D3C4);

      thread target_show_damage(range, target, _id_7A541E653B7997DB, damage);
      thread target_show_dist(point, _id_7A541E653B7997DB);
    }

    _id_815F66FFFB610612 = has_armor;
    _id_0AF794A323D5A8F4 = _id_B2186E65B6999CF3;
  }
}

target_show_damage(range, target, player, damage) {
  sr = level.brattractions["sr"];
  index = sr.ui_damage_num_next_index;
  sr.ui_damage_num_next_index++;

  if(sr.ui_damage_num_next_index >= sr.ui_damage_nums_global_limit)
    sr.ui_damage_num_next_index = 0;

  if(isDefined(sr.ui_damage_num_elems[index]))
    sr.ui_damage_num_elems[index] destroy();

  _id_4F7CEE513622171B = 8;
  _id_4F58E45135F98665 = 8;
  _id_F360CD499E275114 = -15;
  _id_F384BB499E4FA436 = 15;
  _id_BE87B64AA6449371 = 70;
  _id_1EEA939243434BF3 = 70;
  _id_BE87B54AA644913E = -25;
  _id_1EEA9292434349C0 = 25;
  _id_69E534485EF2759C = 1.0;

  if(!isDefined(player.ui_damage_num_cycle))
    player.ui_damage_num_cycle = 0;

  _id_6FCF5ED72AAFE20D = 7;
  frac = player.ui_damage_num_cycle % _id_6FCF5ED72AAFE20D / _id_6FCF5ED72AAFE20D;
  player.ui_damage_num_cycle = player.ui_damage_num_cycle + 2;
  _id_94480E1669B7FF0D = player scripts\mp\hud_util::createfontstring("objective", 1.0);
  sr.ui_damage_num_elems[index] = _id_94480E1669B7FF0D;
  _id_94480E1669B7FF0D.alpha = 1;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;
  _id_94480E1669B7FF0D.color = (1, 0, 0);
  _id_94480E1669B7FF0D.x = scripts\engine\math::lerp(_id_4F7CEE513622171B, _id_4F58E45135F98665, frac);
  _id_94480E1669B7FF0D.y = scripts\engine\math::lerp(_id_F360CD499E275114, _id_F384BB499E4FA436, frac);
  _id_94480E1669B7FF0D.horzalign = "center";
  _id_94480E1669B7FF0D.vertalign = "middle";
  _id_94480E1669B7FF0D fadeovertime(_id_69E534485EF2759C);
  _id_94480E1669B7FF0D.alpha = 0.0;
  _id_94480E1669B7FF0D setvalue(damage);
  _id_94480E1669B7FF0D moveovertime(_id_69E534485EF2759C);
  _id_94480E1669B7FF0D.x = _id_94480E1669B7FF0D.x + randomfloat(_id_1EEA939243434BF3 - _id_BE87B64AA6449371) + _id_BE87B64AA6449371;
  _id_94480E1669B7FF0D.y = _id_94480E1669B7FF0D.y + scripts\engine\math::lerp(_id_BE87B54AA644913E, _id_1EEA9292434349C0, frac);
  _id_94480E1669B7FF0D endon("death");
  wait(_id_69E534485EF2759C);

  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D destroy();
}

target_show_dist(point, player) {
  if(!level.brattractions["sr"].ui_show_dist) {
    return;
  }
  player notify("attraction_sr_range_hud");
  player endon("attraction_sr_range_hud");
  _id_94480E1669B7FF0D = player.attraction_sr_range_hud;

  if(!isDefined(_id_94480E1669B7FF0D)) {
    _id_94480E1669B7FF0D = player scripts\mp\hud_util::createfontstring("objective", 1.0);
    _id_94480E1669B7FF0D.alpha = 1;
    _id_94480E1669B7FF0D.glowalpha = 0;
    _id_94480E1669B7FF0D.hidewheninmenu = 1;
    _id_94480E1669B7FF0D.archived = 0;
    _id_94480E1669B7FF0D.color = (1, 0, 0);
    _id_94480E1669B7FF0D.x = 0;
    _id_94480E1669B7FF0D.y = 20;
    _id_94480E1669B7FF0D.horzalign = "center";
    _id_94480E1669B7FF0D.vertalign = "middle";
    _id_94480E1669B7FF0D.alignx = "center";
    _id_94480E1669B7FF0D.aligny = "middle";
    _id_94480E1669B7FF0D.label = &"MP_BR_INGAME/ATTRACT_SR_DISTANCE";
    player.attraction_sr_range_hud = _id_94480E1669B7FF0D;
  }

  _id_94480E1669B7FF0D endon("death");
  dist = distance(point, player getEye());
  dist = dist / 39.37;
  dist = int(dist + 0.5);
  _id_94480E1669B7FF0D setvalue(dist);
  _id_94480E1669B7FF0D.alpha = 1;
  wait 0.5;
  fade_time = 0.5;
  _id_94480E1669B7FF0D fadeovertime(0.5);
  _id_94480E1669B7FF0D.alpha = 0.0;
  wait(fade_time);

  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D destroy();
}

target_drop_loot(range, target) {}

target_play_death_anim(range, target) {
  target endon("death");
  target.is_dead = 1;
  z = -65;
  _id_69E534485EF2759C = 0.3;
  target movez(z, _id_69E534485EF2759C, _id_69E534485EF2759C);
  wait(_id_69E534485EF2759C);
  range.dead_target_count++;

  while(range.dead_target_count < range.killable_targets)
    waitframe();

  wait 0.5;
  target movez(-1 * z, _id_69E534485EF2759C, _id_69E534485EF2759C);
  wait(_id_69E534485EF2759C);
  range.dead_target_count--;
  target.is_dead = 0;
}

useagents() {
  return istrue(level.brattractions["sr"].useagents);
}

createagenttargetloadout() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_me_fists";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

agentclasscallback() {
  return level.brattractions["sr"].agenttargetloadout;
}

agentthink() {
  self freezecontrols(1);
  self.ignoreall = 1;
}