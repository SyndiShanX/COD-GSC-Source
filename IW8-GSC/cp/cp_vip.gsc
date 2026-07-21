/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_vip.gsc
***********************************************/

vip_spawn(var_0, var_1, var_2) {
  if(istrue(var_1))
    scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");

  for(;;) {
    if(scripts\cp\cp_modular_spawning::allowed_to_spawn_agent(undefined, 1, 1, var_2)) {
      var_3 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_B8851C32491D97B2C9FF293E83383CF74866AAAB56F747ED70C967388520", var_0.origin, var_0.angles);

      if(isDefined(var_3)) {
        var_3 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
        var_3 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
        break;
      }
    }

    wait 0.1;
  }

  if(istrue(var_1))
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "_encstr_92DF0A13BAFB2E53D7214BE3");

  var_3.scripted_mode = 1;
  var_3.ignoreall = 1;
  var_3.dontkilloff = 1;
  var_3.health = 100000;
  var_3.maxhealth = 100000;
  var_3.suppressionthreshold = 0.0;
  var_3.meleealwasywin = 1;
  var_3.dontmeleeme = 1;
  var_3.dontmelee = 1;
  set_default_vip_hints(var_3);
  return var_3;
}

set_default_vip_hints(var_0) {
  if(!isDefined(var_0.hint_use))
    var_0.hint_use = &"_encstr_B6411ECE7A99ED2F3F1799D96F67C4A5B05756CD84A13BF7A727C1695746DC79";

  if(!isDefined(var_0.hint_stop))
    var_0.hint_stop = &"_encstr_AAC5232EF1FE8693D76F43029C7197AEDAE53E99F0E96FB7DAB69587CA2FE7A77F873CAB87";
}

set_vip_hints(var_0, var_1, var_2) {
  if(!isDefined(var_0.followingplayer)) {
    if(isDefined(var_2))
      var_0.hint_stop = var_2;

    var_0.trigger setHintString(var_0.hint_stop);
  } else {
    if(isDefined(var_1))
      var_0.hint_use = var_1;

    var_0.trigger setHintString(var_0.hint_use);
  }
}

create_vip_trigger(var_0, var_1) {
  set_default_vip_hints(var_0);
  var_0.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 30));
  var_0.trigger linkTo(var_0);
  var_0.onuse = ::vip_onuse;
  var_0.trigger setHintString(var_0.hint_use);
  var_0.trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_0.trigger sethintdisplayrange(148);
  var_0.trigger sethintdisplayfov(90);
  var_0.trigger setuserange(72);
  var_0.trigger setusefov(45);
  var_0.trigger sethintonobstruction("_encstr_BD1805CB69C063");
  var_0.trigger sethintrequiresholding(1);
  var_0.trigger setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_0 thread scripts\engine\utility::delete_on_death(var_0.trigger);
  var_0 thread vip_use_think(var_0, var_1);
}

vip_use_think(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8FAE0723DEEECDCA19");
  var_0 endon("_encstr_8A12060D5BA9C745");
  var_0.trigger endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }
    var_0[[var_0.onuse]](var_2, var_1);
  }
}

vip_turnoff(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0 notify("_encstr_8A12060D5BA9C745");
  var_0 notify("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
  var_0 stop_following_all_players();

  if(isDefined(var_0.trigger))
    var_0.trigger delete();
}

update_vip_trigger(var_0, var_1, var_2) {
  self.trigger endon("_encstr_AD75063D571AE108");
  self.trigger makeunusable();
  wait 2;
  self.trigger setHintString(var_0);
  self.trigger makeusable();
}

vip_onuse(var_0, var_1) {
  self notify("_encstr_B1DA09D3DB3FF1756059F7");
  set_default_vip_hints(self);

  if(!isDefined(self.followingplayer)) {
    if(istrue(var_1)) {
      self.headicon = deleteheadicon(self);
      setheadiconfriendlyimage(self.headicon, "_encstr_8ADF1B80A0B99F1B38B71EB93B9FF151D66783087BB3599DB6E2E04D88");
      setheadicondrawthroughgeo(self.headicon, 1);
      setheadiconsnaptoedges(self.headicon, 29000);
      setheadiconmaxdistance(self.headicon, 10);
      addclienttoheadiconmask(self.headicon, 10);
    }

    enable_outline();
    thread remove_headicon_on_death();
    thread vip_followplayer(var_0);
    thread update_vip_trigger(self.hint_stop, 1, var_0);
  } else {
    self notify("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
    self notify("_encstr_B8D910023F20F5D3AB27F802D659C8813540");
    disable_outline();
    self.followingplayer = undefined;
    var_2 = getclosestpointonnavmesh(self.origin);
    self setgoalpos(var_2);
    thread update_vip_trigger(self.hint_use, 0);
  }
}

vip_damage_monitor() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_AF9408159532F05D779A");
  objective_setlabel(self.objnum, &"_encstr_A25C232931E1BD773F1BE37E2B179C051CC8B119584B7B6FA660E37937C34659B71041E1E0");
  self.script_health = 100;
  self.health = 10000;
  self.maxhealth = 10000;
  objective_setprogress(self.objnum, 0.99);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1);

    if(!istrue(self.bledout))
      self.health = self.maxhealth;

    if(isDefined(var_1) && var_1.team == self.team) {
      continue;
    }
    self.script_health = self.script_health - var_0;

    if(self.script_health < 0)
      self.script_health = 0;

    objective_setprogress(self.objnum, self.script_health / 100);

    if(self.script_health <= 0) {
      thread ai_enter_laststand();
      self waittill("_encstr_8E4208C9ACEC5A3BAC46");
    }
  }
}

ai_enter_laststand() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8E4208C9ACEC5A3BAC46");
  self setCanDamage(0);
  self.trigger setHintString(&"_encstr_86B11AF1183D511EE741A1AD4763A4BB10A6F159E1C40515AFBD56B5");
  self.trigger setuseholdduration("_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9");
  self.onuse = ::revive_vip;
  self notify("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
  self.reviveiconent = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.trigger.origin);
  scripts\cp\cp_laststand::makereviveicon(self.reviveiconent, self, (1, 1, 1), 30);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setlookatentity();
  self.headlook_enabled = 0;
  self.disableautolookat = 1;
  scripts\asm\shared\mp\utility::burndowntime("_encstr_870112E882730D41ABDF1779F95220CEBB4A80B1");
  scripts\asm\shared\mp\utility::bunkernum("_encstr_84C70F22E807C3175B7FA6A41880338D43", 30);

  if(isDefined(self.reviveiconent))
    self.reviveiconent delete();

  self.bledout = 1;
  self dodamage(self.health + 100, self.origin);
}

revive_vip(var_0, var_1) {
  if(isDefined(self.reviveiconent))
    self.reviveiconent delete();

  scripts\asm\shared\mp\utility::burndowntime("_encstr_A9C21263C2CD8EDC47C2E691D71DEDBED291B12B");
  scripts\cp\cp_skits::reset_guy(self);
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.script_health = 100;
  self.inlaststand = 0;
  objective_setprogress(self.objnum, 0.99);
  thread update_vip_trigger(self.hint_stop, 1, var_0);
  self.trigger setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  enable_outline();
  thread vip_followplayer(var_0);
  objective_icon(self.objnum, "_encstr_A23F20C3AE82AD861FE790D0F729F8C1E9D5CEDA87FA5188E6EF9970A7765105D2BD");
  self notify("_encstr_9695073995D94BD959");
  self notify("_encstr_8E4208C9ACEC5A3BAC46");
  self.onuse = ::vip_onuse;
}

vip_followplayer(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
  self endon("_encstr_ABCC10DC47DB07F5CEB483BE33BDB136DBEE");
  self.goalradius = 128;
  self.followingplayer = var_0;
  var_1 = squared(256);

  while(var_0 scripts\cp\utility::is_valid_player(1)) {
    if(distancesquared(var_0.origin, self.origin) > var_1) {
      var_2 = getclosestpointonnavmesh(var_0.origin);
      self setgoalpos(var_2);
    }

    wait 1;
  }

  var_3 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_3)) {
    self.followingplayer = undefined;
    vip_onuse(var_3, 0);
  } else
    stop_following_all_players();
}

stop_following_all_players() {
  set_default_vip_hints(self);
  self notify("_encstr_B8D910023F20F5D3AB27F802D659C8813540");
  disable_outline();
  self.followingplayer = undefined;
  var_0 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_0);
  thread update_vip_trigger(self.hint_use, 0);
}

remove_headicon_on_death() {
  if(!isDefined(self.headicon)) {
    return;
  }
  var_0 = self.headicon;
  var_1 = scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_B8D910023F20F5D3AB27F802D659C8813540");
  setheadiconimage(var_0);
}

enable_outline() {
  self hudoutlineenable("_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190");
}

disable_outline() {
  self hudoutlinedisable();
}