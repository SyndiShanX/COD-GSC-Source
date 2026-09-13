/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_risk.gsc
*****************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "risk") {
    return;
  }
  init();
}

init() {
  _id_362C58E8BB39BCDA::disablefeature("circle");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("dropbag");

  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 0)
    _id_362C58E8BB39BCDA::disablefeature("teamSpectate");

  _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");

  if(getdvarint("dvar_D507D3832769E0D7", 0) == 0)
    _id_362C58E8BB39BCDA::disablefeature("kiosk");

  if(getdvarint("dvar_DF75008333710E55", 1) == 1)
    _id_362C58E8BB39BCDA::enablefeature("tabletReplace");

  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnectrisk);
  level.teamplunderscoremechanic = getdvarint("dvar_1A7A6D4EE3338761", 0);
  level.brgametype.maxextractions = getdvarint("dvar_B6A790D232323E81", 5);
  level.brgametype.numextractions = 0;
  level.brgametype.firstteam = "tie";
  level.brgametype._id_BE0C10911FEC189F = 1;
  level.br_prematchffa = 0;
  setDvar("dvar_C0DBA6A7250AAD33", 1);
  level.topteamsever = [];
  level.lootleaders = [];
  level.expiredlootleaders = [];
  level.called50percentprogress = 0;
  level.called75percentprogress = 0;
  level.called90percentprogress = 0;
  scorelimit = getdvarint("dvar_5072385F6119FF87", 10);

  if(scorelimit > 0) {
    setDvar("scr_br_scorelimit", scorelimit);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), scorelimit);
  }

  setDvar("scr_br_magcount", 3);
  setDvar("scr_br_loadout_option", "nothing");
  setdvarifuninitialized("scr_br_respawnmaxteammateoffset", 10000);
  setomnvar("ui_br_circle_state", 4);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  setdvarifuninitialized("dvar_BBB179520C2C4A14", 1);
  level.giveloadouteverytime = getdvarint("dvar_2EFFF4C3F474F5C7", 1);
  level.instantbleedoutsquadwipe = getdvarint("dvar_C6ACAB01F606FF92", 1);
  level.bottompercentagetoadjusteconomy = getdvarint("dvar_55E51828A59C2C5B", 50);
  level.toppercentagetoadjusteconomy = getdvarint("dvar_A1970E3C66611A73", 5);
  level.usemilestonephases = getdvarint("dvar_D7A5882FE16D92E3", 1);
  level.milestonephasepercent_vips = getdvarint("dvar_59CBA3276A3A96C6", 3);
  level.milestonephasepercent_lzs = getdvarint("dvar_7FDCCBEE87A1FF6D", 0);
  level.milestonephasepercent_drops = getdvarint("dvar_D6AB3431E584EAD8", 0);
  level.milestonephasepercent_helis = getdvarint("dvar_BEAC4D91AD3AF5D7", 0);
  level.airdropbasecashamount = getdvarint("dvar_F21F22782971C2AC", 750);
  level.hideplacementuntilpercent = getdvarint("dvar_BFB818FA6A83F7D2", 10);
  level.hideleaderhashuntilpercent = getdvarint("dvar_C124A7A4AFB14348", 0);
  level.showplacementsplashesandmusic = getdvarint("dvar_63908C5E06402524", 1);
  level.secondsbeforeplacementupdates = getdvarint("dvar_E616CB0E727859DD", 60);
  level.disablepercentageannouncements = getdvarint("dvar_69E6435403E5C322", 0);
  level.lootleadermarkcount = getdvarint("scr_plunder_loot_leader_mark_count", 5);
  level.maxlootleadermarkcount = getdvarint("scr_plunder_loot_leader_mark_count", 5);
  level.lootleadermarksize = getdvarint("dvar_1650346812659DF2", 5000);
  level.lootleaderoneperteam = getdvarint("dvar_5FD1126EC81D6B0B", 1) == 1;
  level.lootleadermarksizedynamic = getdvarint("dvar_1B7554A04B02683C", 1);
  level.lootleadermarkstrongsize = getdvarint("dvar_210471FB05950431", 2000);
  level.lootleadermarkstrongvalue = getdvarint("dvar_F53E6F6FDDBBBC11", 5000);
  level.lootleadermarkweaksize = getdvarint("dvar_FC8B22A888365974", 5000);
  level.lootleadermarkweakvalue = getdvarint("dvar_43D67F5054412E02", 1000);
  level.expiredlootleaderenabled = getdvarint("dvar_A88980519C8D01B6", 0) == 1;
  level.lootleadermarksontopteams = getdvarint("scr_plunder_loot_leader_mark_top_teams", 2);
  level.plundermusicfirst = getdvarfloat("dvar_24C7C305D1EAD986", 0.3);
  level.plundermusicsecond = getdvarfloat("dvar_3F1F73F0AEEC8FD4", 0.5);
  level.plundermusicthird = getdvarfloat("dvar_25360B6A507D1E21", 0.75);
  level.plundermusicfourth = getdvarfloat("dvar_11B704EDA4D01A78", 0.9);
  level.useautorespawn = getdvarint("dvar_9EA6558E3FDC02D8", 1);
  level.autorespawnwaittime = getdvarint("dvar_4BEAC336193A373D", 20);
  level.tokenrespawnwaittime = getdvarint("dvar_728CBA7A2ADC64DB", level.autorespawnwaittime);
  level.incrementalrespawnpunish = getdvarint("dvar_FC3A0F4F0CDD615E", 0);
  level.incrementalrespawnpunishmax = getdvarfloat("dvar_5EB645F42926F53B", 15);
  level.respawnheightoverride = getdvarint("scr_plunder_respawnheightoverride", 5000);
  level.respawntimedisable = getdvarint("dvar_73DBC19AD4C85D57", 0);
  level.parachutedeploydelay = getdvarfloat("dvar_12027360B079C1DB", 0.5);
  level.bonusdeathplunder = getdvarint("dvar_D8CE253F7D3B81FF", 200);
  level.bonusdeathplunderot = getdvarint("dvar_8D7F79A8E24F83CB", 250);
  level.maxplunderdropondeath = getdvarint("dvar_39F9DA18BB66E22A", 9);
  level.minplunderdropondeath = getdvarint("dvar_E0A487B88D0E4410", 0);
  level.percentageplunderdrop = getdvarint("dvar_EFD614D3EF385A53", 90);
  level.plunderfxondropthreashold = getdvarint("dvar_9421B492CB2D2DB8", 750);
  level.maxplunderdropinovertime = getdvarint("dvar_0F9A79B878DEE90D", 2000);
  level.executioncashmultiplier = getdvarfloat("scr_plunder_executioncashmultiplier", 1);
  level.autoassignfirstquest = getdvarint("dvar_4A06E0523640F8FA", 0);
  level.quest_domdistmin = getdvarint("dvar_AD5A509FCECCDBCA", 5000);
  level.quest_domdistmax = getdvarint("dvar_AD7D5A9FCEF33980", 10000);
  level.quest_assdistmin = getdvarint("dvar_F976A86D8DA6CC4D", 2500);
  level.quest_assdistmax = getdvarint("dvar_F952926D8D7E2133", 7500);
  level.quest_scavdistmin = getdvarint("dvar_F6AA125A8F31D115", 5000);
  level.quest_scavdistmax = getdvarint("dvar_F6CDFC5A8F5A1B6B", 8000);
  level.tabletreplacefrequency = getdvarfloat("dvar_B72A5778B96923F9", 1.5);
  level.skipweapondropondeath = getdvarint("dvar_8D982A8E8331B9F7", 0);
  level.skipequipmentdropondeath = getdvarint("dvar_370FB0965BAF2AD5", 1);
  level.allowfultondropondeath = getdvarint("dvar_9250BEF0872B6DFD", 1);
  level.teamplunderexfil = getdvarint("dvar_53675CDAB06DBCF5", 0) == 1;
  level.teamplunderexfilshowviponly = getdvarint("dvar_7A6732D6B24B1690", 0) == 1;
  level.teamplunderexfilvipuav = getdvarint("dvar_EFE218D17BDAE2FD", 0) == 1;
  level.teamplunderexfiltimer = getdvarint("dvar_C655A0B01B13910A", 180);
  level.showplunderextracticonsinworld = getdvarint("dvar_25741495F8EABDBE", 1) == 1;
  level.shownonscriptableextracticons = getdvarint("dvar_9F64ABB53E8EB4F5", 0);
  level.timeoutplunderextractionsites = getdvarint("dvar_1908E4E2A813777F", 0);
  level.moveplunderextractionsitesonuse = getdvarint("dvar_0E5556C731830E8A", 0) == 1;
  level.extractplunderhelihealth = int(getdvarint("dvar_4806B7415B66C1B5", 999) * 100);
  level.extractplunderheliinvulnerable = getdvarint("dvar_9126054077CBEFAC", 1);
  level.bankplunderextractinstantly = getdvarint("dvar_96C1CDC24F5C05AE", 1);
  level.plunderextractalertnearby = getdvarint("dvar_2878716B2C2FAF01", 1);
  level.matchstartextractsitedelay = getdvarint("dvar_33B1CB6FD6A90EFD", 120);
  level.hideallunselectedextractpads = getdvarint("dvar_EA045E50C8947E0F", 1);
  level.setupevenlydistributedpads = scripts\engine\utility::ter_op(getDvar("mapname") == "mp_br_mechanics", 0, getdvarint("dvar_25FEB62305248C26", 1));
  level.scorerequiresbanking = getdvarint("dvar_2BC34D5113D02622", 0);
  level.disablewinonscore = getdvarint("dvar_1BCB79588E18BE26", 0);
  level.doendofmatchotsequence = getdvarint("dvar_C567928926183D31", 0);
  level.setallclientomnvarot = level.doendofmatchotsequence > 0;
  level.overtimebuiltintomatchtimer = getdvarint("dvar_6C0F2AA1BB3E2B02", 1);
  level.bankingoverlimitwillendot = getdvarint("dvar_5406C1B726FF327C", 0);
  level.mapedgeextractionlocs = getdvarint("dvar_DA53957720737131", 0);
  level.modespawnendofgame = ::playerspawnendofgame;
  level.endmatchcameratransitions = getdvarint("dvar_EC4443371F0F6367", 1);
  level.overtimecashmultiplier = getdvarfloat("dvar_B236ECB84F9D1953", 2);
  setomnvar("ui_br_overtime_cash_multiplier", level.overtimecashmultiplier);
  level.disableonemilannounce = getdvarint("dvar_B94883083EC8EB80", 0);
  level.dmzlootleaderupdateonpickup = getdvarint("dvar_9EFDB377E7AE2DFF", 0) == 1;
  level.dmzwincost = getdvarint("dvar_5072385F6119FF87", 10);
  level.dmzextractcost = getdvarint("dvar_5CB48FB038EC819F", 300);
  level.dmzminextractcost = getdvarint("dvar_02C2D8AE182CF1FC", 40);
  level.dmzextractcostdecrease = getdvarint("dvar_27A4ECC9AA9F8224", 20);
  level.minplunderextractions = getdvarint("dvar_EAACC4689DD5D721", 7);
  level.maxplunderextractions = getdvarint("dvar_23F4EAE3AEEBEFD3", 7);
  level.brdisablefinalkillcam = 1;
  level.risktokenstokeep = getdvarint("dvar_8CEA7E041C1DEEE8", 1);
  level.maxtokensdropondeath = getdvarint("dvar_BDA5EB803AFD4B57", 100);
  level.mintokensdropondeath = getdvarint("dvar_7B8E1F5EF61C1C39", 1);
  level.percentagetokensdrop = getdvarint("dvar_C1FE10282085BA76", 100);
  level.domplatecapturetime = getdvarint("dvar_95155421BEA003E6", 30);
  thread _id_271667045665E514::init();
  thread initpostmain();
  thread initdialog();
  scripts\engine\scriptable::scriptable_addautousecallback(::scriptable_token_scriptable_touched_callback);
}

initpostmain() {
  waittillframeend;
  seticonnames();
  thread setupdomplates();
  level.uavsettings["uav"].timeout = 60;
  scripts\mp\flags::gameflaginit("collect_done", 0);
  scripts\mp\flags::gameflaginit("helipad_wait_done", 0);
  scripts\mp\flags::gameflaginit("placement_updates_allowed", 0);
  scripts\mp\flags::gameflaginit("activate_cash_lzs", 0);
  scripts\mp\flags::gameflaginit("activate_cash_drops", 0);
  scripts\mp\flags::gameflaginit("activate_cash_helis", 0);
  level.modemayconsiderplayerdead = ::brmayconsiderplayerdead;
  level.brmodevariantrewardcullfunc = ::missions_clearinappropriaterewards;
  level.ononeleftevent = ::ononeleftevent;
  level.onplayerkilled = ::onriskplayerkilled;
  level.onpostkillcamcallback = ::onpostkillcamcallback;
  level.ontimelimit = ::ontimelimit;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::playerlootleadervalidity);
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onriskplayerdisconnect);
  thread setupmission();
  thread _id_271667045665E514::lootchopper_managespawns();
  thread _id_2E385BC294259245::c130airdrop_managedrop();
  level.lootleadermarks = [];
  level.expiredlootleadermarks = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
    if(level.lootleadermarksontopteams > 0 && _id_AC0E594AC96AA3A8 == 0)
      _id_E08FDF5D9199F540 = "LootLeaderTop_Plunder";
    else
      _id_E08FDF5D9199F540 = "LootLeader_Plunder";

    instance = spawnStruct();
    instance.modifier = "";
    instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_E08FDF5D9199F540, undefined, level.lootleadermarksize);
    level.lootleadermarks[_id_AC0E594AC96AA3A8] = instance;
    instance = spawnStruct();
    instance.modifier = "";
    instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Expired_" + _id_E08FDF5D9199F540, undefined, level.lootleadermarksize);
    level.expiredlootleadermarks[_id_AC0E594AC96AA3A8] = instance;
  }

  if(!istrue(level.usemilestonephases))
    level thread placementupdatewait();

  thread waitandstartplunderpolling();
  level thread _id_715028F54BAD19A1::initcashtracking();
  cleanupents();

  if(level.teamplunderscoremechanic) {
    if(getdvarfloat("scr_plunder_loot_leader_update_interval", 15.0) > 0.0)
      level thread updatelootleadersonfixedinterval();
  }

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons)
    level thread createheliextractobjectiveicons();

  if(level.timeoutplunderextractionsites > 0) {
    scripts\mp\flags::gameflagwait("prematch_done");

    if(level.matchstartextractsitedelay > 0)
      wait(level.matchstartextractsitedelay);

    level thread startplunderextractiontimers();
  }

  if(istrue(level.mapedgeextractionlocs))
    level thread initextractionlocations();

  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level thread eomawardplayerxp();

  if(istrue(level.endmatchcameratransitions))
    level thread initendcameralocations();

  speed = getdvarint("dvar_541028F96F581A0A", -1);

  if(speed > 0)
    level.br_level.c130_speedoverride = speed;

  level thread changecirclestateatlowtime();

  if(level.doendofmatchotsequence && level.overtimebuiltintomatchtimer)
    level thread changetimertoovertimetimer();
}

changecirclestateatlowtime() {
  level endon("game_ended");

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  level endon("end_circlestate_timer");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint("scr_br_timelimit");
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_hardpoint_timer", gettime() + int(timer * 1000));
  wait(int(max(timer - 300, 0)));
  setomnvar("ui_br_circle_state", 6);
}

changetimertoovertimetimer() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint("scr_br_timelimit");
  waittime = int(max(timer - level.doendofmatchotsequence, 0));

  if(waittime <= 0) {
    return;
  }
  wait(waittime);
  level notify("end_circlestate_timer");
  level thread triggerovertimetimer(undefined, undefined, 1);
}

waitandstartparachuteoverheadmonitoring() {
  level endon("game_ended");
  level.activeparachutersfactionvo = [];
  level.activeparachutersfactionvo["uktl"] = "dx_bra_uktl_respawning_enemy_in_area";
  level.activeparachutersfactionvo["rutl"] = "dx_bra_rutl_respawning_enemy_in_area";
  level.parachuteoverheadwarningtimeoutms = getdvarint("dvar_BA0B665C109648FD", 45000);
  level.parachuteoverheadwarningprematchtimeoutms = getdvarint("dvar_BFBF97A63D9482CC", 20000);
  level.parachuteoverheadwarningradius = getdvarint("dvar_898325E4EE88D57F", 2000);
  level.parachuteoverheadwarningheight = getdvarint("dvar_019F16B7BFEA9D46", 3000);
  level thread watchparachutersoverhead(level.parachuteoverheadwarningprematchtimeoutms);
  scripts\mp\flags::gameflagwait("prematch_done");
  level notify("cancel_watch_parachuters_overhead");
  waitframe();
  level thread watchparachutersoverhead(level.parachuteoverheadwarningtimeoutms);
}

waitandstartplunderpolling() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  thread plunderrankupdate();
}

cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

onriskplayerdisconnect(player) {
  if(isDefined(player) && scripts\mp\flags::gameflag("prematch_done")) {
    player _id_7E52B56769FA7774::droponplayerdeath();

    if(isDefined(level._id_153F283BCBFFA477)) {
      if(level.teamdata[player.team]["players"].size == 0)
        level._id_153F283BCBFFA477--;
    } else
      scripts\mp\utility\teams::calculatenumteamswithplayers();
  }
}

ononeleftevent(team) {}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome_risk");

  if(!istrue(level.br_infils_disabled))
    self waittill("joining_Infil");
  else
    scripts\mp\flags::gameflagwait("prematch_done");

  wait 1;
  level thread scripts\mp\utility\teams::calculatenumteamswithplayers();

  if(soundexists("dx_mpa_uktl_boost_groundwar"))
    self queuedialogforplayer("dx_mpa_uktl_boost_groundwar", "boost_groundwar", 2);

  scripts\mp\hud_message::showsplash("br_gametype_risk_welcome");

  if(istrue(self.isbrsquadleader))
    level _id_2CEDCC356F1B9FC8::brleaderdialogplayer("deploy_squad_leader", self, 1, 0, 4.5);

  if(istrue(level.autoassignfirstquest) && istrue(level.br_prematchstarted))
    autoassignquest(self);
}

spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

getdropbagdelay() {}

trackserverend() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_4C473852188EDC3F = 0;
  _id_99D0E04B2137BD95 = 0;
  _id_26482CAEEA97C1F9 = 0;

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  for(;;) {
    wait 1;
    timeremaining = scripts\mp\gamelogic::gettimeremaining() / 1000;

    if(istrue(level.bmoovertime)) {
      break;
    }

    if(timeremaining <= 600 && !_id_4C473852188EDC3F) {
      _id_4C473852188EDC3F = 1;
      setomnvar("ui_br_circle_state", 1);

      foreach(player in level.players)
      player scripts\mp\utility\lower_message::setlowermessageomnvar("br_dmz_10minwarning", undefined, 10);

      continue;
    }

    if(timeremaining <= 300 && !_id_99D0E04B2137BD95) {
      _id_99D0E04B2137BD95 = 1;
      setomnvar("ui_br_circle_state", 2);

      foreach(player in level.players)
      player scripts\mp\utility\lower_message::setlowermessageomnvar("br_dmz_5minwarning", undefined, 10);

      continue;
    }

    if(timeremaining <= 0 && !_id_26482CAEEA97C1F9) {
      _id_26482CAEEA97C1F9 = 1;

      if(level.teamplunderscoremechanic) {
        return;
      }
      setomnvar("ui_nuke_countdown_active", 0);
      level.mercywintriggered = 1;
      _id_39E8F33513C716CD = findanyaliveplayer();

      if(isPlayer(_id_39E8F33513C716CD)) {
        _id_39E8F33513C716CD scripts\cp_mp\killstreaks\nuke::tryusenuke();
        wait 10;
        _id_03CC335047305B1B = findteamwithnoplayers();
        level thread scripts\mp\gamelogic::endgame(_id_03CC335047305B1B, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
      } else {
        _id_03CC335047305B1B = findteamwithnoplayers();
        level thread scripts\mp\gamelogic::endgame(_id_03CC335047305B1B, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 0, 1);
      }
    }
  }
}

findanyaliveplayer() {
  _id_7502F9FEF0559294 = getarraykeys(level.teamdata);

  foreach(key in _id_7502F9FEF0559294) {
    if(level.teamdata[key]["alivePlayers"].size > 0)
      return level.teamdata[key]["alivePlayers"][0];
  }

  return undefined;
}

findteamwithnoplayers() {
  _id_7502F9FEF0559294 = getarraykeys(level.teamdata);

  foreach(key in _id_7502F9FEF0559294) {
    if(level.teamdata[key]["players"].size == 0)
      return key;
  }

  return "tie";
}

onriskplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_1E4A61DB11011446::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  _id_1CF59DC12F7225CB = getdvarint("dvar_02AF6E6A061931DC", 7500);

  if(isDefined(level.splashtime_vip) && level.splashtime_vip + _id_1CF59DC12F7225CB > gettime())
    scripts\mp\hud_message::showsplash("bm_vips_marked");

  if(isDefined(level.splashtime_lzs) && level.splashtime_lzs + _id_1CF59DC12F7225CB > gettime())
    scripts\mp\hud_message::showsplash("bm_extract_heli_start");

  if(isDefined(level.splashtime_drops) && level.splashtime_drops + _id_1CF59DC12F7225CB > gettime())
    scripts\mp\hud_message::showsplash("br_c130airdrop_incoming");

  if(isDefined(level.splashtime_helis) && level.splashtime_helis + _id_1CF59DC12F7225CB > gettime())
    scripts\mp\hud_message::showsplash("br_lootchopper_incoming");
}

brmayconsiderplayerdead(player) {
  return 1;
}

playerrespawn() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }
  if(getdvarint("dvar_FE3AFD6EAD4AA523", 1) == 1)
    self endon("brWaitAndSpawnClientComplete");

  _id_652F47620AC4713F = scripts\mp\utility\teams::getteamdata(self.team, "teamCount");

  if(!istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    _id_80365E25F6E3BEFD = 1.0;
    wait(_id_80365E25F6E3BEFD);
  }

  if(istrue(self.hasrespawntoken) && isDefined(level.tokenrespawnwaittime))
    _id_30839284ADD41CED = level.tokenrespawnwaittime;
  else if(level.incrementalrespawnpunish > 0.0)
    _id_30839284ADD41CED = clamp(self.pers["deaths"] * level.incrementalrespawnpunish, 0.0, level.incrementalrespawnpunishmax);
  else if(isDefined(level.autorespawnwaittime))
    _id_30839284ADD41CED = level.autorespawnwaittime;
  else
    _id_30839284ADD41CED = getdvarint("dvar_5639A8F49B94DACB", 20);

  _id_AC5CF023CA77DB21 = getdvarfloat("dvar_DE0DFC4549393BA2", 10.0);

  if(_id_30839284ADD41CED < _id_AC5CF023CA77DB21)
    _id_30839284ADD41CED = _id_AC5CF023CA77DB21;

  if(level.respawntimedisable != 0)
    _id_30839284ADD41CED = 0;

  _id_E343378B89E661FB = getdvarfloat("dvar_CC53A64FA6E4897B", 5.0);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;

  if(istrue(self.squadwiped) || _id_652F47620AC4713F == 1) {
    spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
    _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    thread fadetogearingup(0.0, _id_652F47620AC4713F > 1);
    wait(_id_E343378B89E661FB);
  } else if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_30839284ADD41CED * 1000));
    _id_A294C35CBB452CBF = _id_30839284ADD41CED - _id_AC5CF023CA77DB21;
    _id_D2F5422694822652 = _id_30839284ADD41CED - _id_A294C35CBB452CBF;
    _id_C445F6D6BC71ED85 = _id_30839284ADD41CED - getdvarfloat("dvar_0879A2FDE5543837", 6.0);
    thread fadetogearingup(_id_C445F6D6BC71ED85);
    result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_A294C35CBB452CBF);

    if(result == "squad_wipe_death") {
      spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      thread fadetogearingup(0.0, 1);
      wait(_id_E343378B89E661FB);
    } else {
      thread updateprestreamrespawn();
      result = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", _id_D2F5422694822652);

      if(result == "squad_wipe_death") {
        spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
        thread fadetogearingup(0.0, 1);
        wait(_id_E343378B89E661FB);
      }
    }
  }

  self notify("stop_updatePrestreamRespawn");
  spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
  _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);

  if(istrue(self.squadwiped)) {
    self.squadwiped = 0;

    if(_id_652F47620AC4713F > 1 && !_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      scripts\mp\hud_message::showsplash("bm_your_squad_wiped");
  }

  if(_id_5BAB271917698DC4::isteamextracted(self.team)) {
    return;
  }
  if(istrue(self.hasrespawntoken)) {
    thread _id_5BAB271917698DC4::triggerrespawnoverlay(4);
    self.tokenrespawned = 1;
    _id_7E52B56769FA7774::removerespawntoken();
  }

  if(_id_5BAB271917698DC4::isteamextracted(self.team)) {
    return;
  }
  if(getdvarint("scr_skip_respawn_gate", 1) == 0)
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();

  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.intermissionspawnorigin = undefined;
  self.intermissionspawntime = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer();

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && isDefined(level.player_respawn_struct))
    spawnpoint = scripts\engine\utility::getStruct(level.player_respawn_struct, "targetname");

  _id_67708F418B1FAC79::gulagwinnerrespawn(1, undefined, spawnpoint, 1, _id_11F3B4465C8B637B, 1);
  _id_0A34750D17473C49::unmarkplayeraseliminated(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_B092E3259EC308D8");
}

playershouldrespawn(data) {
  return 1;
}

updateprestreamrespawn() {
  self endon("disconnect");
  self endon("spawned_player");
  self endon("stop_updatePrestreamRespawn");

  for(;;) {
    if(scripts\engine\utility::ent_flag("playerRespawn_intermission_spawned")) {
      spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
      currenttime = gettime();

      if(distance2dsquared(self.intermissionspawnorigin, spawnpoint.origin) > 25000000) {
        self.intermissionspawnorigin = spawnpoint.origin;
        self.intermissionspawntime = currenttime;
        self setOrigin(spawnpoint.origin);
        _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
      }

      if(currenttime - self.intermissionspawntime >= getdvarfloat("dvar_57FBCC1BAE0F210A", 2.0) * 1000) {
        spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102(1);
        _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
      }
    } else {
      spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
      _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
    }

    wait 1.0;
  }
}

fadetogearingup(waittime, squadwiped) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned_player");
  self notify("fadeToGearingUp");
  self endon("fadeToGearingUp");

  if(isDefined(waittime) && waittime > 0)
    wait(waittime);

  _id_B59F471C2C064E56 = 1.0;
  thread _id_5BAB271917698DC4::fadeoutin(_id_B59F471C2C064E56);
  wait(_id_B59F471C2C064E56 - 0.25);

  if(istrue(squadwiped))
    self setclientomnvar("ui_br_transition_type", 6);
  else
    self setclientomnvar("ui_br_transition_type", 2);

  wait 0.25;

  if(getdvarint("dvar_F006294EF8B720A4", 1) == 1) {
    _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
    spawnpoint = _id_5BAB271917698DC4::_id_952548D8AED47102();
    _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
    _id_1E4A61DB11011446::spawnintermission(spawnpoint.origin, spawnpoint.angles);
    scripts\mp\spectating::setdisabled();
    self.intermissionspawnorigin = spawnpoint.origin;
    self.intermissionspawntime = gettime();
    scripts\engine\utility::ent_flag_set("playerRespawn_intermission_spawned");
  }
}

setupmission() {
  level.brgametype.extractposition = getextractionposition();
  thread makeextractionobjective();
}

getextractionposition() {
  _id_4BF102A2E23C6C84 = 2500;
  centerpt = level.br_level.br_mapcenter;
  _id_D8235976EA87D0D2 = (0, randomfloatrange(0, 360), 0);
  pathdir = anglesToForward(_id_D8235976EA87D0D2);
  _id_5619B7BBC3745888 = level.br_level.br_circleradii[0] * 2;
  endpt = centerpt + pathdir * _id_5619B7BBC3745888;
  endpt = _id_45B2B4A889E633FA::snappointtooutofboundstriggertrace(centerpt, endpt);
  _id_5FA1E1697A302583 = getEnt("airstrikeheight", "targetname");
  start = (endpt[0], endpt[1], _id_5FA1E1697A302583.origin[2]);
  _id_AA5A7071F7A4C106 = tracegroundpoint(start);
  endpt = _id_AA5A7071F7A4C106 + (0, 0, _id_4BF102A2E23C6C84);
  return endpt;
}

makeextractionobjective() {
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  level.brgametype.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "current", level.brgametype.extractposition, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  }
}

setupmissionwidget() {
  scripts\mp\flags::gameflagwait("prematch_done");
  xp = getcurrentxp();
  _id_2F55781AF96F22F9 = _id_64ACB6CE534155B7::getquesttableindex("gt_extract_1");

  foreach(player in level.players) {
    player _id_64ACB6CE534155B7::setquestindexomnvar(_id_2F55781AF96F22F9);
    player _id_64ACB6CE534155B7::uiobjectivesetparameter(xp);
  }
}

getcurrentxp() {
  xp = getdvarint("dvar_911E056FAB287A06", 5000);
  _id_01483BA069EB69DB = getdvarint("dvar_728F3C5D729A3F2D", 2000);
  _id_3AF7B46CFD065EBD = getdvarint("dvar_802CC155C089E133", 200);

  if(_id_01483BA069EB69DB > 0)
    xp = int(max(_id_01483BA069EB69DB, xp - level.brgametype.numextractions * _id_3AF7B46CFD065EBD));

  return xp;
}

showextractionobjectivetoteam(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.brgametype.objectiveiconid, player);
}

hideextractionobjectivefromteam(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(level.brgametype.objectiveiconid, player);
}

doteamextractedupdate() {
  level.brgametype.numextractions++;
  level.brgametype.hudextractnum setvalue(level.brgametype.numextractions);
  level.brgametype.hudextractnum thread huddopulse();
  level.brgametype.hudextractmax thread huddopulse();
  cost = getcost();
  level.brgametype.hudcost setvalue(cost);

  foreach(_id_F90358454413407F, teamdata in level.teamdata) {
    if(isDefined(teamdata["teamCount"]) && teamdata["teamCount"] > 0)
      updateteamplunderhud(_id_F90358454413407F);
  }

  xp = getcurrentxp();

  foreach(player in level.players) {
    if(!_id_5BAB271917698DC4::isteamextracted(player.team)) {
      player thread scripts\mp\hud_message::showsplash("br_gametype_extract_extracted");
      player _id_64ACB6CE534155B7::uiobjectivesetparameter(xp);
    }
  }
}

brendgame() {
  wait 1.5;
  handleendgamesplash();
  scripts\mp\gamelogic::endgame_regularmp(level.brgametype.firstteam, game["end_reason"]["objective_completed"], game["end_reason"]["br_eliminated"]);
}

handleendgamesplash() {
  foreach(player in level.players) {
    if(!_id_5BAB271917698DC4::isteamextracted(player.team))
      player setclientomnvar("post_game_state", 2);
  }
}

setuptimelimit() {
  level endon("game_ended");
  _id_B0FCA93213E625C7 = 120;
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled))
    level waittill("br_ready_to_jump");

  waitframe();
  _id_ABF148B8B3FE55C6 = createhudelem(&"MP_BR_INGAME/EXTRACT_COLLECT_PLUNDER", undefined, "CENTER", "CENTER", 0, -170);
  _id_ABF148B8B3FE55C6.alpha = 1;
  timerhud = scripts\mp\hud_util::createservertimer("default", 1.5);
  timerhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -150);
  _id_D7DAA4EEE8E4BD3C = getdvarint("dvar_A718BF7355E667A3", 180);

  if(_id_D7DAA4EEE8E4BD3C > 0) {
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_D7DAA4EEE8E4BD3C * 1000));
    timerhud settimer(_id_D7DAA4EEE8E4BD3C);
    wait(_id_D7DAA4EEE8E4BD3C);
  }

  scripts\mp\flags::gameflagset("collect_done");
  _id_532C835E523EF572 = getdvarint("dvar_9FD551B851144F28", 180);

  if(_id_532C835E523EF572 > 0) {
    _id_ABF148B8B3FE55C6.label = &"MP_BR_INGAME/EXTRACT_HELIPADS_ACTIVE";
    _id_ABF148B8B3FE55C6 thread huddopulse();
    setomnvar("ui_hardpoint_timer", gettime() + int(_id_532C835E523EF572 * 1000));
    timerhud settimer(_id_532C835E523EF572);
    wait(_id_532C835E523EF572);
  }

  scripts\mp\flags::gameflagset("helipad_wait_done");
  _id_F8DD42F6BC48954B = getdvarint("dvar_DB683ED24A430594", 840);
  _id_ABF148B8B3FE55C6.label = &"MP_BR_INGAME/EXTRACT_HELIPAD";
  _id_ABF148B8B3FE55C6 thread huddopulse();
  setomnvar("ui_hardpoint_timer", gettime() + int(_id_F8DD42F6BC48954B * 1000));
  timerhud settimer(_id_F8DD42F6BC48954B);
  _id_0098EE5131DA5693 = max(_id_F8DD42F6BC48954B - _id_B0FCA93213E625C7, 0);
  wait(_id_0098EE5131DA5693);
  _id_8DD9F2EB8215A139 = max(_id_F8DD42F6BC48954B - _id_0098EE5131DA5693, 0);
  timerhud.color = (1, 0, 0);
  timerhud thread huddopulse();
  thread clocksounds(_id_8DD9F2EB8215A139);
  wait(_id_8DD9F2EB8215A139);
  timerhud destroy();
  thread brendgame();
}

clocksounds(_id_8DD9F2EB8215A139) {
  level endon("game_ended");

  while(_id_8DD9F2EB8215A139 > 0) {
    dosound = 0;
    _id_14CCD6E81FCE3BD4 = scripts\mp\gamelogic::getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);

    if(_id_8DD9F2EB8215A139 > 60 && _id_8DD9F2EB8215A139 % 10 == 0 || _id_8DD9F2EB8215A139 <= 60 && _id_8DD9F2EB8215A139 > 30 && _id_8DD9F2EB8215A139 % 2 == 0 || _id_8DD9F2EB8215A139 <= 30)
      dosound = 1;

    if(dosound) {
      foreach(player in level.players)
      player playlocalsound(_id_14CCD6E81FCE3BD4);
    }

    _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 - 1;
    wait 1;
  }
}

setupteamplunderhud() {
  _id_D1F0E5189F1576D0 = 155;
  _id_A1CA4DAA7621C02F = 15;
  _id_B4C134E149B2E70B = -3;
  _id_D2C8C88F6FF982FA = 3;

  if(level.teamplunderscoremechanic) {
    cost = getwincost();
    text = &"MP_BR_INGAME/WIN_COST_TEXT";
    hudcost = cost;
  } else {
    cost = getcost();
    text = &"MP_BR_INGAME/EXTRACT_COST_TEXT";
    hudcost = cost;
  }

  level.brgametype.hudcoststring = createhudelem(text, undefined, "LEFT", "CENTER", _id_D2C8C88F6FF982FA, _id_D1F0E5189F1576D0, undefined, undefined, 1);
  level.brgametype.hudcost = createhudelem(&"MP_BR_INGAME/EXTRACT_COST_MILLION", undefined, "LEFT", "CENTER", 65 + _id_D2C8C88F6FF982FA, _id_D1F0E5189F1576D0, undefined, undefined, 1);
  level.brgametype.hudplunderstring = createhudelem(&"MP_BR_INGAME/YOUR_TEAM_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", 5 + _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0, undefined, undefined, 1);
  _id_A7F7937DC17270C2 = 0;
  level.brgametype.leaderplunderstring = createhudelem(&"MP_BR_INGAME/LEADER_PLUNDER_TEXT", _id_A7F7937DC17270C2, "CENTER", "CENTER", 0, _id_D1F0E5189F1576D0 + _id_A1CA4DAA7621C02F, undefined, undefined, 1);

  foreach(team in level.teamnamelist) {
    _id_6CBD49DBEF63E930 = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER", 0, "RIGHT", "CENTER", 70 + _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0, undefined, team, 1);
    _id_A6C3DE7CC9CED93D = createhudelem(&"MP_BR_INGAME/ST_PLACE", undefined, "RIGHT", "CENTER", -65 + _id_B4C134E149B2E70B, _id_D1F0E5189F1576D0, undefined, team, 1);
    _id_A6C3DE7CC9CED93D setvalue(1);
    _id_6CBD49DBEF63E930.placement = _id_A6C3DE7CC9CED93D;
    setteamplunderhud(team, _id_6CBD49DBEF63E930);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level.br_infils_disabled))
    level waittill("br_ready_to_jump");

  level.brgametype.hudcoststring.alpha = 1;
  level.brgametype.hudcost.alpha = 1;
  level.brgametype.hudplunderstring.alpha = 1;
  level.brgametype.leaderplunderstring.alpha = 1;

  foreach(team in level.teamnamelist) {
    _id_6CBD49DBEF63E930 = getteamtokenshud(team);
    _id_6CBD49DBEF63E930.alpha = 1;
    _id_6CBD49DBEF63E930.placement.alpha = 1;
  }
}

setteamplunderhud(team, _id_94480E1669B7FF0D) {
  level.teamdata[team]["hudPlunder"] = _id_94480E1669B7FF0D;
  _id_94480E1669B7FF0D.risktokencount = 0;
  _id_94480E1669B7FF0D.risktokencountroll = 0;
}

getteamtokenshud(team) {
  return level.teamdata[team]["hudPlunder"];
}

createhudelem(label, value, point, relativepoint, xoffset, yoffset, color, team, fontscale, player) {
  if(!isDefined(fontscale))
    fontscale = 1.5;

  if(isDefined(team))
    _id_372B658AEA9D2487 = newteamhudelem(team);
  else if(isDefined(player))
    _id_372B658AEA9D2487 = newclienthudelem(player);
  else
    _id_372B658AEA9D2487 = newhudelem();

  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = "default";
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.alpha = 0;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label))
    _id_372B658AEA9D2487.label = label;

  if(isDefined(value))
    _id_372B658AEA9D2487 setvalue(value);

  if(isDefined(color))
    _id_372B658AEA9D2487.color = color;

  return _id_372B658AEA9D2487;
}

getteamtokens(team) {
  _id_DA382C87BD272CCB = 0;

  if(!level.scorerequiresbanking) {
    _id_DA382C87BD272CCB = _id_DA382C87BD272CCB + level.teamdata[team]["tokensTeamTotal"];
    _id_DA382C87BD272CCB = _id_DA382C87BD272CCB + level.teamdata[team]["tokensInDeposit"];
  }

  _id_DA382C87BD272CCB = _id_DA382C87BD272CCB + level.teamdata[team]["tokensBanked"];
  return _id_DA382C87BD272CCB;
}

getteamcarriedplunder(team) {
  return level.teamdata[team]["tokensTeamTotal"];
}

getbankedplunder(team) {
  return level.teamdata[team]["tokensBanked"];
}

sortplayerplunderscores(_id_C2B61E43FA917C18, _id_C2B62143FA9182B1) {
  return _id_C2B61E43FA917C18 > _id_C2B62143FA9182B1;
}

hackclientomnvarclamp(omnvar, val) {
  _id_68A4063209579D4F = int(min(val, 131072));
  self setclientomnvar(omnvar, _id_68A4063209579D4F);
}

hackomnvarclamp(omnvar, val) {
  _id_68A4063209579D4F = int(min(val, 131072));
  setomnvar(omnvar, _id_68A4063209579D4F);
}

plunderrankupdate() {
  level endon("game_ended");
  _id_61A13391E0337903 = 0;
  _id_5A1B98786F638BB3 = [];
  _id_53BA034CDC687F01 = 0;
  _id_9D41C15DC3DFA5E4 = 0;
  _id_0556E0039A439CD2 = 0;
  _id_73F830DB146A9277 = 0;
  _id_AD5E6D3E7E4CC004 = 0;
  _id_F6780228EC69F8D5 = 0;
  _id_39926F7B2DE6C632 = level.hideleaderhashuntilpercent != 0;
  level.splashtime_vip = undefined;
  level.splashtime_lzs = undefined;
  level.splashtime_drops = undefined;
  level.splashtime_helis = undefined;

  for(;;) {
    waittillframeend;
    _id_20085F3D87BAC60B = level.called50percentprogress && level.called75percentprogress && level.called90percentprogress;
    _id_4E21022C04D88E00 = getwincost();
    _id_61A13391E0337903 = _id_61A13391E0337903 + level.framedurationseconds;

    if(istrue(level.usemilestonephases))
      _id_1910592D7CD985FE = scripts\mp\flags::gameflag("placement_updates_allowed");
    else
      _id_1910592D7CD985FE = _id_61A13391E0337903 > level.secondsbeforeplacementupdates;

    _id_9C81A0995E8F1C76 = level.showplacementsplashesandmusic && _id_1910592D7CD985FE;
    _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
    _id_89F63B69F41AD35A = level.teamplunderscoremechanic;
    _id_0745AE0B656709A1 = undefined;
    _id_073D1D0B655DDF10 = undefined;
    _id_0734360B6553F75D = undefined;
    _id_44578707AF5385CE = [];
    _id_87B32CCA2597530F = [];
    _id_E3759B02F55695C2 = [];
    _id_EC15CE3E7A9D1D86 = "none";
    _id_276B54E205081271 = "none";
    _id_963524745F704899 = -1;
    _id_8ACBB0D8AC1FC9FA = -1;

    foreach(team in level.teamnamelist) {
      _id_DA382C87BD272CCB = getteamtokens(team);
      _id_6D2F3C5E7285F710 = getbankedplunder(team);
      _id_3777ECE6A73EADA5 = updateteamplunderscore(_id_DA382C87BD272CCB, team, level.brgametype.firstteam);
      _id_BA2432A58DD7EBD3 = getpreviousplacement(team);
      placement = _id_C3E10A42A81ADE25[team];

      if(_id_DA382C87BD272CCB > _id_963524745F704899) {
        if(_id_963524745F704899 > _id_8ACBB0D8AC1FC9FA) {
          _id_8ACBB0D8AC1FC9FA = _id_963524745F704899;
          _id_276B54E205081271 = _id_EC15CE3E7A9D1D86;
        }

        _id_963524745F704899 = _id_DA382C87BD272CCB;
        _id_EC15CE3E7A9D1D86 = team;
      } else if(_id_EC15CE3E7A9D1D86 != "none") {
        if(_id_DA382C87BD272CCB > _id_8ACBB0D8AC1FC9FA) {
          _id_8ACBB0D8AC1FC9FA = _id_DA382C87BD272CCB;
          _id_276B54E205081271 = team;
        }
      }

      _id_BC8FBD02E2C5E2B8 = _id_DA382C87BD272CCB;
      total = _id_DA382C87BD272CCB;
      _id_D8FED4D7AD83256A = 0;

      if(_id_BC8FBD02E2C5E2B8 < 0)
        _id_BC8FBD02E2C5E2B8 = 0;

      if(total >= _id_4E21022C04D88E00 * 0.9)
        _id_0745AE0B656709A1 = team;
      else if(total >= _id_4E21022C04D88E00 * 0.75)
        _id_073D1D0B655DDF10 = team;
      else if(total >= _id_4E21022C04D88E00 * 0.5)
        _id_0734360B6553F75D = team;

      if(total >= _id_4E21022C04D88E00 * level.plundermusicfourth)
        thread scripts\mp\music_and_dialog::plunder_ninetypercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicthird)
        thread scripts\mp\music_and_dialog::plunder_seventyfivepercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicsecond)
        thread scripts\mp\music_and_dialog::plunder_fiftypercent_music();
      else if(total >= _id_4E21022C04D88E00 * level.plundermusicfirst)
        thread scripts\mp\music_and_dialog::plunder_thirtypercent_music();

      players = scripts\mp\utility\teams::getfriendlyplayers(team, 0);

      foreach(player in players) {
        placement = _id_C3E10A42A81ADE25[player.team];

        if(!_id_AD5E6D3E7E4CC004)
          placement = 155;

        player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_team_placement", placement);
        player scripts\cp_mp\utility\omnvar_utility::setcachedclientomnvar("ui_br_player_position", placement);
        player hackclientomnvarclamp("ui_br_team_cash_banked", int(_id_D8FED4D7AD83256A));
        player hackclientomnvarclamp("ui_br_team_cash_pockets", int(_id_BC8FBD02E2C5E2B8));
        _id_87B32CCA2597530F[player.guid] = player.risktokencount;
        _id_E3759B02F55695C2[player.guid] = player;
      }

      if(_id_9C81A0995E8F1C76) {
        if(placement == 1)
          _id_44578707AF5385CE[_id_44578707AF5385CE.size] = team;
        else if(placement <= 5) {
          if(_id_BA2432A58DD7EBD3 > 5)
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_5");
        } else if(placement <= 10) {
          if(_id_BA2432A58DD7EBD3 > 10)
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_10");
        }
      }

      if(total >= _id_4E21022C04D88E00) {
        autobankteamplunder(team);

        if(_id_89F63B69F41AD35A && level.doendofmatchotsequence > 0 && !level.disablewinonscore) {
          level thread triggerovertimetimer(team, level.teamdata[team]["tokensBanked"] >= _id_4E21022C04D88E00);
          continue;
        }

        if(_id_89F63B69F41AD35A && level.doendofmatchotsequence > 0 && level.disablewinonscore) {
          level.initialwinningteam = team;
          continue;
        }

        if(level.teamplunderexfil && !istrue(level.exfilactive)) {
          level.exfilactive = 1;
          level thread startbmoexfilprocess(team);
          continue;
        }

        if(!level.teamplunderexfil && _id_89F63B69F41AD35A && !level.disablewinonscore)
          level thread givewincondition(team);
      }
    }

    _id_DDD20D819A369A7D = [];
    _id_348AB76F83B33509 = [];

    if(level.lootleadermarksontopteams == 1)
      _id_DDD20D819A369A7D = tablesort(game["teamPlacements"], "up");
    else if(level.lootleadermarksontopteams == 2) {
      _id_DDD20D819A369A7D[0] = _id_EC15CE3E7A9D1D86;
      _id_348AB76F83B33509 = tablesort(_id_87B32CCA2597530F, "down");
    } else
      _id_348AB76F83B33509 = tablesort(_id_87B32CCA2597530F, "down");

    level.brgametype.firstteam = _id_EC15CE3E7A9D1D86;

    if(_id_EC15CE3E7A9D1D86 == "none") {
      _id_5A1B98786F638BB3 = [];
      waitframe();
      continue;
    }

    if(_id_276B54E205081271 != "none")
      hackomnvarclamp("ui_br_cash_second", int(_id_8ACBB0D8AC1FC9FA));

    hackomnvarclamp("ui_br_cash_leader", int(_id_963524745F704899));

    if(!_id_39926F7B2DE6C632 && _id_963524745F704899 >= _id_4E21022C04D88E00 * level.hideleaderhashuntilpercent * 0.1) {
      setomnvar("ui_br_leader_hash_percentage_hit", 1);
      _id_39926F7B2DE6C632 = 1;
    }

    if(!istrue(_id_F6780228EC69F8D5) && istrue(level.usemilestonephases)) {
      if(!_id_53BA034CDC687F01 && level.milestonephasepercent_vips > 0 && _id_963524745F704899 >= level.milestonephasepercent_vips) {
        _id_53BA034CDC687F01 = 1;
        level.splashtime_vip = gettime();
        scripts\mp\flags::gameflagset("placement_updates_allowed");

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          scripts\mp\hud_util::showsplashtoall("bm_vips_marked");
      }

      if(!_id_9D41C15DC3DFA5E4 && (level.scorerequiresbanking || level.milestonephasepercent_lzs > 0 && _id_963524745F704899 >= level.milestonephasepercent_lzs)) {
        _id_9D41C15DC3DFA5E4 = 1;
        level.splashtime_lzs = gettime();
        scripts\mp\flags::gameflagset("activate_cash_lzs");

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          _id_2CEDCC356F1B9FC8::brleaderdialog("extract_enabled", 0, undefined, undefined, undefined, "bm");
      }

      if(!_id_0556E0039A439CD2 && level.milestonephasepercent_drops > 0 && _id_963524745F704899 >= level.milestonephasepercent_drops) {
        _id_0556E0039A439CD2 = 1;
        level.splashtime_drops = gettime();
        level.br_level.c130_speedoverride = 3044;
        scripts\mp\flags::gameflagset("activate_cash_drops");
      }

      if(!_id_73F830DB146A9277 && (istrue(level.bmoovertime) || level.milestonephasepercent_helis > 0 && _id_963524745F704899 >= level.milestonephasepercent_helis)) {
        _id_73F830DB146A9277 = 1;
        level.splashtime_helis = gettime();
        scripts\mp\flags::gameflagset("activate_cash_helis");

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          _id_2CEDCC356F1B9FC8::brleaderdialog("event_chopper", 0, undefined, undefined, undefined, "bm");
      }

      if(!_id_AD5E6D3E7E4CC004 && _id_963524745F704899 >= _id_4E21022C04D88E00 * level.hideplacementuntilpercent * 0.01)
        _id_AD5E6D3E7E4CC004 = 1;

      if(_id_53BA034CDC687F01 && _id_9D41C15DC3DFA5E4 && _id_0556E0039A439CD2 && _id_73F830DB146A9277)
        _id_F6780228EC69F8D5 = 1;
    }

    if(!_id_9C81A0995E8F1C76 || _id_963524745F704899 == 0) {
      waitframe();
      continue;
    }

    if(level.lootleadermarksontopteams > 0) {
      if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
        updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2, _id_DDD20D819A369A7D);
        level.plunderupdatelootleadermarks = 0;
      }
    } else if(level.dmzlootleaderupdateonpickup || istrue(level.plunderupdatelootleadermarks)) {
      updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2);
      level.plunderupdatelootleadermarks = 0;
    }

    foreach(team in _id_44578707AF5385CE) {
      if(!scripts\engine\utility::array_contains(_id_5A1B98786F638BB3, team)) {
        if(istrue(level.topteamsever[team])) {
          if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
            scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team_regained");

          continue;
        }

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
          scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team");

        level.topteamsever[team] = 1;
      }
    }

    if(_id_44578707AF5385CE.size > 0) {
      foreach(team in _id_5A1B98786F638BB3) {
        if(!scripts\engine\utility::array_contains(_id_44578707AF5385CE, team))
          scripts\mp\hud_util::showsplashtoteam(team, "bm_top_team_lost");
      }
    }

    _id_5A1B98786F638BB3 = _id_44578707AF5385CE;
    level.topteam = _id_EC15CE3E7A9D1D86;
    level.previousplacements = _id_C3E10A42A81ADE25;

    if(!_id_20085F3D87BAC60B) {
      if(!level.called90percentprogress && isDefined(_id_0745AE0B656709A1)) {
        level.called90percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_0745AE0B656709A1, "bm_first_to_90_them");
            scripts\mp\hud_util::showsplashtoteam(_id_0745AE0B656709A1, "bm_first_to_90_us");
            level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_90_perc_first", _id_0745AE0B656709A1, 1, undefined, "bm");

            foreach(_id_F90358454413407F in level.teamnamelist) {
              if(_id_F90358454413407F != _id_0745AE0B656709A1)
                level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_90_perc_enemy", _id_F90358454413407F, 1, undefined, "bm");
            }
          }
        }
      } else if(!level.called75percentprogress && isDefined(_id_073D1D0B655DDF10)) {
        level.called75percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_073D1D0B655DDF10, "bm_first_to_75_them");
            scripts\mp\hud_util::showsplashtoteam(_id_073D1D0B655DDF10, "bm_first_to_75_us");
            level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_75_perc_first", _id_073D1D0B655DDF10, 1, undefined, "bm");

            foreach(_id_F90358454413407F in level.teamnamelist) {
              if(_id_F90358454413407F != _id_073D1D0B655DDF10)
                level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_75_perc_enemy", _id_F90358454413407F, 1, undefined, "bm");
            }
          }
        }
      } else if(!level.called50percentprogress && isDefined(_id_0734360B6553F75D)) {
        level.called50percentprogress = 1;

        if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
          if(!level.disablepercentageannouncements) {
            scripts\mp\hud_util::showsplashtoallexceptteam(_id_0734360B6553F75D, "bm_first_to_50_them");
            scripts\mp\hud_util::showsplashtoteam(_id_0734360B6553F75D, "bm_first_to_50_us");
            level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_50_perc_first", _id_0734360B6553F75D, 1, undefined, "bm");

            foreach(_id_F90358454413407F in level.teamnamelist) {
              if(_id_F90358454413407F != _id_0734360B6553F75D)
                level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("gamestate_50_perc_enemy", _id_F90358454413407F, 1, undefined, "bm");
            }
          }
        }
      }
    }

    waitframe();
  }
}

autobankteamplunder(team) {
  if(!isDefined(level.autobankedteams))
    level.autobankedteams = [];

  if(scripts\engine\utility::array_contains(level.autobankedteams, team)) {
    return;
  }
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  data = _id_6AFF3948CF4CCA03::createplayerplundereventdata();
  data.playanimation = 0;

  foreach(player in players) {
    if(isDefined(player.risktokencount) && player.risktokencount > 0)
      player _id_6AFF3948CF4CCA03::playerplunderbank(player.risktokencount, undefined, data);
  }

  level.autobankedteams[level.autobankedteams.size] = team;
}

overtimecashmultiplier() {
  level thread _id_6AFF3948CF4CCA03::processcashpileovertimemultiplier(level.overtimecashmultiplier);
}

placementupdatewait() {
  scripts\mp\flags::gameflagwait("prematch_done");

  if(isDefined(level.secondsbeforeplacementupdates))
    wait(level.secondsbeforeplacementupdates);

  scripts\mp\flags::gameflagset("placement_updates_allowed");
}

getpreviousplacement(team) {
  if(isDefined(level.previousplacements))
    return level.previousplacements[team];

  return -1;
}

triggermatchendtimer(endtime) {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  timelimit = getdvarfloat("dvar_4DCBFF985E3E175E", 10);
  _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
  level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
  level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;
}

updateteamplunderhud(team) {
  _id_6CBD49DBEF63E930 = getteamtokenshud(team);
  _id_DA382C87BD272CCB = getteamtokens(team);
  cost = getcost();

  if(_id_DA382C87BD272CCB >= cost && _id_6CBD49DBEF63E930.color != (0, 1, 0)) {
    _id_6CBD49DBEF63E930.color = (0, 1, 0);
    _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

    foreach(player in _id_6D5ED003AF1F9612)
    player playlocalsound("br_plunder_atm_deposit_gtr");
  }
}

dohudplunderrollsound(sign, team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(sign > 0) {
      if(isDefined(player.hudplunderstart)) {
        duration = gettime() - player.hudplunderstart;

        if(duration <= 6000) {
          break;
        }
      }

      player.hudplunderstart = gettime();

      if(isalive(player))
        player playlocalsound("br_plunder_atm_use");

      continue;
    }

    player.hudplunderstart = undefined;
    player stoplocalsound("br_plunder_atm_use");
  }
}

givewincondition(_id_65669339223F29B4) {
  if(istrue(level.triggeredwincondition)) {
    return;
  }
  if(!istrue(level.triggeredwincondition))
    level thread printallteamsplundercount();

  level.triggeredwincondition = 1;
  level thread scripts\mp\gamelogic::endgame(_id_65669339223F29B4, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
}

onplayerconnectrisk(player) {
  player.risktokencount = 0;
}

playerdropplunderondeath(dropstruct, attacker) {
  if(isDefined(self.c130))
    return 1;

  if(istrue(level.gameended))
    return 1;

  _id_6FD51A373B60733F = 0;
  _id_C3FD9DD55583488F = 0;

  if(istrue(self.isdisconnecting)) {
    _id_C3FD9DD55583488F = self.risktokencount;
    _id_6FD51A373B60733F = self.risktokencount;
    _id_A9E2BBA76FA7110F = 0;
  } else if(self.risktokencount > 0) {
    if(isDefined(level.mintokensdropondeath) && self.risktokencount < level.mintokensdropondeath) {
      _id_A9E2BBA76FA7110F = level.risktokenstokeep;
      _id_C3FD9DD55583488F = max(self.risktokencount - level.risktokenstokeep, 0);
      _id_6FD51A373B60733F = max(self.risktokencount - level.risktokenstokeep, 0);
    } else {
      _id_A9E2BBA76FA7110F = int(self.risktokencount * ((100 - level.percentagetokensdrop) * 0.01)) + level.risktokenstokeep;
      _id_C3FD9DD55583488F = self.risktokencount - _id_A9E2BBA76FA7110F;
      _id_6FD51A373B60733F = _id_C3FD9DD55583488F;
    }

    if(istrue(level.bmoovertime)) {
      if(_id_C3FD9DD55583488F <= level.bonusdeathplunderot && (!isDefined(attacker) || attacker != self))
        _id_C3FD9DD55583488F = level.bonusdeathplunderot;
    }

    if(isDefined(level.maxtokensdropondeath)) {
      if(_id_C3FD9DD55583488F >= level.maxtokensdropondeath) {
        _id_C3FD9DD55583488F = level.maxtokensdropondeath;
        _id_6FD51A373B60733F = _id_C3FD9DD55583488F;
        _id_A9E2BBA76FA7110F = self.risktokencount - level.maxtokensdropondeath;
      }
    }
  } else
    _id_A9E2BBA76FA7110F = 0;

  self.risktokencount = _id_A9E2BBA76FA7110F;
  level.teamdata[self.team]["tokensTeamTotal"] = level.teamdata[self.team]["tokensTeamTotal"] - _id_C3FD9DD55583488F;
  self.risktokencountondeath = _id_A9E2BBA76FA7110F;

  if(_id_6FD51A373B60733F > 0)
    _id_6AFF3948CF4CCA03::playerplunderdrop(_id_6FD51A373B60733F);

  if(_id_C3FD9DD55583488F >= level.plunderfxondropthreashold)
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 32));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C3FD9DD55583488F; _id_AC0E594AC96AA3A8++)
    level spawnrisktoken(self, self.team);

  _id_025AB205B30A2556 = _id_C3FD9DD55583488F;

  if(istrue(self.wasexecuted))
    _id_025AB205B30A2556 = int(_id_C3FD9DD55583488F * level.executioncashmultiplier);

  _id_06E6597D420349B5 = _id_025AB205B30A2556;

  if(istrue(level.bmoovertime) && (!isDefined(attacker) || self != attacker)) {
    _id_06E6597D420349B5 = int(_id_025AB205B30A2556 * level.overtimecashmultiplier);

    if(isDefined(level.maxplunderdropinovertime) && _id_06E6597D420349B5 > level.maxplunderdropinovertime)
      _id_06E6597D420349B5 = level.maxplunderdropinovertime;
  }

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF() && istrue(self.cashtorefund))
    _id_06E6597D420349B5 = int(_id_06E6597D420349B5 + self.cashtorefund);

  _id_E05413A53B5D9167 = dropplunderbyrarity(_id_06E6597D420349B5, dropstruct);

  foreach(ent in _id_E05413A53B5D9167)
  ent.lootsource = "combat";

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
    level notify("victim_death_drop", self, attacker, _id_E05413A53B5D9167);

  if(isDefined(attacker) && self == attacker || !level.killcam)
    self setclientomnvar("ui_cash_dropped", _id_6FD51A373B60733F);
  else
    self.postkillcamplunderlost = _id_6FD51A373B60733F;

  _id_715028F54BAD19A1::trackcashevent(self, "combat", _id_6FD51A373B60733F * -1);

  if(isDefined(level.lootleaders) && scripts\engine\utility::array_contains(level.lootleaders, self))
    playFX(scripts\engine\utility::getfx("money"), self.origin + (0, 0, 64));

  return 1;
}

onpostkillcamcallback() {
  if(isDefined(self.postkillcamplunderlost)) {
    self setclientomnvar("ui_cash_dropped", int(self.postkillcamplunderlost));
    self.postkillcamplunderlost = undefined;
  }
}

dropplunderbyrarity(amount, dropstruct) {
  if(!istrue(level.br_plunder_enabled)) {
    return;
  }
  _id_E05413A53B5D9167 = [];
  _id_E3232613C46AEB6B = [];
  _id_EE9DE3C34A771918 = 0;

  for(_id_AC0E594AC96AA3A8 = level.br_plunder.quantity.size - 1; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--) {
    _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] = int(amount / level.br_plunder.quantity[_id_AC0E594AC96AA3A8]);
    _id_EE9DE3C34A771918 = _id_EE9DE3C34A771918 + _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8];

    if(amount <= 0) {
      break;
    } else
      amount = amount - _id_E3232613C46AEB6B[_id_AC0E594AC96AA3A8] * level.br_plunder.quantity[_id_AC0E594AC96AA3A8];
  }

  for(_id_F90D0E006A1F717B = level.br_plunder.quantity.size - 1; _id_F90D0E006A1F717B >= 0; _id_F90D0E006A1F717B--) {
    if(!isDefined(_id_E3232613C46AEB6B[_id_F90D0E006A1F717B])) {
      continue;
    }
    for(_id_3793828403C6873E = 0; _id_3793828403C6873E < _id_E3232613C46AEB6B[_id_F90D0E006A1F717B]; _id_3793828403C6873E++) {
      [droporigin, dropangles, _id_A6717FAE5964E4C6] = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
      pickupent = _id_7E52B56769FA7774::spawnpickup(level.br_plunder.names[_id_F90D0E006A1F717B], droporigin, dropangles, level.br_plunder.quantity[_id_F90D0E006A1F717B], 1, _id_A6717FAE5964E4C6);
      _id_6AFF3948CF4CCA03::modify_plunder_itemsinworld(level.br_plunder.names[_id_F90D0E006A1F717B], 1);

      if(isDefined(pickupent)) {
        _id_E05413A53B5D9167[_id_E05413A53B5D9167.size] = pickupent;

        if(_id_6AFF3948CF4CCA03::inplunderlivelobby())
          level.br_plunder_ents[level.br_plunder_ents.size] = pickupent;
      }
    }
  }

  level.br_plunder.plunder_items_dropped = level.br_plunder.plunder_items_dropped + _id_EE9DE3C34A771918;
  level.br_plunder.plunder_value_dropped = level.br_plunder.plunder_value_dropped + amount;
  level thread _id_6AFF3948CF4CCA03::dropplundersounds(self.origin, _id_E05413A53B5D9167.size);
  return _id_E05413A53B5D9167;
}

getcost() {
  if(level.dmzminextractcost > 0)
    cost = int(max(level.dmzminextractcost, level.dmzextractcost - level.brgametype.numextractions * level.dmzextractcostdecrease));

  return level.dmzextractcost;
}

getwincost() {
  return level.dmzwincost;
}

playertakeextractionplunder(amount) {
  if(self.risktokencount < amount)
    amount = self.risktokencount;

  if(!isDefined(self.plunderforextract))
    self.plunderforextract = 0;

  self.plunderforextract = self.plunderforextract + amount;
  _id_6AFF3948CF4CCA03::playersetplundercount(self.risktokencount - amount);
  return amount;
}

teamclearextractplunder(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612)
  player.plunderforextract = 0;
}

teamrefundplunder(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player.plunderforextract)) {
      player _id_6AFF3948CF4CCA03::playerplunderpickup(player.plunderforextract);
      player.plunderforextract = 0;
      player iprintlnbold("Extraction refunded, chopper shot down.");
    }
  }
}

huddopulse() {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 4;
  self.pulsing = 1;
  _id_B96028986997E29C = self.fontscale;
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_5F2809F4E8852C13;
  wait(_id_CC2C2F3EAC3C7BD2);
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_B96028986997E29C;
  self.pulsing = undefined;
}

drophelicrate(heli) {
  crate = spawn("script_model", heli.origin);
  crate setModel("military_skyhook_backpack");
  _id_D917428537562C1F = heli.origin;
  end = (_id_D917428537562C1F[0], _id_D917428537562C1F[1], -12000);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 0);
  trace = scripts\engine\trace::ray_trace(_id_D917428537562C1F, end, heli, contents);
  _id_01230EA36A300368 = trace["position"];
  dist = _id_D917428537562C1F[2] - _id_01230EA36A300368[2];

  if(dist > 0) {
    time = sqrt(2 * dist / 800);
    crate moveTo(_id_01230EA36A300368, time, time, 0);
    wait(time);
  }

  crate.origin = _id_01230EA36A300368;
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact_ground"), _id_01230EA36A300368);
  crate cratedropplunder();
  crate delete();
}

cratedropplunder() {
  amount = getcost();
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_6AFF3948CF4CCA03::dropplunderbyrarity(amount, dropstruct);
}

calculatehelitimetoflysec(_id_C45865D4C48493C1, _id_88125F10D2B34AA3, _id_B2BDD90249635576) {
  _id_3D0EC1C05F1E1001 = _id_C45865D4C48493C1 * 0.0000157828;
  a = 0.5 * _id_B2BDD90249635576;
  b = _id_88125F10D2B34AA3;
  c = -1 * _id_3D0EC1C05F1E1001;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / (2 * a);
  flytime = flytime * 3600;
  flytime = flytime + 1.5;
  return flytime;
}

calculatehelitimetoarrive(_id_625180CE8D2F8F77) {
  _id_5301EBED8D610FDB = calculatehelitimetoflysec(30000, 100, 125);
  _id_EB0FAE3483A10D88 = calculatehelitimetoflysec(_id_625180CE8D2F8F77, 25.0, 31.25);
  totaltime = _id_5301EBED8D610FDB + _id_EB0FAE3483A10D88;
  return totaltime;
}

helisetteamextractionhud(state, _id_80B642A0F8C9659D) {
  _id_754110404C0D574F = gettime() + int(_id_80B642A0F8C9659D * 1000);
  _id_A6AB8D0FDA441DC2 = level.teamdata[self.team]["alivePlayers"];

  foreach(player in _id_A6AB8D0FDA441DC2) {
    player setclientomnvar("ui_br_plunder_extract_state", state);
    player setclientomnvar("ui_br_timed_feature_end_time", _id_754110404C0D574F);
  }
}

helibankplunder() {
  if(!isDefined(self.plunder)) {
    return;
  }
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_success", self.team, 1);
  _id_A8EEB94DCC610B78 = 0;
  _id_235F1174E9FAA6D2 = 0;

  foreach(item in self.plunder) {
    _id_A8EEB94DCC610B78 = _id_A8EEB94DCC610B78 + item.plundercount;

    if(item.player.team != self.team)
      _id_235F1174E9FAA6D2 = 1;
  }

  _id_715028F54BAD19A1::branalytics_plunder_extraction_success(self.plunder.size, _id_A8EEB94DCC610B78, "little_bird", _id_235F1174E9FAA6D2, self.endpoint);
  level.br_plunder.extraction_helicoptor_total_plunder = level.br_plunder.extraction_helicoptor_total_plunder + _id_A8EEB94DCC610B78;
  level.br_plunder.extraction_helicoptor_num_completed++;
  _id_6AFF3948CF4CCA03::entityplunderbankalldeposited();
}

heliusecleanup() {
  if(isDefined(self.usable)) {
    level.br_depots = scripts\engine\utility::array_remove(level.br_depots, self.usable);
    self.usable = undefined;
  }
}

helicleanupdepotonleaving(usable) {
  self.usable endon("death");
  scripts\engine\utility::waittill_either("leaving", "death");
  heliusecleanup();
}

helicreateextractvfx(position) {
  self.vfxent = spawn("script_model", position);
  self.vfxent setModel("scr_smoke_grenade");
  self.vfxent.angles = (0, 90, 90);
  self.vfxent playLoopSound("smoke_carepackage_smoke_lp");
  self.vfxent setscriptablepartstate("smoke", "on");
}

helicleanupextract(_id_7158BFC28B4BEA09) {
  if(isDefined(self.vfxent)) {
    self.vfxent stoploopsound();
    self.vfxent delete();
  }

  if(istrue(_id_7158BFC28B4BEA09) && isDefined(self.site))
    self.site setscriptablepartstate(self.site.type, self.site.activestate);
}

helidisapateextractvfx() {
  self endon("death");

  if(!isDefined(self.vfxent)) {
    return;
  }
  wait 5;
  self.vfxent endon("death");
  self.vfxent setscriptablepartstate("smoke", "dissipate");
  self.vfxent playSound("smoke_canister_tail_dissipate");
  wait 1;
  self.vfxent stoploopsound();
  wait 4.5;
  self.vfxent delete();
}

spawnheli(owner, pathstart, pathgoal, pathexit) {
  angles = vectortoangles(pathgoal - pathstart);
  numflares = 99;
  modelname = "veh8_mil_air_mindia8_plunder_x";

  if(istrue(level._id_A83A4E71446BFEF7))
    modelname = "veh9_mil_air_heli_blima_mp_x";

  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_apache_plunder_mp", modelname);

  if(!isDefined(heli)) {
    return;
  }
  endpoint = pathgoal * (1, 1, 0);
  heli.damagecallback = ::callback_vehicledamage;
  heli.speed = 50;
  heli.accel = 99999;
  heli.health = 1000;
  heli.maxhealth = heli.health;
  heli.team = owner.team;
  heli.owner = owner;
  heli.defendloc = pathgoal;
  heli.lifeid = 0;
  heli.flaresreservecount = numflares;
  heli.pathgoal = pathgoal;
  heli.pathexit = pathexit;
  heli.endpoint = endpoint;
  heli.goalyaw = angles[1];
  heli.vehiclename = "magma_plunder_chopper";
  heli setCanDamage(1);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(50, 100, 50);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);
  heli setotherent(owner);
  spawnrope(heli);
  heli thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(undefined, undefined);
  heli thread healdamage();
  heli thread handledestroydamage();
  heli thread helidestroyed();
  return heli;
}

spawnrope(heli) {
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("br_plunder_extraction_delivery_rope");
  rope linkTo(heli, "side_door_l_jnt", (11, 20, 42), (0, 180, 0));
  crate = spawn("script_model", (0, 0, 0));
  crate setModel("br_plunder_extraction_delivery_bag");
  crate linkTo(rope, "dyn_rope_end", (0, 0, 0), (0, 0, 0));
  heli.rope = rope;
  heli.crate = crate;
}

helidestroyed() {
  self endon("heli_gone");
  self endon("swapped");
  owner = self.owner;
  team = self.team;
  self waittill("death", attacker, meansofdeath, _id_06B62DB6EEC868E2, damagelocation);
  teamrefundplunder(team);
  helicleanup();

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.largeprojectiledamage) && !istrue(self.isdepot)) {
    self vehicle_setspeed(25, 5);
    thread helicrash(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  heliexplode(attacker);
}

helicleanup() {
  if(isDefined(self.rope))
    self.rope delete();

  if(isDefined(self.crate))
    self.crate delete();
}

heliexplode(attacker) {
  _id_240A4F3D560753FF = self gettagorigin("tag_origin") + (0, 0, 40);
  self radiusdamage(_id_240A4F3D560753FF, 256, 140, 70, attacker, "MOD_EXPLOSIVE");
  playFX(scripts\engine\utility::getfx("little_bird_explode"), _id_240A4F3D560753FF, anglesToForward(self.angles), anglestoup(self.angles));
  playsoundatpos(_id_240A4F3D560753FF, "veh_chopper_support_crash");
  earthquake(0.4, 800, _id_240A4F3D560753FF, 0.7);
  playrumbleonposition("grenade_rumble", _id_240A4F3D560753FF);
  physicsexplosionsphere(_id_240A4F3D560753FF, 500, 200, 1);
  self notify("explode");
  wait 0.35;
  level thread _id_1E4A61DB11011446::teamsplashbr("br_gametype_extract_heli_shot_down", self.owner, self.owner.team);
  helicleanupextract(1);
  helidelete();
}

helidelete() {
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

helicrash(speed) {
  self endon("explode");
  self notify("heli_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(speed, speed, speed);
  self settargetyaw(self.angles[1] + speed * 2.5);
}

handledestroydamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if((objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp") && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health) {
      callback_vehicledamage(attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname);
      helicleanupextract(1);
    }
  }
}

callback_vehicledamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner))
      attacker = attacker.owner;
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking))
    self.smoking = 1;

  self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

helileave() {
  self endon("death");
  self notify("leaving");
  self.leaving = 1;
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.goalyaw);
  helisetteamextractionhud(3, self.flytime);
  self waittill("goal");
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(self.pathexit, 1);
  self settargetyaw(self.goalyaw);
  self waittill("goal");
  self stoploopsound();
  helibankplunder();
  helisetteamextractionhud(0, 0);
  self notify("heli_gone");
  helidelete();
}

helidescend(location, groundz) {
  self endon("death");
  _id_0FCFB56E6D8CC156 = location[0];
  _id_0FCFB66E6D8CC389 = location[1];
  _id_6C53D859D582A421 = (_id_0FCFB56E6D8CC156, _id_0FCFB66E6D8CC389, groundz);
  self setvehgoalpos(_id_6C53D859D582A421, 1);
  self settargetyaw(self.goalyaw);
  self vehicle_setspeed(25.0, 31.25);
  thread helidestroyvehiclestouchnotify();
  thread helidestroyvehiclestouchtrace();
  self waittill("goal");
  self sethoverparams(1, 1);
  wait 1;
  self sethoverparams(25, 20, 10);
}

entisalivevehicle() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

helidestroyvehiclestouchnotify() {
  self endon("leaving");
  self endon("death");

  for(;;) {
    self waittill("touch", vehicle);

    if(isDefined(vehicle) && vehicle entisalivevehicle())
      vehicle dodamage(vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH");
  }
}

helidestroyvehiclestouchtrace() {
  self endon("leaving");
  self endon("death");
  radius = 70;
  _id_7CFE8395A8CF5836 = -80;
  forward = 150;
  _id_63E26D5A86AC531C = 25;
  back = -100;

  for(;;) {
    vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, getdvarfloat("test_radius", 400));

    if(vehicles.size <= 1) {
      wait 0.5;
      continue;
    }

    _id_7346EB0E818B60C5 = scripts\engine\trace::create_vehicle_contents();
    dir = anglesToForward(self.angles);
    origin = self.origin + dir * getdvarfloat("test_f", forward) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_m", _id_63E26D5A86AC531C) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    origin = self.origin + dir * getdvarfloat("test_b", back) + (0, 0, getdvarfloat("test_d", _id_7CFE8395A8CF5836));
    trace = scripts\engine\trace::sphere_trace(origin, origin + (0, 0, 1), radius, self, _id_7346EB0E818B60C5);
    ent = trace["entity"];

    if(isDefined(ent) && ent entisalivevehicle()) {
      ent dodamage(ent.health, self.origin, ent, ent, "MOD_CRUSH");
      waitframe();
      continue;
    }

    waitframe();
  }
}

tracegroundheight(start) {
  _id_DC8BB6300463CF1E = 125;
  _id_AA5A7071F7A4C106 = tracegroundpoint(start, 100, [self]);
  _id_E7A7D619F927D791 = _id_AA5A7071F7A4C106[2];
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  return _id_1DC672CFE0F0128E;
}

tracegroundpoint(start, radius, ignorelist) {
  _id_379FF849B3CDA7D7 = -99999;
  end = (start[0], start[1], _id_379FF849B3CDA7D7);
  contents = scripts\engine\trace::create_world_contents();
  _id_E96577032A7740FC = undefined;

  if(isDefined(radius))
    _id_E96577032A7740FC = scripts\engine\trace::sphere_trace(start, end, radius, ignorelist, contents);
  else
    _id_E96577032A7740FC = scripts\engine\trace::ray_trace(start, end, ignorelist, contents);

  return _id_E96577032A7740FC["position"];
}

heliwatchgameendleave() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread helileave();
}

initextractionlocations() {
  extractionlocations = [];

  if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
    extractionlocations[extractionlocations.size] = (-33750, -36000, 155);
    extractionlocations[extractionlocations.size] = (-41550, -7950, 515);
    extractionlocations[extractionlocations.size] = (-37500, 15350, 1130);
    extractionlocations[extractionlocations.size] = (-31950, 52015, 2265);
    extractionlocations[extractionlocations.size] = (-18510, 64815, 1940);
    extractionlocations[extractionlocations.size] = (15565, 60050, 2680);
    extractionlocations[extractionlocations.size] = (44400, 39255, -50);
    extractionlocations[extractionlocations.size] = (59780, 13800, 555);
    extractionlocations[extractionlocations.size] = (61200, -8445, 30);
    extractionlocations[extractionlocations.size] = (59325, -38390, -210);
    extractionlocations[extractionlocations.size] = (8660, -36630, -640);
  } else {
    switch (level.mapname) {
      case "mp_br_mechanics":
        extractionlocations[extractionlocations.size] = (1500, 1500, 0);
        extractionlocations[extractionlocations.size] = (2500, 1500, 0);
        extractionlocations[extractionlocations.size] = (3500, 1500, 0);
        extractionlocations[extractionlocations.size] = (4500, 1500, 0);
        break;
      case "mp_mb_tut":
        break;
    }
  }

  level.extractionlocations = extractionlocations;
  level.extractingplayers = [];
  level thread monitorextractionlocations();
}

createextractionlocation(origin) {}

monitorextractionlocations() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(location in level.extractionlocations) {
    objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

    if(objectiveiconid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", location, "icon_waypoint_flag");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 0);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
      scripts\mp\objidpoolmanager::objective_playermask_showtoall(objectiveiconid);
    }

    level thread spawnextractsmoke(location);
  }

  for(;;) {
    foreach(location in level.extractionlocations) {
      players = scripts\mp\utility\player::getplayersinradius(location, 300);

      foreach(player in players) {
        if(!scripts\engine\utility::array_contains(level.extractingplayers, player) && !istrue(player.extractioncomplete))
          player extactionstart(location);
      }
    }

    foreach(player in level.extractingplayers) {
      if(distancesquared(player.origin, player.extractionlocation) > 90000) {
        player extactioncancel();
        continue;
      }

      player.extractiontime = player.extractiontime - level.framedurationseconds;

      if(player.extractiontime <= 0.0)
        player extactioncomplete();
    }

    waitframe();
  }
}

spawnextractsmoke(location) {
  pos = scripts\engine\utility::drop_to_ground(location, 50, -200, (0, 0, 1));
  vfxent = spawn("script_model", pos + (0, 0, 3));
  vfxent setModel("scr_smoke_grenade");
  wait 1.0;
  playFXOnTag(scripts\engine\utility::getfx("vfx_smk_signal_red"), vfxent, "tag_fx");
  vfxent playLoopSound("mp_flare_burn_lp");
}

extactionstart(location) {
  self iprintlnbold("Extraction Start!");
  level.extractingplayers = scripts\engine\utility::array_add(level.extractingplayers, self);
  self.extractionlocation = location;
  self.extractiontime = 10;
  thread showextractiontime();
}

showextractiontime() {
  self endon("death_or_disconnect");
  self endon("extactionCancel");

  while(self.extractiontime > 0) {
    self iprintlnbold("Extracting in " + scripts\engine\math::round_float(self.extractiontime, 1));
    waitframe();
  }
}

extactioncancel() {
  self notify("extactionCancel");
  self iprintlnbold("Extraction Canceled!");
  level.extractingplayers = scripts\engine\utility::array_remove(level.extractingplayers, self);
  self.extractionlocation = undefined;
  self.extractiontime = undefined;
}

extactioncomplete() {
  self iprintlnbold("Extraction Complete!");
  level.extractingplayers = scripts\engine\utility::array_remove(level.extractingplayers, self);
  self.extractioncomplete = 1;
  kick(self getentitynumber(), "EXE/PLAYERKICKED_EXTRACTED");
}

autoassignquest(player) {
  if(!isDefined(level.questinfo.teamsonquests) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, player.team)) {
    return;
  }
  _id_73A1687C46C4D341 = [];

  foreach(type in level.validautoassignquests)
  _id_73A1687C46C4D341 = scripts\engine\utility::array_combine(_id_73A1687C46C4D341, getlootscriptablearray("brloot_" + type + "_tablet"));

  _id_73A1687C46C4D341 = scripts\engine\utility::array_randomize(_id_73A1687C46C4D341);
  _id_D62CC2E2BFA94D60 = undefined;
  _id_31A0A0ED9E70E900 = undefined;

  foreach(index, _id_670AA0DF96F7DE65 in _id_73A1687C46C4D341) {
    dist = scripts\engine\utility::distance_2d_squared(player.origin, _id_670AA0DF96F7DE65.origin);

    if(dist <= 16777216 && dist >= 16384) {
      player _id_64ACB6CE534155B7::_id_BB413728BC5231D0(_id_670AA0DF96F7DE65);
      return;
    }

    if(!isDefined(_id_D62CC2E2BFA94D60) || dist < _id_31A0A0ED9E70E900) {
      _id_D62CC2E2BFA94D60 = _id_670AA0DF96F7DE65;
      _id_31A0A0ED9E70E900 = dist;
    }
  }

  if(isDefined(_id_D62CC2E2BFA94D60))
    player _id_64ACB6CE534155B7::_id_BB413728BC5231D0(_id_D62CC2E2BFA94D60);
}

missions_clearinappropriaterewards(rewards) {
  _id_36F04620526242FF = [];

  foreach(key, reward in rewards) {
    if(key == "circle_peek") {
      continue;
    }
    _id_36F04620526242FF[key] = reward;
  }

  return _id_36F04620526242FF;
}

handleplunderendgamesplash(winner) {
  _id_03784E17637539B8 = [];

  if(isDefined(winner) && winner != "tie")
    _id_03784E17637539B8 = scripts\mp\utility\teams::getteamdata(winner, "players");

  _id_464DD76C6ECB56FA = scripts\mp\gamelogic::getbrendsplashpostgamestate();

  foreach(player in level.players) {
    if(_id_03784E17637539B8.size > 0 && scripts\engine\utility::array_contains(_id_03784E17637539B8, player)) {
      player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
      player setclientomnvar("ui_br_end_game_splash_type", 11);
      continue;
    }

    player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
    player setclientomnvar("ui_br_end_game_splash_type", 12);
  }
}

updateteamplunderscore(_id_7EDDF19F11DA2F94, team, _id_C6544E2C82D62DFB) {
  _id_4BF0ADEE32BC3338 = scripts\mp\gamescore::_getteamscore(team);
  _id_3777ECE6A73EADA5 = _id_7EDDF19F11DA2F94 - _id_4BF0ADEE32BC3338;

  if(_id_3777ECE6A73EADA5 != 0) {
    _id_61A16DF4892DB7B5 = scripts\engine\utility::ter_op(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF(), 1, undefined);
    level thread scripts\mp\gamescore::giveteamscoreforobjective(team, _id_3777ECE6A73EADA5, 0, undefined, _id_61A16DF4892DB7B5, _id_C6544E2C82D62DFB);
  }

  return _id_3777ECE6A73EADA5;
}

updatelootleadersonfixedinterval() {
  level notify("restartLootLeaders");
  level endon("restartLootLeaders");
  level endon("game_ended");
  interval = getdvarfloat("scr_plunder_loot_leader_update_interval", 15.0);
  _id_35D7D56101FB07A0 = getdvarfloat("dvar_B82244F91B963437", 5.0);
  _id_9C18968676DF1094 = getdvarint("dvar_114AA0DB563F4C19", 800);
  _id_32E688C1E2CF28C0 = getdvarint("dvar_4F47F4BD5CFEF308", 200);
  _id_1F88F11926C68559 = interval - _id_35D7D56101FB07A0;
  scripts\mp\flags::gameflagwait("placement_updates_allowed");
  _id_4600219CD6C6FA58 = 1;

  for(;;) {
    level.plunderupdatelootleadermarks = 1;
    scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", _id_1F88F11926C68559);

    if(_id_35D7D56101FB07A0 > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
        if(level.lootleadermarksontopteams > 0 && _id_AC0E594AC96AA3A8 == 0)
          _id_E08FDF5D9199F540 = "LootLeaderTop_Plunder";
        else
          _id_E08FDF5D9199F540 = "LootLeader_Plunder";

        _id_54B174A893636475 = level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4();

        if(!_id_4600219CD6C6FA58)
          level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

        level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Expired_" + _id_E08FDF5D9199F540, _id_54B174A893636475, _id_54B174A893636475[2]);
        level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
      }

      scripts\engine\utility::waittill_notify_or_timeout("bmo_overtime_start", _id_35D7D56101FB07A0);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
        if(level.lootleadermarksontopteams > 0 && _id_AC0E594AC96AA3A8 == 0)
          _id_E08FDF5D9199F540 = "LootLeaderTop_Plunder";
        else
          _id_E08FDF5D9199F540 = "LootLeader_Plunder";

        _id_54B174A893636475 = level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4();
        level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
        level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522(_id_E08FDF5D9199F540, _id_54B174A893636475, _id_54B174A893636475[2]);
        level.lootleadermarks[_id_AC0E594AC96AA3A8] scripts\cp_mp\utility\game_utility::_id_6988310081DE7B45();
      }
    }

    _id_4600219CD6C6FA58 = 0;
  }
}

updatecirclepulse(_id_5926BC85944973F2, _id_4EC590D17B901A2D, duration) {
  currenttime = gettime();
  duration = duration * 1000;
  endtime = int(currenttime + duration);
  _id_4573A8725DD3748E = abs(_id_5926BC85944973F2 - _id_4EC590D17B901A2D);

  for(;;) {
    currenttime = gettime();
    t = clamp(1.0 - (endtime - currenttime) / duration, 0.0, 1.0);
    frac = scripts\engine\utility::ter_op(_id_5926BC85944973F2 < _id_4EC590D17B901A2D, _id_4573A8725DD3748E * t + _id_5926BC85944973F2, _id_5926BC85944973F2 - _id_4573A8725DD3748E * t);
    setDvar("compassBRCirclePulseDuration", frac);

    if(t == 1.0) {
      break;
    }

    waitframe();
  }
}

updatelootleadermarks(_id_87B32CCA2597530F, _id_348AB76F83B33509, _id_E3759B02F55695C2, _id_DDD20D819A369A7D) {
  level.lootleadersprev = level.lootleaders;
  level.lootleaders = [];

  if(level.lootleaderoneperteam) {
    if(istrue(level.bmoovertime)) {
      level.lootleadermarkcount = adjustlootleadermarkcount();

      foreach(_id_C993BA0E8E78ED04 in level.lootleadermarks)
      _id_C993BA0E8E78ED04 scripts\cp_mp\utility\game_utility::_id_04EAF685BC40A3B9();
    }
  }

  if(level.lootleadermarksontopteams == 1) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
      _id_D546F00EDC1B5FC7 = getlootteamleader(_id_AC0E594AC96AA3A8, _id_87B32CCA2597530F, _id_DDD20D819A369A7D);

      if(isDefined(_id_D546F00EDC1B5FC7)) {
        level.lootleaders[level.lootleaders.size] = _id_E3759B02F55695C2[_id_D546F00EDC1B5FC7];

        if(istrue(level.expiredlootleaderenabled)) {
          if(isDefined(_id_E3759B02F55695C2[_id_D546F00EDC1B5FC7].expiredlootleaderinstance))
            removeplayerasexpiredlootleader(_id_E3759B02F55695C2[_id_D546F00EDC1B5FC7].expiredlootleaderinstance);
        }
      }
    }
  } else if(level.lootleadermarksontopteams == 2) {
    _id_D546F00EDC1B5FC7 = getlootteamleader(0, _id_87B32CCA2597530F, _id_DDD20D819A369A7D);

    if(isDefined(_id_D546F00EDC1B5FC7)) {
      level.lootleaders[0] = _id_E3759B02F55695C2[_id_D546F00EDC1B5FC7];

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(_id_E3759B02F55695C2[_id_D546F00EDC1B5FC7].expiredlootleaderinstance))
          removeplayerasexpiredlootleader(_id_E3759B02F55695C2[_id_D546F00EDC1B5FC7].expiredlootleaderinstance);
      }
    }

    foreach(_id_B7739B4D7E762D6B in _id_348AB76F83B33509) {
      player = _id_E3759B02F55695C2[_id_B7739B4D7E762D6B];
      _id_67F14F8315CB0F2F = _id_87B32CCA2597530F[_id_B7739B4D7E762D6B];

      if(_id_67F14F8315CB0F2F == 0) {
        break;
      }

      if(_id_67F14F8315CB0F2F == level.risktokenstokeep) {
        continue;
      }
      if(scripts\engine\utility::array_contains(level.lootleaders, player)) {
        continue;
      }
      level.lootleaders[level.lootleaders.size] = player;

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(player.expiredlootleaderinstance))
          removeplayerasexpiredlootleader(player.expiredlootleaderinstance);
      }

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  } else {
    foreach(player in _id_348AB76F83B33509) {
      _id_67F14F8315CB0F2F = _id_87B32CCA2597530F[player];

      if(_id_67F14F8315CB0F2F == 0) {
        break;
      }

      if(_id_67F14F8315CB0F2F == level.risktokenstokeep) {
        continue;
      }
      level.lootleaders[level.lootleaders.size] = _id_E3759B02F55695C2[player];

      if(istrue(level.expiredlootleaderenabled)) {
        if(isDefined(_id_E3759B02F55695C2[player].expiredlootleaderinstance))
          removeplayerasexpiredlootleader(_id_E3759B02F55695C2[player].expiredlootleaderinstance);
      }

      if(level.lootleaders.size == level.lootleadermarkcount) {
        break;
      }
    }
  }

  foreach(player in level.lootleadersprev) {
    if(isDefined(player) && !scripts\engine\utility::array_contains(level.lootleaders, player))
      removeplayeraslootleader(player);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.lootleadermarkcount; _id_AC0E594AC96AA3A8++) {
    instance = level.lootleadermarks[_id_AC0E594AC96AA3A8];

    if(isDefined(level.lootleaders[_id_AC0E594AC96AA3A8])) {
      instance.targetplayer = level.lootleaders[_id_AC0E594AC96AA3A8];
      instance.targetplayer.lootleaderinstance = instance;
      location = (instance.targetplayer.origin[0], instance.targetplayer.origin[1], level.lootleadermarksize);

      if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
        location = location + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);

      instance scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(location);

      if(istrue(level.lootleadermarksizedynamic))
        updatelootleadercirclesize(instance);

      _id_BFF2D9D4105D9618 = scripts\engine\utility::array_contains(level.lootleaders, instance.targetplayer) && !scripts\engine\utility::array_contains(level.lootleadersprev, instance.targetplayer);
      _id_BE4E32B47AD61C7D = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

      foreach(player in _id_BE4E32B47AD61C7D)
      instance scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);

      _id_1E502B02D01CF98D = scripts\mp\utility\teams::getfriendlyplayers(instance.targetplayer.team, 0);

      foreach(player in _id_1E502B02D01CF98D)
      instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);

      if(_id_BFF2D9D4105D9618)
        addplayeraslootleader(instance);

      continue;
    }

    instance.targetplayer = undefined;

    foreach(player in level.players)
    instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(player);
  }
}

getlootteamleader(index, _id_87B32CCA2597530F, _id_DDD20D819A369A7D) {
  team = _id_DDD20D819A369A7D[index];
  _id_9FB5DEF50E853261 = 0;
  plunder = 0;

  if(level.teamdata[team]["players"].size == 0)
    return undefined;

  _id_D546F00EDC1B5FC7 = level.teamdata[team]["players"][0].guid;

  foreach(player in level.teamdata[team]["players"]) {
    _id_9FB5DEF50E853261 = _id_87B32CCA2597530F[player.guid];

    if(_id_9FB5DEF50E853261 > plunder) {
      plunder = _id_9FB5DEF50E853261;
      _id_D546F00EDC1B5FC7 = player.guid;
    }
  }

  return _id_D546F00EDC1B5FC7;
}

addplayeraslootleader(instance) {
  player = instance.targetplayer;

  if(scripts\cp_mp\utility\player_utility::isreallyalive(player)) {
    if(!_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF())
      player scripts\mp\hud_message::showsplash("bm_player_marked");

    player cashleaderbag_attach();

    if(istrue(level.expiredlootleaderenabled))
      player thread watchforplayerdeath(instance);
  }
}

removeplayeraslootleader(player) {
  if(isDefined(player.attached_bag))
    player cashleaderbag_detach();

  if(isDefined(player.lootleaderinstance)) {
    foreach(_id_F90358454413407F in level.players)
    player.lootleaderinstance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(_id_F90358454413407F);

    circleorigin = player.lootleaderinstance scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4();

    if(istrue(level.expiredlootleaderenabled))
      addplayerasexpiredlootleader(player, circleorigin);

    player.lootleaderinstance.targetplayer = undefined;
    player.lootleaderinstance = undefined;
  }

  level.lootleaders = scripts\engine\utility::array_remove(level.lootleaders, player);
}

watchforplayerdeath(instance) {
  self endon("disconnect");
  self waittill("death");
  circleorigin = self.lootleaderinstance scripts\cp_mp\utility\game_utility::_id_D9583306C5A171E4();
  removeplayeraslootleader(self);
  addplayerasexpiredlootleader(self, circleorigin);
}

addplayerasexpiredlootleader(player, circleorigin) {
  if(scripts\engine\utility::array_contains(level.expiredlootleaders, player)) {
    return;
  }
  level.expiredlootleaders = scripts\engine\utility::array_add(level.expiredlootleaders, player);
  instance = undefined;

  foreach(_id_F90358454413407F in level.expiredlootleadermarks) {
    if(!isDefined(_id_F90358454413407F.targetplayer)) {
      instance = _id_F90358454413407F;
      break;
    }
  }

  if(!isDefined(instance)) {
    _id_3071102F98CBED33 = undefined;

    foreach(_id_F90358454413407F in level.expiredlootleadermarks) {
      if(!isDefined(_id_3071102F98CBED33) || _id_F90358454413407F.lastusedtime < _id_3071102F98CBED33) {
        _id_3071102F98CBED33 = _id_F90358454413407F.lastusedtime;
        instance = _id_F90358454413407F;
      }
    }

    instance.targetplayer notify("stop_update");
  }

  instance.targetplayer = player;
  instance.lastusedtime = gettime();
  player.expiredlootleaderinstance = instance;

  if(isDefined(circleorigin))
    instance scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(circleorigin);
  else {
    location = (instance.targetplayer.origin[0], instance.targetplayer.origin[1], level.lootleadermarksize);
    location = location + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 1000);
    instance scripts\cp_mp\utility\game_utility::_id_6E148C8DA2E4DB13(location);
  }

  if(istrue(level.lootleadermarksizedynamic))
    updatelootleadercirclesize(instance);

  _id_BE4E32B47AD61C7D = scripts\mp\utility\teams::getenemyplayers(instance.targetplayer.team, 0);

  foreach(_id_F90358454413407F in _id_BE4E32B47AD61C7D)
  instance scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(_id_F90358454413407F);

  _id_1E502B02D01CF98D = scripts\mp\utility\teams::getfriendlyplayers(instance.targetplayer.team, 0);

  foreach(_id_F90358454413407F in _id_1E502B02D01CF98D)
  instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(_id_F90358454413407F);

  thread updateexpiredlootleader(instance);
}

updateexpiredlootleader(instance) {
  instance.targetplayer endon("stop_update");
  wait 5.0;
  removeplayerasexpiredlootleader(instance);
}

removeplayerasexpiredlootleader(instance) {
  player = instance.targetplayer;
  level.expiredlootleaders = scripts\engine\utility::array_remove(level.expiredlootleaders, instance.targetplayer);
  instance.targetplayer.expiredlootleaderinstance = undefined;
  instance.targetplayer = undefined;

  foreach(_id_F90358454413407F in level.players)
  instance scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(_id_F90358454413407F);

  player notify("stop_update");
}

cashleaderbag_attach() {
  self attach("accessory_money_bag_large_closed_player", "tag_stowed_back3", 1, 1);
  self.attached_bag = "accessory_money_bag_large_closed_player";

  if(self tagexists("j_bag_left"))
    playFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");

  thread cashleader_trackdeath();
}

cashleaderbag_detach() {
  if(isDefined(self) && isDefined(self.attached_bag)) {
    if(self tagexists("j_bag_left"))
      stopFXOnTag(level._effect["vfx_br_cashLeaderBag"], self, "j_bag_left");

    self detach(self.attached_bag, "tag_stowed_back3");
    self.attached_bag = undefined;
  }

  self notify("killthread_bagModelSwap");
}

cashleader_trackdeath() {
  self notify("cashleader_trackDeath");
  self endon("cashleader_trackDeath");
  self endon("killthread_bagModelSwap");
  self waittill("death");
  cashleaderbag_detach();
}

packextrascore0(data) {
  _id_081DAB8953B9DF82 = 0;
  _id_B87F7FAE01CE754F = 0;

  if(isDefined(self.risktokencount))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.risktokencount;

  if(isDefined(self.risktokensbanked))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.risktokensbanked;

  _id_B87F7FAE01CE754F = int(_id_B87F7FAE01CE754F / 10);

  if(_id_B87F7FAE01CE754F > 4095)
    _id_B87F7FAE01CE754F = 4095;

  _id_081DAB8953B9DF82 = _id_B87F7FAE01CE754F;
  _id_C5C0C138D608BE6A = 0;

  if(isDefined(self.missionparticipation))
    _id_C5C0C138D608BE6A = _id_C5C0C138D608BE6A + self.missionparticipation;

  if(_id_C5C0C138D608BE6A > 15)
    _id_C5C0C138D608BE6A = 15;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_C5C0C138D608BE6A << 12);
  scripts\mp\utility\stats::setextrascore0(_id_081DAB8953B9DF82);
}

packclientmatchdata() {
  _id_081DAB8953B9DF82 = 0;
  _id_B87F7FAE01CE754F = 0;

  if(isDefined(self.risktokencount))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.risktokencount;

  if(isDefined(self.risktokensbanked))
    _id_B87F7FAE01CE754F = _id_B87F7FAE01CE754F + self.risktokensbanked;

  _id_B87F7FAE01CE754F = int(_id_B87F7FAE01CE754F / 10);

  if(_id_B87F7FAE01CE754F > 4095)
    _id_B87F7FAE01CE754F = 4095;

  _id_081DAB8953B9DF82 = _id_B87F7FAE01CE754F;
  _id_C5C0C138D608BE6A = 0;

  if(isDefined(self.missionparticipation))
    _id_C5C0C138D608BE6A = _id_C5C0C138D608BE6A + self.missionparticipation;

  if(_id_C5C0C138D608BE6A > 15)
    _id_C5C0C138D608BE6A = 15;

  _id_081DAB8953B9DF82 = _id_081DAB8953B9DF82 + (_id_C5C0C138D608BE6A << 12);
  return _id_081DAB8953B9DF82;
}

playerlootleadervalidity() {
  self endon("disconnect");

  if(isDefined(level.lootleaders) && scripts\engine\utility::array_contains(level.lootleaders, self)) {
    scripts\mp\hud_message::showsplash("bm_player_marked");
    cashleaderbag_attach();
  }
}

updatelootleadercirclesize(instance) {
  if(isDefined(instance.targetplayer.risktokencount))
    _id_C2D1738D79D98C15 = instance.targetplayer.risktokencount;
  else
    _id_C2D1738D79D98C15 = 0;

  _id_C2D1738D79D98C15 = clamp(_id_C2D1738D79D98C15, level.lootleadermarkweakvalue, level.lootleadermarkstrongvalue);
  range = level.lootleadermarkstrongvalue - level.lootleadermarkweakvalue;
  frac = (_id_C2D1738D79D98C15 - level.lootleadermarkweakvalue) / range;
  _id_794B260201F063C2 = level.lootleadermarkweaksize - level.lootleadermarkstrongsize;
  _id_6E831C5902E07B4C = level.lootleadermarkweaksize - frac * _id_794B260201F063C2;
  instance scripts\cp_mp\utility\game_utility::_id_4584AD1C0E2C58EC(_id_6E831C5902E07B4C);
}

adjustlootleadermarkcount(_id_C3E10A42A81ADE25) {
  _id_11A4492ADC953FF5 = 0;
  _id_C3E10A42A81ADE25 = scripts\mp\gamescore::getteamscoreplacements();
  _id_620F245E58FF4740 = getwincost();

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.maxlootleadermarkcount + 1; _id_AC0E594AC96AA3A8++) {
    foreach(team in level.teamnamelist) {
      if(_id_C3E10A42A81ADE25[team] != _id_AC0E594AC96AA3A8) {
        continue;
      }
      _id_DA382C87BD272CCB = getteamtokens(team);

      if(_id_DA382C87BD272CCB >= _id_620F245E58FF4740 || _id_C3E10A42A81ADE25[team] == 1)
        _id_11A4492ADC953FF5++;
    }
  }

  if(_id_11A4492ADC953FF5 > level.maxlootleadermarkcount)
    _id_11A4492ADC953FF5 = level.maxlootleadermarkcount;

  return _id_11A4492ADC953FF5;
}

displayplunderloss(player, _id_3777ECE6A73EADA5) {
  _id_83E60CF2F8B66836 = 0;
  _id_350F8764871AA143 = 0;
  _id_1E89D40FE2954AB6 = 20;
  _id_4828ED9B88A47362 = player.risktokencount;
  _id_F1BC35C0DF4EC92F = _id_4828ED9B88A47362 + _id_3777ECE6A73EADA5;
  current = _id_F1BC35C0DF4EC92F;
  target = _id_4828ED9B88A47362;
  _id_4573A8725DD3748E = target - _id_F1BC35C0DF4EC92F;
  sign = scripts\engine\utility::sign(_id_4573A8725DD3748E);
  _id_B749E3228EC71E90 = _id_4573A8725DD3748E / 2.0;
  _id_585AAE66E20728C4 = int(_id_B749E3228EC71E90 * 2 * level.framedurationseconds);

  if(_id_585AAE66E20728C4 == 0) {
    return;
  }
  _id_C61E1BDA6BEF78EB = createhudelem(&"MP_BR_INGAME/PLUNDER_DEATH_LOSS", _id_3777ECE6A73EADA5, "RIGHT", "CENTER", _id_83E60CF2F8B66836 + 46, _id_350F8764871AA143, undefined, undefined, 1.25, player);
  _id_C61E1BDA6BEF78EB.alpha = 1;
  _id_A85EC6AC5846D65F = createhudelem(&"MP_BR_INGAME/YOUR_PLUNDER_TEXT", undefined, "RIGHT", "CENTER", _id_83E60CF2F8B66836, _id_350F8764871AA143 + _id_1E89D40FE2954AB6, undefined, undefined, 1.25, player);
  _id_A85EC6AC5846D65F.alpha = 1;
  _id_AA9C740500DD5694 = createhudelem(&"MP_BR_INGAME/EXTRACT_PLUNDER", _id_F1BC35C0DF4EC92F, "LEFT", "CENTER", _id_83E60CF2F8B66836 + 45, _id_350F8764871AA143 + _id_1E89D40FE2954AB6, undefined, undefined, 1.25, player);
  _id_AA9C740500DD5694.alpha = 1;
  wait 1.0;

  while(current != target) {
    current = current + _id_585AAE66E20728C4;

    if(sign > 0 && current > target || sign < 0 && current < target)
      current = target;

    _id_AA9C740500DD5694 setvalue(current);
    wait(level.framedurationseconds);
  }

  wait 3.0;
  _id_C61E1BDA6BEF78EB destroy();
  _id_A85EC6AC5846D65F destroy();
  _id_AA9C740500DD5694 destroy();
}

_getplunderextractlocations(_id_532388C61E12B9DF, _id_E296217C9FCD337F, _id_395F0C06F7ABDCC1) {
  if(_id_532388C61E12B9DF.size == 0 || _id_E296217C9FCD337F == 0) {
    return;
  }
  _id_BFE291B401A9BF2A = [];
  _id_FFAE32B49DF07DBF = [];

  if(_id_532388C61E12B9DF.size > 0) {
    _id_532388C61E12B9DF = scripts\engine\utility::array_randomize(_id_532388C61E12B9DF);
    _id_FFAE32B49DF07DBF = int(min(_id_E296217C9FCD337F, _id_532388C61E12B9DF.size));
  }

  if(level.setupevenlydistributedpads) {
    dist = 0;

    if(level.adjusteventdistributionpadding > 0 && istrue(_id_395F0C06F7ABDCC1)) {
      _id_233C184A379E961E = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FFAE32B49DF07DBF; _id_AC0E594AC96AA3A8++) {
        if(_id_233C184A379E961E > level.paddedquadgridcenterpoints.size - 1)
          _id_233C184A379E961E = 0;

        _id_ED7960F0EDB5F2A0 = level.paddedquadgridcenterpoints[_id_233C184A379E961E];

        foreach(_id_EB7FF65BD7004AD7 in _id_532388C61E12B9DF) {
          if(pointinsquare(_id_EB7FF65BD7004AD7.origin, _id_ED7960F0EDB5F2A0, level.pointinsquarewidth)) {
            _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = _id_EB7FF65BD7004AD7;
            _id_532388C61E12B9DF = scripts\engine\utility::array_remove(_id_532388C61E12B9DF, _id_EB7FF65BD7004AD7);
            break;
          }
        }

        _id_233C184A379E961E++;
      }
    } else {
      foreach(_id_EB7FF65BD7004AD7 in _id_532388C61E12B9DF) {
        dist = 0;

        foreach(_id_9D308880669C09EA in level.quadgridcenterpoints) {
          _id_5C1EE5AB8012EA11 = scripts\engine\utility::distance_2d_squared(_id_9D308880669C09EA, _id_EB7FF65BD7004AD7.origin);

          if(dist == 0 || _id_5C1EE5AB8012EA11 < dist) {
            dist = _id_5C1EE5AB8012EA11;
            _id_EB7FF65BD7004AD7.closestquad = _id_9D308880669C09EA;
          }
        }
      }

      _id_233C184A379E961E = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FFAE32B49DF07DBF; _id_AC0E594AC96AA3A8++) {
        if(_id_233C184A379E961E > level.quadgridcenterpoints.size - 1)
          _id_233C184A379E961E = 0;

        _id_ED7960F0EDB5F2A0 = level.quadgridcenterpoints[_id_233C184A379E961E];

        foreach(_id_EB7FF65BD7004AD7 in _id_532388C61E12B9DF) {
          if(isDefined(_id_EB7FF65BD7004AD7.closestquad) && _id_EB7FF65BD7004AD7.closestquad == _id_ED7960F0EDB5F2A0) {
            _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = _id_EB7FF65BD7004AD7;
            _id_532388C61E12B9DF = scripts\engine\utility::array_remove(_id_532388C61E12B9DF, _id_EB7FF65BD7004AD7);
            break;
          }
        }

        _id_233C184A379E961E++;
      }
    }
  } else if(_id_532388C61E12B9DF.size > 0) {
    _id_532388C61E12B9DF = scripts\engine\utility::array_randomize(_id_532388C61E12B9DF);
    _id_FFAE32B49DF07DBF = int(min(_id_E296217C9FCD337F, _id_532388C61E12B9DF.size));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FFAE32B49DF07DBF; _id_AC0E594AC96AA3A8++)
      _id_BFE291B401A9BF2A[_id_BFE291B401A9BF2A.size] = _id_532388C61E12B9DF[_id_AC0E594AC96AA3A8];
  }

  if(istrue(level.hideallunselectedextractpads)) {
    foreach(site in _id_532388C61E12B9DF) {
      if(!scripts\engine\utility::array_contains(_id_BFE291B401A9BF2A, site))
        site setscriptablepartstate(site.type, "hidden");
    }
  }

  return _id_BFE291B401A9BF2A;
}

pointinsquare(point, center, width) {
  _id_4E9BDD57294562FD = center[0] - width;
  _id_4E78E757291F3143 = center[0] + width;
  _id_A056773A8AB0B014 = center[1] - width;
  _id_A07A653A8AD90336 = center[1] + width;
  return point[0] >= _id_4E9BDD57294562FD && point[0] <= _id_4E78E757291F3143 && point[1] >= _id_A056773A8AB0B014 && point[1] <= _id_A07A653A8AD90336;
}

startplunderextractiontimers() {
  scripts\mp\flags::gameflagwait("prematch_done");
  waitframe();

  foreach(_id_9CC712DF12A78D2A in level.br_plunder_sites) {
    _id_9CC712DF12A78D2A.disabled = undefined;
    scriptablestate = scripts\engine\utility::ter_op(level.showplunderextracticonsinworld && !level.shownonscriptableextracticons, _id_9CC712DF12A78D2A.activecurrstate, _id_9CC712DF12A78D2A.activestate);
    _id_9CC712DF12A78D2A setscriptablepartstate(_id_9CC712DF12A78D2A.type, scriptablestate);
    _id_9CC712DF12A78D2A thread runplunderextractsitetimer();

    if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons)
      _id_9CC712DF12A78D2A.locale thread timeoutradialunfill();
  }

  level thread runextractreroll();
}

runplunderextractsitetimer() {
  wait(level.timeoutplunderextractionsites);
  self.disabled = 1;
  self.helidisabled = 1;
  self setscriptablepartstate(self.type, self.disabledstate);
}

runextractreroll() {
  wait(level.timeoutplunderextractionsites + 1);
  level.br_plunder_sites = _getplunderextractlocations(_id_6AFF3948CF4CCA03::getallextractspawninstances(), level.maxplunderextractions);

  if(level.showplunderextracticonsinworld && level.shownonscriptableextracticons)
    level thread createheliextractobjectiveicons();

  level thread startplunderextractiontimers();
}

createheliextractobjectiveicons() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(_id_9CC712DF12A78D2A in level.br_plunder_sites) {
    locale = spawnStruct();
    locale _id_64ACB6CE534155B7::createquestobjicon("ui_mp_br_mapmenu_icon_atm", "current", _id_9CC712DF12A78D2A.origin + (0, 0, 200));
    _id_9CC712DF12A78D2A.locale = locale;
  }
}

timeoutradialunfill() {
  timer = level.timeoutplunderextractionsites;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  _id_ACFA0707DD372692 = timer * 1000;
  _id_D3D9F3AD00693948 = _id_ACFA0707DD372692 - _id_A1DFE9D4920A43FA;
  endtime = gettime() + _id_ACFA0707DD372692;

  while(gettime() < endtime) {
    _id_6403FB28FBB44896 = _id_D3D9F3AD00693948 / _id_ACFA0707DD372692;
    scripts\mp\objidpoolmanager::objective_show_progress(self.objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objectiveiconid, _id_6403FB28FBB44896);
    _id_D3D9F3AD00693948 = max(_id_D3D9F3AD00693948 - _id_A1DFE9D4920A43FA, 1);
    waitframe();
  }

  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  self.objectiveiconid = -1;
}

startbmoexfilprocess(team) {
  level setexfiltimer();
  level thread showexfilstartsplash(team);

  if(level.teamplunderexfilvipuav)
    level thread startvipteamuav(team);

  if(level.teamplunderexfilshowviponly)
    level thread removenonvipteamlocations();

  level thread startexfilchoppers();
  level thread nuke_startexfilcountdown(team);
}

setexfiltimer() {
  scripts\mp\gamelogic::resumetimer();
  level.starttime = gettime();
  level.discardtime = 0;
  level.timerpausetime = 0;
  timelimit = getdvarfloat("dvar_C655A0B01B13910A", 180);
  _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
  level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
  level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;
}

showexfilstartsplash(_id_EC15CE3E7A9D1D86) {
  foreach(team in level.teamnamelist)
  _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_requested", team);

  foreach(player in level.players) {
    player thread scripts\mp\hud_message::showsplash("callout_bmo_exfil_winners");
    player scripts\mp\utility\lower_message::setlowermessageomnvar("bmo_exfil_start", undefined, 20);
  }
}

startvipteamuav(team) {
  level.radarmode[team] = "normal_radar";
  level.activeuavs[team] = 1;
  level.activeadvanceduavs[team] = 0;
  scripts\cp_mp\killstreaks\uav::_id_484D86CE003C2526(team, 4);
}

removenonvipteamlocations() {
  level.lootleadermarkcount = 1;

  if(getdvarint("dvar_9EFDB377E7AE2DFF", 0) == 1) {
    if(getdvarfloat("scr_plunder_loot_leader_update_interval", 15.0) > 0.0)
      level thread updatelootleadersonfixedinterval();
  }
}

startexfilchoppers() {
  foreach(site in level.br_plunder_sites) {
    site setscriptablepartstate(site.type, "inuse");
    _id_01230EA36A300368 = getgroundposition(site.origin, 1) + (0, 0, 2);
    _id_6B2FF09E35C441CE = level.players[0];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 200; _id_AC0E594AC96AA3A8++) {
      _id_6B2FF09E35C441CE = findanyaliveplayer();

      if(isPlayer(_id_6B2FF09E35C441CE)) {
        break;
      }
    }

    _id_01230EA36A300368 = getgroundposition(site.origin, 1) + (0, 0, 2);
    heli = _id_6B2FF09E35C441CE playerspawnexfilchopper(_id_01230EA36A300368, site);

    if(isDefined(heli)) {
      heli.site = site;
      site.heli = heli;
      heli helicreateextractvfx(_id_01230EA36A300368);
      heli thread extractplayers();
    }
  }
}

playerspawnexfilchopper(position, site) {
  _id_26A6F862062E4340 = position;
  _id_0C2C23AB40723A8D = _id_26A6F862062E4340 + (0, 0, 2500);
  yaw = findclearflightyaw(_id_0C2C23AB40723A8D, site);
  angles = (0, yaw, 0);

  if(getdvarint("dvar_D5878CA9E558DD32", 1) == 1) {
    _id_CB2DC60F7CAFC6D4 = -100;
    _id_F0DB3D408327DB23 = 60;
    _id_67C2F437706DE4A1 = anglesToForward(angles);
    _id_954350C43B0BCBC2 = anglestoright(angles);
    _id_26A6F862062E4340 = _id_26A6F862062E4340 + _id_67C2F437706DE4A1 * _id_CB2DC60F7CAFC6D4 + _id_954350C43B0BCBC2 * _id_F0DB3D408327DB23;
  }

  _id_16CEDB94FAF4D596 = _id_0C2C23AB40723A8D + -1 * anglesToForward(angles) * 30000;
  exitposition = _id_0C2C23AB40723A8D + anglesToForward(angles) * 30000;
  heli = spawnheli(self, _id_16CEDB94FAF4D596, _id_0C2C23AB40723A8D, exitposition);
  return heli;
}

extractplayers() {
  self endon("death");
  self endon("leaving");
  self setvehgoalpos(self.pathgoal, 1);
  self settargetyaw(self.goalyaw);
  groundz = tracegroundheightexfil(self.pathgoal);
  _id_625180CE8D2F8F77 = self.pathgoal[2] - groundz;
  self.flytime = calculatehelitimetoarrive(_id_625180CE8D2F8F77);
  helisetteamextractionhud(1, self.flytime);
  self waittill("goal");

  foreach(player in level.players)
  player scripts\mp\utility\lower_message::setlowermessageomnvar("bmo_exfil_arrive", undefined, 20);

  thread heliwatchgameendleave();
  thread helidisapateextractvfx();
  helidescend(self.endpoint, groundz);

  foreach(_id_F90358454413407F in level.teamnamelist)
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_arrive", _id_F90358454413407F, 1);

  helimakeexfilwait();
  helicleanupextract();

  foreach(_id_F90358454413407F in level.teamnamelist)
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("plunder_extract_chopper_leave", _id_F90358454413407F, 1);

  thread helileave();
}

helimakeexfilwait() {
  self.isdepot = 1;
  self.usable = self.crate;
  usable = self.usable;
  usable makeusable();
  usable setCursorHint("HINT_NOICON");
  usable setuseholdduration("duration_medium");
  usable sethintrequiresholding(1);
  usable setuserange(230);
  usable setHintString(&"MP/BR_USE_EXFIL_CHOPPER");
  _id_BDF913FBADCCE9A7 = level.br_depots.size;
  level.br_depots[_id_BDF913FBADCCE9A7] = usable;

  foreach(player in level.players) {
    if(!isDefined(player))
      continue;
  }

  thread helicleanupdepotonleaving();
  thread heliexfilthink(usable);
  helisetteamextractionhud(2, 300);
  wait 300;
  self.isdepot = 0;
  heliusecleanup();
}

heliexfilthink(usable) {
  self endon("death");
  usable endon("death");

  for(;;) {
    usable waittill("trigger", player);
    player scripts\mp\hud_message::showsplash("callout_exfil_success");
    player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
    player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_risk::heliExfilThink()");
    player sethidenameplate(0);
    player allowmovement(0);
    player allowfire(0);
    player disableoffhandprimaryweapons(0);
    player disableoffhandsecondaryweapons(0);
    player disableweapons(0);
    player disableweaponswitch(0);
    player setcamerathirdperson(1);
    player allowcrouch(0);
    player allowmelee(0);
    player allowjump(0);
    player allowprone(0);
    player _id_3B64EB40368C1450::set("heliExfil", "killstreaks", 0);
    player _id_3B64EB40368C1450::set("heliExfil", "supers", 0);
    player.safefromnuke = 1;
    usable disableplayeruse(player);
  }
}

healdamage() {
  self endon("death");
  self endon("leaving");
  self endon("swapped");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.health = 99999;
  }
}

tracegroundheightexfil(start) {
  _id_DC8BB6300463CF1E = 256;
  _id_AA5A7071F7A4C106 = tracegroundpoint(start, 100, [self]);
  _id_E7A7D619F927D791 = _id_AA5A7071F7A4C106[2];
  _id_1DC672CFE0F0128E = _id_E7A7D619F927D791 + _id_DC8BB6300463CF1E;
  return _id_1DC672CFE0F0128E;
}

findclearflightyaw(_id_0C2C23AB40723A8D, site) {
  if(isDefined(site) && isDefined(site.flightyaw))
    return site.flightyaw;

  _id_3FB4A86293ED25A6 = 10;
  contents = scripts\engine\trace::create_world_contents();

  for(yaw = 0; yaw < 360; yaw = yaw + _id_3FB4A86293ED25A6) {
    angles = (0, yaw, 0);
    start = _id_0C2C23AB40723A8D + -1 * anglesToForward(angles) * 30000;
    end = _id_0C2C23AB40723A8D + anglesToForward(angles) * 30000;
    trace = scripts\engine\trace::sphere_trace(_id_0C2C23AB40723A8D, end, 100, undefined, contents, 1);

    if(trace["fraction"] == 1) {
      if(isDefined(site))
        site.flightyaw = yaw;

      return yaw;
    }

    if(yaw % 3 == 0)
      waitframe();
  }

  yaw = randomfloat(360);

  if(isDefined(site))
    site.flightyaw = yaw;

  return yaw;
}

nuke_startexfilcountdown(_id_65669339223F29B4) {
  level notify("mercy_ending_timer_started");
  level endon("mercy_ending_triggered");
  setomnvar("ui_nuke_timer_type", 1);
  setomnvar("ui_nuke_timer_time", level.teamplunderexfiltimer);
  setomnvar("ui_nuke_countdown_active", 1);
  starttime = gettime();
  endtime = level.teamplunderexfiltimer * 1000 + starttime;
  setomnvar("ui_nuke_end_milliseconds", level.teamplunderexfiltimer * 1000 + starttime);

  for(;;) {
    waitframe();

    if(gettime() > endtime) {
      break;
    }
  }

  level thread scripts\mp\gamelogic::endgame(_id_65669339223F29B4, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
  setomnvar("ui_nuke_countdown_active", 0);
}

triggerovertimetimer(team, _id_C0174FB6729764E5, ontimelimitot) {
  if(istrue(level.bmoovertime)) {
    if(istrue(level.bankingoverlimitwillendot) && istrue(_id_C0174FB6729764E5))
      level thread bmoendgameot();

    return;
  }

  level.bmoovertime = 1;
  level notify("cancel_announcer_dialog");
  thread scripts\mp\music_and_dialog::plunder_overtime_music();
  level thread overtimecashmultiplier();
  _id_1B4ADA49A21B51CA = scripts\engine\utility::ter_op(level.overtimecashmultiplier >= 1, "bm_overtime_double_cash_num", "bm_overtime_double_cash_perc");

  if(isDefined(team) && (level.disablewinonscore || !level.disableonemilannounce)) {
    level.initialwinningteam = team;
    scripts\mp\hud_util::showsplashtoallexceptteam(team, "bm_overtime_start_them");
    scripts\mp\hud_util::showsplashtoteam(team, "bm_overtime_start_us");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("bm_gamestate_overtime", team);

    foreach(_id_F90358454413407F in level.teamnamelist) {
      if(_id_F90358454413407F != team)
        level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("bm_gamestate_overtime_enemy", _id_F90358454413407F);
    }
  } else
    level.initialwinningteam = getinitialwinningteam();

  if(!isDefined(ontimelimitot)) {
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    timelimit = scripts\engine\utility::ter_op(level.disableonemilannounce || istrue(ontimelimitot), 7, 12);
    _id_B2FF82EC901486E4 = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
    level.watchdvars[_id_B2FF82EC901486E4].value = timelimit;
    level.overridewatchdvars[_id_B2FF82EC901486E4] = timelimit;

    if(!level.disableonemilannounce)
      wait 5;

    scripts\mp\hud_util::showsplashtoall(_id_1B4ADA49A21B51CA);
    wait 5;
    level.ontimelimitgraceperiod = level.doendofmatchotsequence;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
  } else {
    level.ontimelimitgraceperiod = level.doendofmatchotsequence;
    level.currenttimelimitdelay = 0.0;
    level.canprocessot = 1;
    level notify("bmo_overtime_start");
    level.forcehideottimer = 1;
    level.forceotlogictorun = 1;
    scripts\mp\hud_util::showsplashtoall(_id_1B4ADA49A21B51CA);
    wait 5;
  }

  level.forcehideottimer = undefined;
  scripts\mp\flags::gameflagwait("overtime_started");
  setomnvar("ui_br_circle_state", 7);

  if(!isDefined(ontimelimitot)) {
    timer = gettime() + int(level.doendofmatchotsequence * 1000);
    setomnvar("ui_hardpoint_timer", timer);
  }

  wait(int(max(level.doendofmatchotsequence - 60, 0)));
  setomnvar("ui_br_circle_state", 8);
}

getinitialwinningteam() {
  _id_EC15CE3E7A9D1D86 = "";

  foreach(team in level.teamnamelist) {
    placement = game["teamPlacements"][team];

    if(placement == 1) {
      _id_EC15CE3E7A9D1D86 = team;
      break;
    }
  }

  return _id_EC15CE3E7A9D1D86;
}

ontimelimit() {
  if(level.teamplunderscoremechanic && level.doendofmatchotsequence > 0 && !istrue(level.bmoovertime)) {
    if(!isDefined(level.initialwinningteam))
      level.initialwinningteam = getinitialwinningteam();

    level thread triggerovertimetimer(level.initialwinningteam, level.teamdata[level.initialwinningteam]["tokensBanked"] >= getwincost());
    level waittill("bmo_overtime_start");

    while(level.currenttimelimitdelay < level.ontimelimitgraceperiod)
      wait(level.framedurationseconds);
  }

  level thread bmoendgameot();
}

bmoendgameot() {
  if(istrue(level.gameended)) {
    return;
  }
  level thread handlebmoendgamesplash();
  level thread scripts\mp\gamelogic::endgame(level.brgametype.firstteam, game["end_reason"]["plunder_win"], game["end_reason"]["plunder_loss"], 0, 1);
}

handlebmoendgamesplash() {
  _id_464DD76C6ECB56FA = scripts\mp\gamelogic::getbrendsplashpostgamestate();

  foreach(player in level.players)
  player setclientomnvar("post_game_state", _id_464DD76C6ECB56FA);
}

playerspawnendofgame() {
  if(!istrue(self.controlsfrozen))
    scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "spawnEndOfGame");

  spawnpoint = spawnStruct();
  player = self getspectatingplayer();

  if(!isDefined(player))
    player = self;

  spawnpoint.origin = player.origin;
  spawnpoint.angles = player.angles;

  if(!player isonground()) {
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    spawnpoint.origin = scripts\engine\utility::drop_to_ground(spawnpoint.origin, 0, -20000, undefined, _id_FBCABD62B8F66EB8);
  }

  spawnpoint.origin = spawnpoint.origin + (0, 0, 100);

  if(!isDefined(level.endmatchcamerastriggered)) {
    level.endmatchcamerastriggered = 1;
    level thread triggerbloodmoneyendcameras();
  }

  return 1;
}

eomawardplayerxp() {
  level waittill("give_match_bonus");
  waitframe();
  _id_7C3103094888139A = getdvarfloat("dvar_624DFF063FDC19E4", 1.0);
  _id_E7E8CA63000A1C32 = getdvarfloat("dvar_5776E92FC7E990F4", 1.0);
  _id_E649B857D1DF196F = getdvarint("dvar_A0C1B8638163484E", 10000);
  _id_BCDA60D01EDD703C = getdvarint("dvar_7845F9181D5707BA", 7500);
  _id_563B1704964ABC60 = getdvarint("dvar_163ACA343E614B6E", 5000);

  foreach(team in level.teamnamelist) {
    _id_DA382C87BD272CCB = getteamtokens(team);
    _id_9B88E8A64BD55390 = _id_DA382C87BD272CCB >= getwincost();
    placement = game["teamPlacements"][team];
    _id_8AE4367B9827D09E = 0;

    if(_id_9B88E8A64BD55390)
      _id_8AE4367B9827D09E = _id_BCDA60D01EDD703C;
    else if(placement <= 10)
      _id_8AE4367B9827D09E = _id_563B1704964ABC60;

    players = scripts\mp\utility\teams::getteamdata(team, "players");

    foreach(player in players) {
      player _id_1E4A61DB11011446::stopchallengetimers();

      if(!player scripts\mp\utility\game::rankingenabled() || !player hasplayerdata()) {
        continue;
      }
      player scripts\mp\utility\stats::incpersstat("cash", int(_id_DA382C87BD272CCB / 10000));
      _id_6DAE31F85F556E55 = player.pers["combatXP"];

      if(!isDefined(_id_6DAE31F85F556E55))
        _id_6DAE31F85F556E55 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 0, _id_6DAE31F85F556E55);
      _id_54658E63E8FB96B5 = player.pers["missionXP"];

      if(!isDefined(_id_54658E63E8FB96B5))
        _id_54658E63E8FB96B5 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 1, _id_54658E63E8FB96B5);
      _id_737B512E4921C915 = player.pers["lootingXP"];

      if(!isDefined(_id_737B512E4921C915))
        _id_737B512E4921C915 = 0;

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 2, _id_737B512E4921C915);
      _id_0D239A4DE12B2338 = 0;

      if(isDefined(player.risktokencount))
        _id_0D239A4DE12B2338 = int(player.risktokencount * _id_7C3103094888139A);

      _id_452885D9FFE85530 = 0;

      if(isDefined(player.risktokensbanked))
        _id_452885D9FFE85530 = int(player.risktokensbanked * _id_E7E8CA63000A1C32);

      score = _id_0D239A4DE12B2338 + _id_452885D9FFE85530;

      if(score > 0)
        player scripts\mp\rank::giverankxp("stat_31A9F06F2A47AEFF", score, undefined, 1, 1);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 3, score);
      matchbonus = 0;

      if(isDefined(player.matchbonus))
        matchbonus = int(player.matchbonus);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 4, matchbonus);

      if(_id_8AE4367B9827D09E > 0)
        player scripts\mp\rank::giverankxp("stat_9353D15B3EA6B33C", _id_8AE4367B9827D09E, undefined, 1, 1);

      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 5, _id_8AE4367B9827D09E);
      _id_BF587C66B60EF10F = player getplayerdata(level._id_5D69837CF4DB0407, "aarValue", 6);
      _id_EFE4124EAA21EA43 = _id_BF587C66B60EF10F + player.pers["summary"]["xp"];
      player setplayerdata(level._id_5D69837CF4DB0407, "aarValue", 7, _id_EFE4124EAA21EA43);
    }
  }
}

initendcameralocations() {
  _id_6F0D91B3AB59B3E8 = [];
  level.endcameraorigins = [];
  level.endcameraangles = [];

  if(level.mapname == "mp_br_mechanics") {
    level.endcameraorigins[0] = (8682, -1036, 427);
    level.endcameraangles[0] = (14, 163, 0);
    level.endcameraorigins[1] = (-1139, -3425, 1116);
    level.endcameraangles[1] = (33, 75, 0);
    level.endcameraorigins[2] = (-5567, -4786, 1116);
    level.endcameraangles[2] = (37, 192, 0);
  } else {
    level.endcameraorigins[0] = (-36548, -31983, 2400);
    level.endcameraangles[0] = (12, 72, 0);
    level.endcameraorigins[1] = (-17592, -36440, 1379);
    level.endcameraangles[1] = (17, 90, 0);
    level.endcameraorigins[2] = (-3520, -34298, 1217);
    level.endcameraangles[2] = (11, 110, 0);
    level.endcameraorigins[3] = (-9577, -25957, 360);
    level.endcameraangles[3] = (357, 82, 0);
    level.endcameraorigins[4] = (23022, -26926, 1359);
    level.endcameraangles[4] = (16, 101, 0);
    level.endcameraorigins[5] = (31261, -29753, 1359);
    level.endcameraangles[5] = (27, 52, 0);
    level.endcameraorigins[6] = (44843, -41261, 3220);
    level.endcameraangles[6] = (16, 52, 0);
    level.endcameraorigins[7] = (44229, -15403, 1331);
    level.endcameraangles[7] = (13, 72, 0);
    level.endcameraorigins[8] = (44491, 3484, 1638);
    level.endcameraangles[8] = (23, 11, 0);
    level.endcameraorigins[9] = (16047, -3206, 2613);
    level.endcameraangles[9] = (27, 309, 0);
    level.endcameraorigins[10] = (5668, -5905, 1614);
    level.endcameraangles[10] = (23, 304, 0);
    level.endcameraorigins[11] = (-13412, -20443, 1033);
    level.endcameraangles[11] = (11, 109, 0);
    level.endcameraorigins[12] = (-30369, -7811, 1680);
    level.endcameraangles[12] = (31, 339, 0);
    level.endcameraorigins[13] = (-26278, 4081, 142);
    level.endcameraangles[13] = (6, 110, 0);
    level.endcameraorigins[14] = (-16429, 6021, 847);
    level.endcameraangles[14] = (21, 57, 0);
    level.endcameraorigins[15] = (-7525, 11672, 1082);
    level.endcameraangles[15] = (14, 46, 0);
    level.endcameraorigins[16] = (8356, 15296, 2021);
    level.endcameraangles[16] = (12, 38, 0);
    level.endcameraorigins[17] = (26010, 29975, 2716);
    level.endcameraangles[17] = (13, 68, 0);
    level.endcameraorigins[18] = (12043, 30910, 3081);
    level.endcameraangles[18] = (21, 88, 0);
    level.endcameraorigins[19] = (7127, 52592, 2100);
    level.endcameraangles[19] = (28, 241, 0);
    level.endcameraorigins[20] = (-6693, 56481, 4026);
    level.endcameraangles[20] = (16, 246, 0);
    level.endcameraorigins[21] = (-21394, 37175, 757);
    level.endcameraangles[21] = (2, 124, 0);
    level.endcameraorigins[22] = (-26151, 25577, 271);
    level.endcameraangles[22] = (357, 10, 0);
  }

  if(0)
    endcameradebug_think();
}

triggerbloodmoneyendcameras() {
  _id_CDFA1020BBC3F969 = 0;

  foreach(player in level.players) {
    player thread playmatchendcamera(player, getbestcameraindex(player));
    _id_CDFA1020BBC3F969++;

    if(_id_CDFA1020BBC3F969 == 5) {
      waitframe();
      _id_CDFA1020BBC3F969 = 0;
    }
  }
}

endcameradebug_think() {
  for(;;) {
    _id_ED43777427F1DC38 = getdvarint("dvar_F91D2C0618ED9086", -1);

    if(_id_ED43777427F1DC38 > -1) {
      playmatchendcamera(level.players[0], getbestcameraindex(level.players[0]));
      setDvar("dvar_F91D2C0618ED9086", -1);
    }

    waitframe();
  }
}

getbestcameraindex(player) {
  _id_BCD1F02C15CF8F02 = undefined;
  _id_00BF97AF9158BCF3 = undefined;

  foreach(index, origin in level.endcameraorigins) {
    dist = distance2dsquared(player.origin, origin);

    if(dist <= 9000000)
      return index;

    if(!isDefined(_id_00BF97AF9158BCF3) || _id_00BF97AF9158BCF3 > dist) {
      _id_00BF97AF9158BCF3 = dist;
      _id_BCD1F02C15CF8F02 = index;
    }
  }

  return _id_BCD1F02C15CF8F02;
}

playmatchendcamera(player, _id_59D945F45B4733EE) {
  _id_E0134DCE95218ED1 = level.endcameraorigins[_id_59D945F45B4733EE];
  _id_06E88057A6FA92C7 = level.endcameraangles[_id_59D945F45B4733EE];
  _id_F0FFC87D0DB8E9F0 = _id_E0134DCE95218ED1 + anglestoright(_id_06E88057A6FA92C7) * 1000;
  _id_9A8CB976407AE8C2 = _id_06E88057A6FA92C7;
  _id_5940F376A254619D = spawn("script_model", _id_E0134DCE95218ED1);
  _id_5940F376A254619D setModel("tag_origin");
  _id_5940F376A254619D.angles = _id_06E88057A6FA92C7;
  player cameralinkTo(_id_5940F376A254619D, "tag_origin");
  _id_5940F376A254619D moveTo(_id_F0FFC87D0DB8E9F0, 60);
  _id_5940F376A254619D rotateTo(_id_9A8CB976407AE8C2, 60);

  if(0) {
    wait 5;
    player cameraunlink();
  }
}

printallteamsplundercount() {
  wait 1;
  _id_620F245E58FF4740 = getwincost();
  _id_DDD20D819A369A7D = tablesort(game["teamPlacements"], "up");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_DDD20D819A369A7D.size - 1; _id_AC0E594AC96AA3A8++) {
    if(isDefined(level.teamdata[_id_DDD20D819A369A7D[_id_AC0E594AC96AA3A8]]["tokensTeamTotal"]))
      _id_DA382C87BD272CCB = getteamtokens(_id_DDD20D819A369A7D[_id_AC0E594AC96AA3A8]);
  }
}

setupdomplates() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.labels = ["_a", "_b", "_c", "_d", "_e", "_a", "_b", "_c", "_d", "_e", "_a", "_b", "_c", "_d", "_e", "_a", "_b", "_c", "_d", "_e"];
  level.labelsused = 0;
  level.risktokens = [];
  level.objectives = [];
  level.setdomscriptablepartstatefunc = ::domflag_setdomscriptablepartstate;

  if(level.mapname != "mp_br_mechanics")
    thread _id_15D88F6CA7A3D127::init();
  else {
    origins = [(-751, -1925, 0), (-1412, -1646, 0), (-2075, -1462, 0), (-2581, -1956, 0), (-2581, -2056, 0), (-2581, -2156, 0), (-2581, -2256, 0), (-2581, -2356, 0), (-2581, -2456, 0), (-2581, -2556, 0), (-2581, -2756, 0), (-2581, -2856, 0), (-2581, -2956, 0), (-2581, -3056, 0), (-2581, -3156, 0)];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < origins.size; _id_AC0E594AC96AA3A8++) {
      label = level.labels[_id_AC0E594AC96AA3A8];

      if(_id_AC0E594AC96AA3A8 == level.labels.size)
        label = level.labels[0];

      level.objectives[level.objectives.size] = spawndomplateflagtestmap(origins[_id_AC0E594AC96AA3A8], label);
    }
  }
}

spawndomplates(firsttime) {
  level thread announcedomplatespawns(firsttime);
  _id_9577902B42FBD7F6 = level.risk_currentlocsinuse;
  _id_887D42B1410C39FE = 0;

  foreach(key, _id_E035FDEF423A5164 in _id_9577902B42FBD7F6) {
    if(level.objectives.size > 0) {
      _id_887D42B1410C39FE = 0;

      foreach(_id_7F01BBBC747F5EA1 in level.objectives) {
        if(_id_7F01BBBC747F5EA1.locindex == _id_E035FDEF423A5164.index) {
          _id_887D42B1410C39FE = 1;
          break;
        }
      }
    }

    if(_id_887D42B1410C39FE) {
      continue;
    }
    label = level.labels[level.labelsused];

    if(level.labelsused == level.labels.size) {
      level.labelsused = 0;
      label = level.labels[level.labelsused];
    } else
      level.labelsused++;

    level.objectives[level.objectives.size] = spawndomplateflag(_id_E035FDEF423A5164, label);
  }
}

getdomplateradius(loc) {
  radius = 128;

  if(loc.spawnflags & 4)
    radius = 256;
  else if(loc.spawnflags & 1)
    radius = 128;
  else if(loc.spawnflags & 1)
    radius = 168;

  return radius;
}

spawndomplateflag(loc, label) {
  radius = getdomplateradius(loc);

  if(getdvarint("dvar_5FD1C183D1C229FA", 400) > 0)
    radius = getdvarint("dvar_5FD1C183D1C229FA", 400);

  height = 120;
  tracestart = loc.origin + (0, 0, 64);
  _id_8B39E5984DA1FFAF = loc.origin + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  origin = trace["position"];
  trigger = spawn("trigger_radius", origin, 0, radius, height);
  trigger.script_label = label;
  domflag = _id_6663215F917210AE::setupobjective(trigger, undefined);
  domflag scripts\mp\gameobjects::setcapturebehavior("persistent");
  domflag scripts\mp\gameobjects::setusetime(level.domplatecapturetime);
  domflag.ignorestomp = 1;
  objective_sethideelevation(domflag.objidnum, 1);
  domflag.onuse = ::dompoint_onuse;
  domflag.onbeginuse = ::dompoint_onusebegin;
  domflag.onuseupdate = ::dompoint_onuseupdate;
  domflag.onenduse = ::dompoint_onuseend;
  domflag.oncontested = ::dompoint_oncontested;
  domflag.onuncontested = ::dompoint_onuncontested;
  domflag.onunoccupied = ::dompoint_onunoccupied;
  domflag.onpinnedstate = ::dompoint_onpinnedstate;
  domflag.onunpinnedstate = ::dompoint_onunpinnedstate;
  domflag.stompprogressreward = ::dompoint_stompprogressreward;
  domflag.locindex = loc.index;
  domflag thread rundomplateskybeam(domflag);
  return domflag;
}

rundomplateskybeam(domflag) {
  domflag.beacon = spawn("script_model", domflag.trigger.origin);
  domflag.beacon setModel("risk_dom_plate");
  domflag.beacon setscriptablepartstate("risk_dom_beacon", "on", 0);
}

dompoint_onuseupdate(team, progress, _id_301D62DA1A0738F1, _id_4B22E50E504339FE) {
  if(progress < 1.0 && !level.gameended)
    play_spotrep_capture_sfx(progress, team);

  if(progress > 0.05 && _id_301D62DA1A0738F1 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

dompoint_onusebegin(_id_22282E7D48CA3400) {
  if(!isDefined(self.obj_icon_revealed) || !self.obj_icon_revealed) {
    self.obj_icon_revealed = 1;
    level thread _id_64ACB6CE534155B7::utilflare_shootflare(self.curorigin, "dom");
    playerteam = scripts\mp\utility\player::getteamarray(_id_22282E7D48CA3400.team);
    playersinrange = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, playerteam);

    foreach(player in playersinrange) {
      if(isDefined(player) && isalive(player))
        player thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
    }

    _id_96674628376EABA6 = scripts\mp\utility\teams::getfriendlyplayers(_id_22282E7D48CA3400.team, 0);

    foreach(_id_F0EA4030349A33D5 in _id_96674628376EABA6)
    _id_F0EA4030349A33D5 notify("calloutmarkerping_warzoneKillQuestIcon");
  }
}

dompoint_onuse(_id_22282E7D48CA3400) {
  team = _id_22282E7D48CA3400.team;
  level spawnrisktoken(self.trigger, team);

  if(self.touchlist[team].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  foreach(name in level.teamnamelist) {
    if(isDefined(self.assisttouchlist[name]) && name != team)
      self.assisttouchlist[name] = [];
  }

  if(isDefined(self.assisttouchlist[team])) {
    _id_59DB5D0F4E3000A7 = getarraykeys(self.assisttouchlist[team]);

    foreach(playerid in _id_59DB5D0F4E3000A7) {
      player = self.assisttouchlist[team][playerid].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player))
        continue;
    }
  }

  thread giveflagcapturexp(self.touchlist[team], _id_22282E7D48CA3400, team);
  scripts\mp\gameobjects::allowuse("none");
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();
  self.beacon setscriptablepartstate("risk_dom_beacon", "off");
  self.beacon setscriptablepartstate("visibility", "hide", 0);
  self.beacon delete();

  if(isDefined(self.trigger)) {
    self.trigger = undefined;
    _id_15D88F6CA7A3D127::riskspawn_flagcaptured(self.locindex);
  }

  self.visibleteam = "none";
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
  self.scriptable delete();
  self.flagmodel delete();
  self notify("deleted");
}

dompoint_onuseend(team, player, success) {}

dompoint_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
}

dompoint_onuncontested(lastclaimteam) {
  if(istrue(level.flagneutralization) && !self.firstcapture)
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);

  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral") {
    if(lastclaimteam != "none")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, lastclaimteam);
    else if(isDefined(self.lastprogressteam))
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, self.lastprogressteam);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(ownerteam)[0]);

  if(lastclaimteam == "none" || ownerteam == "neutral") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

dompoint_onunoccupied() {
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral")
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
  else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  self.didstatusnotify = 0;
}

dompoint_onpinnedstate(player) {
  if(self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

dompoint_onunpinnedstate(player) {
  if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

dompoint_stompprogressreward(player) {
  player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F648E4847B740818");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

giveflagcapturexp(touchlist, _id_22282E7D48CA3400, team) {
  level endon("game_ended");
  _id_0666D6B1872868D7 = _id_22282E7D48CA3400;

  if(isDefined(_id_0666D6B1872868D7.owner))
    _id_0666D6B1872868D7 = _id_0666D6B1872868D7.owner;

  if(isPlayer(_id_0666D6B1872868D7))
    level thread scripts\mp\hud_util::teamplayercardsplash("callout_securedposition" + self.objectivekey, _id_0666D6B1872868D7);

  if(isDefined(touchlist)) {
    _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

    for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
      player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player)) {
        continue;
      }
      givecaptureawards(player, 0);
      wait 0.05;
    }

    if(isDefined(self.assisttouchlist)) {
      if(self.assisttouchlist[team].size > 0) {
        _id_9EB80458EF362367 = getarraykeys(self.assisttouchlist[team]);

        foreach(id in _id_59DB5D0F4E3000A7) {
          foreach(_id_2C6D54A195121E5F in _id_9EB80458EF362367) {
            if(_id_2C6D54A195121E5F == id)
              self.assisttouchlist[team][_id_2C6D54A195121E5F] = undefined;
          }
        }
      }

      if(self.assisttouchlist[team].size > 0)
        thread giveflagcaptureassistxp(team);
    }
  }
}

giveflagcaptureassistxp(team) {
  level endon("game_ended");
  _id_9EB80458EF362367 = getarraykeys(self.assisttouchlist[team]);

  if(_id_9EB80458EF362367.size > 0) {
    for(index = 0; index < _id_9EB80458EF362367.size; index++) {
      player = self.assisttouchlist[team][_id_9EB80458EF362367[index]].player;

      if(isDefined(player.owner))
        player = player.owner;

      if(!isPlayer(player)) {
        continue;
      }
      givecaptureawards(player, 1);
      self.assisttouchlist[team][_id_9EB80458EF362367[index]] = undefined;
      wait 0.05;
    }
  }
}

givecaptureawards(player, _id_C9DB681C20FEFFE2) {
  _id_460513A84DF1C3A4 = 0;
  _id_534BE0691DDBB3BA = "stat_5A7B15A24E10A93B";

  if(_id_C9DB681C20FEFFE2) {
    player thread scripts\mp\rank::scoreeventpopup("stat_971A82E17E683215");
    _id_534BE0691DDBB3BA = "stat_7A10D07E9CC5745B";
  } else
    player thread scripts\mp\rank::scoreeventpopup("stat_F4CD65EB4AA3FD61");

  player thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_534BE0691DDBB3BA);
}

play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    _id_C3DDFB0EAA8F761C = "";
    progress = int(floor(progress * 10));
    _id_C3DDFB0EAA8F761C = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(_id_C3DDFB0EAA8F761C, team);
  }
}

domflag_setdomscriptablepartstate(part, state, _id_BA360E4FF7BE8D96) {
  switch (state) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      state = "using";

      if(isDefined(_id_BA360E4FF7BE8D96))
        state = state + _id_BA360E4FF7BE8D96;

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse")
        self.scriptable setscriptablepartstate("flag", state);

      return 1;
  }
}

domflag_usecondition(player) {
  playerteam = player.team;

  foreach(instance in self.locale.subscribedinstances) {
    if(instance.team == playerteam)
      return 1;
  }

  return 0;
}

dom_ontimerexpired() {
  while(self.subscribedlocale.domflag.numtouching[self.id])
    waitframe();

  _id_64ACB6CE534155B7::displayteamsplash(self.id, "br_domination_quest_timer_expired");
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("mission_gen_fail", self.team, 1);
}

spawnrisktoken(ent, team) {
  startpos = ent.origin + (0, 0, 14);
  _id_9C19496CE8106E6B = startpos + (0, 0, 80);
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);
  _id_A73587155F07BD39 = randomfloatrange(30, 150);
  _id_90128D0639A1315D = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_B809B8F732448A84 = playerphysicstrace(startpos, _id_90128D0639A1315D);
  _id_A352C335ED5456E3 = spawnscriptable("brloot_risk_token", _id_B809B8F732448A84, ent.angles);
  _id_A352C335ED5456E3 setscriptablepartstate("brloot_risk_token", "dropped");
  playsoundatpos(ent.origin, "mp_killconfirm_tags_drop");
}

scriptable_token_scriptable_touched_callback(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance)) {
    return;
  }
  if(instance.type != "brloot_risk_token") {
    return;
  }
  instance setscriptablepartstate("brloot_risk_token", "hidden");
  player.risktokencount = player.risktokencount + 1;
  level.teamdata[player.team]["tokensTeamTotal"] = level.teamdata[player.team]["tokensTeamTotal"] + 1;
  playsoundatpos(player.origin, "mp_killconfirm_tags_pickup");
}

spawndogtagtoken(spawnpoint, ownerteam) {
  visuals = [];
  visuals[0] = spawn("script_model", (0, 0, 0));
  visuals[0] setModel("military_dogtags_iw8_blue");
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  useteam = ownerteam;
  usetime = 0;
  _id_E921CD2D3FB29B66 = scripts\mp\gameobjects::createuseobject(useteam, trigger, visuals, (0, 0, 16));
  _id_E921CD2D3FB29B66.onuse = ::risktokenonuse;
  _id_E921CD2D3FB29B66 scripts\mp\gameobjects::setusetime(usetime);
  _id_E921CD2D3FB29B66.trigger enablelinkTo();
  startpos = spawnpoint + (0, 0, 14);
  _id_9C19496CE8106E6B = startpos + (0, 0, 80);
  randomangle = (0, randomfloat(360), 0);
  _id_A76189155F382805 = anglesToForward(randomangle);
  _id_A73587155F07BD39 = randomfloatrange(30, 150);
  _id_57C87883AE437750 = 0.5;
  _id_90128D0639A1315D = startpos + _id_A73587155F07BD39 * _id_A76189155F382805;
  _id_B809B8F732448A84 = playerphysicstrace(startpos, _id_90128D0639A1315D);
  _id_E921CD2D3FB29B66.curorigin = _id_9C19496CE8106E6B;
  _id_E921CD2D3FB29B66.trigger.origin = _id_9C19496CE8106E6B;
  _id_E921CD2D3FB29B66.visuals[0].origin = _id_9C19496CE8106E6B;
  _id_E921CD2D3FB29B66 scripts\mp\gameobjects::allowuse("any");
  _id_E921CD2D3FB29B66.visuals[0] setscriptablepartstate("visibility", "show", 0);
  _id_E921CD2D3FB29B66.trigger linkTo(_id_E921CD2D3FB29B66.visuals[0], "tag_origin");
  _id_E921CD2D3FB29B66 thread tagmoveTo(_id_9C19496CE8106E6B, _id_B809B8F732448A84, _id_57C87883AE437750);

  if(isDefined(_id_E921CD2D3FB29B66.objidnum)) {
    if(_id_E921CD2D3FB29B66.objidnum != -1) {
      objid = _id_E921CD2D3FB29B66.objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(objid, "current");
      scripts\mp\objidpoolmanager::update_objective_position(objid, _id_B809B8F732448A84 + (0, 0, 36));
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(_id_E921CD2D3FB29B66.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(_id_E921CD2D3FB29B66.objidnum, 0);
      _id_E921CD2D3FB29B66 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      _id_E921CD2D3FB29B66 scripts\mp\gameobjects::setvisibleteam("any");
    }
  }

  _id_E921CD2D3FB29B66.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  playsoundatpos(_id_B809B8F732448A84, "mp_killconfirm_tags_drop");
}

tagmoveTo(_id_9C19496CE8106E6B, _id_B809B8F732448A84, time) {
  gravity = getdvarint("bg_gravity");
  dist = distance(_id_9C19496CE8106E6B, _id_B809B8F732448A84);
  _id_3777ECE6A73EADA5 = _id_B809B8F732448A84 - _id_9C19496CE8106E6B;
  _id_920F4173513EB6B8 = 0.5 * gravity * squared(time) * -1;
  vel = (_id_3777ECE6A73EADA5[0] / time, _id_3777ECE6A73EADA5[1] / time, (_id_3777ECE6A73EADA5[2] - _id_920F4173513EB6B8) / time);
  self.visuals[0] movegravity(vel, time);
}

risktokenonuse(player) {
  player.risktokencount = player.risktokencount + 1;
  level.teamdata[player.team]["tokensTeamTotal"] = level.teamdata[player.team]["tokensTeamTotal"] + 1;
  self.trigger playSound("mp_killconfirm_tags_pickup");
  scripts\mp\gameobjects::allowuse("none");
  self.visuals[0] delete();
  self notify("death");

  if(!isDefined(self.skipminimapids))
    thread scripts\mp\gameobjects::deleteuseobject();
}

seticonnames() {
  _id_A443300A7CC92EF0 = 0;
  _setdomflagiconinfo("icon_waypoint_dom_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("icon_waypoint_dom_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("icon_waypoint_dom_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("icon_waypoint_dom_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("icon_waypoint_dom_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_taking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_taking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_taking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_taking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_taking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_capture_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_capture_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_capture_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_capture_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_capture_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defend_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defend_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defend_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defend_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defend_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_defending_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_defending_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_defending_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_defending_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_defending_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_blocking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_blocking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_blocking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_blocking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_blocking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_blocked_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_blocked_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_blocked_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_blocked_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_blocked_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_losing_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_losing_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_losing_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_losing_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_losing_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_captureneutral_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0);
  _setdomflagiconinfo("waypoint_captureneutral_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0);
  _setdomflagiconinfo("waypoint_captureneutral_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0);
  _setdomflagiconinfo("waypoint_captureneutral_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0);
  _setdomflagiconinfo("waypoint_captureneutral_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0);
  _setdomflagiconinfo("waypoint_contested_a", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  _setdomflagiconinfo("waypoint_contested_b", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
  _setdomflagiconinfo("waypoint_contested_c", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1);
  _setdomflagiconinfo("waypoint_contested_d", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1);
  _setdomflagiconinfo("waypoint_contested_e", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1);
  _setdomflagiconinfo("waypoint_dom_target_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  _setdomflagiconinfo("waypoint_dom_target_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  _setdomflagiconinfo("waypoint_dom_target_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  _setdomflagiconinfo("waypoint_dom_target_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  _setdomflagiconinfo("waypoint_dom_target_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  level.iconneutral = "waypoint_captureneutral";
  level.iconcapture = "waypoint_capture";
  level.icondefend = "waypoint_defend";
  level.icondefending = "waypoint_defending";
  level.iconcontested = "waypoint_contested";
  level.icontaking = "waypoint_taking";
  level.iconlosing = "waypoint_losing";
}

_setdomflagiconinfo(name, _id_96D1603BEEEFA4EA, colors, string, image, _id_B50E35D9C370899B) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = _id_96D1603BEEEFA4EA;
  level.waypointstring[name] = string;
  level.waypointshader[name] = image;
  level.waypointpulses[name] = _id_B50E35D9C370899B;
}

initdialog() {
  wait 1;
  game["dialog"]["gametype"] = "gametype_bmo";
  game["dialog"]["match_start"] = "gametype_bmo";
  game["dialog"]["boost_short"] = "boost_bmo_short";
  game["dialog"]["offense_obj"] = "boost_bmo";
  game["dialog"]["defense_obj"] = "boost_bmo";
  game["dialog"]["contract_hold_area"] = "bm_contract_hold_area";
  game["dialog"]["contract_loot_chests"] = "bm_contract_loot_chests";
  game["dialog"]["contract_kill_target"] = "bm_contract_kill_target";
  game["dialog"]["event_chopper"] = "bm_event_chopper";
  game["dialog"]["event_airdrop"] = "bm_event_airdrop";
  game["dialog"]["extract_enabled"] = "bm_extract_enabled";
  game["dialog"]["gamestate_25_perc"] = "bm_gamestate_25_perc";
  game["dialog"]["gamestate_50_perc"] = "bm_gamestate_50_perc";
  game["dialog"]["gamestate_75_perc"] = "bm_gamestate_75_perc";
  game["dialog"]["gamestate_90_perc"] = "bm_gamestate_90_perc";
  game["dialog"]["gamestate_25_perc_enemy"] = "bm_gamestate_25_perc_enemy";
  game["dialog"]["gamestate_50_perc_enemy"] = "bm_gamestate_50_perc_enemy";
  game["dialog"]["gamestate_75_perc_enemy"] = "bm_gamestate_75_perc_enemy";
  game["dialog"]["gamestate_90_perc_enemy"] = "bm_gamestate_90_perc_enemy";
  game["dialog"]["gamestate_25_perc_first"] = "bm_gamestate_25_perc_first";
  game["dialog"]["gamestate_50_perc_first"] = "bm_gamestate_50_perc_first";
  game["dialog"]["gamestate_75_perc_first"] = "bm_gamestate_75_perc_first";
  game["dialog"]["gamestate_90_perc_first"] = "bm_gamestate_90_perc_first";
  game["dialog"]["lead_lost"] = "bm_gamestate_lead_lost";
  game["dialog"]["lead_taken"] = "bm_gamestate_lead_taken";
  game["dialog"]["mission_failure"] = "bm_gamestate_lost";
  game["dialog"]["mission_success"] = "bm_gamestate_win";
  game["dialog"]["gamestate_top_3"] = "bm_gamestate_top_3";
  game["dialog"]["gamestate_top_5"] = "bm_gamestate_top_5";
  game["dialog"]["gamestate_top_10"] = "bm_gamestate_top_10";
  game["dialog"]["bm_gamestate_overtime"] = "bm_gamestate_overtime_million_cash_deposited";
  game["dialog"]["bm_gamestate_overtime_enemy"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_get_cash"] = "bm_tut_get_cash";
  game["dialog"]["bm_tut_earn_cash"] = "bm_tut_earn_cash";
  game["dialog"]["bm_tut_loot_cash"] = "bm_tut_loot_cash";
  game["dialog"]["event_bank"] = "event_bank";
  game["dialog"]["exfil_arrived"] = "exfil_arrived";
  game["dialog"]["exfil_failed"] = "exfil_failed";
  game["dialog"]["exfil_inbound"] = "exfil_inbound";
  game["dialog"]["exfil_leaving"] = "exfil_leaving";
  game["dialog"]["exfil_start_generic"] = "exfil_start_generic";
  game["dialog"]["exfil_start_win"] = "exfil_start_win";
  game["dialog"]["exfil_start_win_lz"] = "exfil_start_win_lz";
  game["dialog"]["exfil_success_full"] = "exfil_success_full";
  game["dialog"]["exfil_success_partial"] = "exfil_success_partial";
}

watchparachutersoverhead(_id_2B029FE0E94CB290) {
  level endon("game_ended");
  level endon("cancel_watch_parachuters_overhead");

  for(;;) {
    foreach(xuid, player in level.activeparachuters) {
      if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player) || !(player isparachuting() || player isinfreefall())) {
        level.activeparachuters[xuid] = undefined;
        continue;
      }

      _id_78122E18403A8DC4 = scripts\common\utility::playersincylinder(player.origin, level.parachuteoverheadwarningradius, undefined, level.parachuteoverheadwarningheight);
      _id_55B4FA124C5108FF = player.team;

      foreach(targetplayer in _id_78122E18403A8DC4) {
        if(isDefined(targetplayer.c130)) {
          continue;
        }
        _id_8B1B7044E27E6A56 = _id_55B4FA124C5108FF == targetplayer.team;

        if(_id_8B1B7044E27E6A56) {
          continue;
        }
        _id_CDA71AEC07AAB082 = !scripts\mp\utility\player::isreallyalive(targetplayer) || istrue(targetplayer.inlaststand);

        if(_id_CDA71AEC07AAB082) {
          continue;
        }
        _id_744496CCCBBFCB78 = targetplayer isparachuting() || targetplayer isinfreefall();

        if(_id_744496CCCBBFCB78) {
          continue;
        }
        time = gettime();
        _id_008EDFF54C680323 = isDefined(targetplayer.heardparachuteoverheadtime) && time - targetplayer.heardparachuteoverheadtime < _id_2B029FE0E94CB290;

        if(_id_008EDFF54C680323) {
          continue;
        }
        targetplayer.heardparachuteoverheadtime = time;
        _id_95CE4F91D0F58568 = _id_2CEDCC356F1B9FC8::brgetoperatorteam(targetplayer);
        _id_7570AFA45D86040F = game["voice"][_id_95CE4F91D0F58568];
        targetplayer queuedialogforplayer(level.activeparachutersfactionvo[_id_7570AFA45D86040F], "respawning_enemy_in_area", 2);
      }

      waitframe();
    }

    waitframe();
  }
}

spawndomplateflagtestmap(origin, label) {
  radius = 300;
  height = 128;
  tracestart = origin + (0, 0, 64);
  _id_8B39E5984DA1FFAF = origin + (0, 0, -64);
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, undefined, scripts\engine\trace::create_default_contents(1));
  origin = trace["position"];
  trigger = spawn("trigger_radius", origin, 0, radius, height);
  trigger.script_label = label;
  domflag = _id_6663215F917210AE::setupobjective(trigger, undefined);
  domflag scripts\mp\gameobjects::setcapturebehavior("persistent");
  domflag scripts\mp\gameobjects::setusetime(level.domplatecapturetime);
  domflag.ignorestomp = 1;
  objective_sethideelevation(domflag.objidnum, 1);
  domflag.onuse = ::dompoint_onuse;
  domflag.onbeginuse = ::dompoint_onusebegin;
  domflag.onuseupdate = ::dompoint_onuseupdate;
  domflag.onenduse = ::dompoint_onuseend;
  domflag.oncontested = ::dompoint_oncontested;
  domflag.onuncontested = ::dompoint_onuncontested;
  domflag.onunoccupied = ::dompoint_onunoccupied;
  domflag.onpinnedstate = ::dompoint_onpinnedstate;
  domflag.onunpinnedstate = ::dompoint_onunpinnedstate;
  domflag.stompprogressreward = ::dompoint_stompprogressreward;
  domflag thread rundomplateskybeam(domflag);
  return domflag;
}

announcedomplatespawns(firsttime) {
  if(istrue(firsttime))
    wait 18;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_64ACB6CE534155B7::displayteamsplash(_id_F90358454413407F, "br_risk_flags_spawn");
    level thread _id_2CEDCC356F1B9FC8::brleaderdialogteam("contract_hold_area", _id_F90358454413407F, 1, undefined, "bm");
  }
}