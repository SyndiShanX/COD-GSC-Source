/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_awards.gsc
***********************************************/

init() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  initawards();
  level thread saveaarawardsonroundswitch();
}

onplayerconnect() {
  thread initaarawardlist();
  self.awardqueue = [];
}

onplayerspawned() {
  self.awardsthislife = [];
}

initawards() {
  scripts\engine\utility::flag_init("cp_operator_unlock_ids_initted");
  initmidmatchawards();
  initoperatorunlocks();
  scripts\engine\utility::flag_set("cp_operator_unlock_ids_initted");
}

initoperatorunlocks() {
  level.operator_unlock_ids = [];
  count = 0;

  for(;;) {
    _id_015AD24E2FBEEE5D = tablelookupbyrow("cp_reward_ids.csv", count, 2);

    if(isDefined(_id_015AD24E2FBEEE5D) && _id_015AD24E2FBEEE5D != "") {
      struct = spawnStruct();
      id = tablelookup("cp_reward_ids.csv", 2, _id_015AD24E2FBEEE5D, 1);
      unique_id = tablelookup("cp_reward_ids.csv", 2, _id_015AD24E2FBEEE5D, 0);
      struct.operator_reward_id = int(id);
      struct.id = int(unique_id);
      level.operator_unlock_ids[_id_015AD24E2FBEEE5D] = struct;
      count++;
    } else
      break;

    waitframe();
  }

  level.juggernaut_kills_tracker = 0;
}

_id_6DF0786B01EC7028(ref) {
  aarpriority = tablelookup("mp/awardtable.csv", 0, ref, 1);

  if(isDefined(aarpriority) && aarpriority > 0) {
    _id_908FFEB2459E73AF = randomfloat(1.0);
    level._id_6D808D6C553C2D9A[ref] = float(aarpriority) + _id_908FFEB2459E73AF;
  }
}

initmidmatchaward(ref) {
  _id_6DF0786B01EC7028(ref);
}

initmidmatchawards() {
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow("mp/awardtable.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    initmidmatchaward(ref);
    _id_CB89110314447B2F++;
  }
}

incplayerrecord(ref) {
  _id_F313905DFF43D261 = self getplayerdata("common", "awards", ref);
  self setplayerdata("common", "awards", ref, _id_F313905DFF43D261 + 1);
}

giveaward(ref, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, immediate, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F) {
  if(!istrue(immediate)) {
    self endon("disconnect");
    waitframe();
  }

  if(!_id_187A04151C40FB72::_id_034294184E90B96C(ref)) {
    return;
  }
  if(isenumvaluevalid("mp", "Awards", _func_0F28FD66285FA2C9(ref)))
    addawardtoaarlist(ref);

  xp = _id_4B5A99C16ABFDFB1;

  if(!isDefined(xp))
    xp = _id_187A04151C40FB72::_id_D06C3CBB904AE29B(ref);

  if(isDefined(xp) && xp > 0)
    _id_187A04151C40FB72::giverankxp(ref, xp, objweapon);

  if(!isDefined(_id_91185FF4A2E16A72)) {
    points = _id_187A04151C40FB72::getscoreinfovalue(ref);
    _id_91185FF4A2E16A72 = scripts\engine\utility::_id_53C4C53197386572(points, 0);
  }

  if(_id_91185FF4A2E16A72 > 0)
    _id_41AE4F5CA24216CB::giveunifiedpoints(ref, objweapon, _id_91185FF4A2E16A72, -1, victim, _id_F459A13A227B8DE6, streakinfo, undefined, _id_7EC7671A1E0C788F);

  scripts\cp\utility\script::bufferednotify("earned_award_buffered", ref);

  if(isDefined(self.awardsthislife[ref]))
    self.awardsthislife[ref]++;
  else
    self.awardsthislife[ref] = 1;

  scripts\common\utility::trycall(level.matchdata_logaward, ref);
}

queuemidmatchaward(ref, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo) {
  _id_6DFAC1DD9D7FFAE2 = spawnStruct();
  _id_6DFAC1DD9D7FFAE2.ref = ref;
  _id_6DFAC1DD9D7FFAE2.objweapon = objweapon;
  _id_6DFAC1DD9D7FFAE2._id_91185FF4A2E16A72 = _id_91185FF4A2E16A72;
  _id_6DFAC1DD9D7FFAE2._id_4B5A99C16ABFDFB1 = _id_4B5A99C16ABFDFB1;
  _id_6DFAC1DD9D7FFAE2._id_51BDAE03B05BC75E = _id_51BDAE03B05BC75E;
  _id_6DFAC1DD9D7FFAE2._id_30E33D4E4669117F = _id_30E33D4E4669117F;
  _id_6DFAC1DD9D7FFAE2.victim = victim;
  _id_6DFAC1DD9D7FFAE2._id_F459A13A227B8DE6 = _id_F459A13A227B8DE6;
  _id_6DFAC1DD9D7FFAE2.streakinfo = streakinfo;
  self.awardqueue[self.awardqueue.size] = _id_6DFAC1DD9D7FFAE2;
  thread flushmidmatchawardqueuewhenable();
}

flushmidmatchawardqueue() {
  foreach(_id_A773025016ED337A in self.awardqueue)
  givemidmatchaward(_id_A773025016ED337A.ref, _id_A773025016ED337A.objweapon, _id_A773025016ED337A._id_91185FF4A2E16A72, _id_A773025016ED337A._id_4B5A99C16ABFDFB1, _id_A773025016ED337A._id_51BDAE03B05BC75E, _id_A773025016ED337A._id_30E33D4E4669117F, _id_A773025016ED337A.victim, _id_A773025016ED337A._id_F459A13A227B8DE6, _id_A773025016ED337A.streakinfo);

  self.awardqueue = [];
}

flushmidmatchawardqueuewhenable() {
  self endon("disconnect");
  self notify("flushMidMatchAwardQueueWhenAble()");
  self endon("flushMidMatchAwardQueueWhenAble()");

  for(;;) {
    if(!shouldqueuemidmatchaward()) {
      break;
    }

    waitframe();
  }

  thread flushmidmatchawardqueue();
}

shouldqueuemidmatchaward(_id_3CDA0E0B6A2D1F97) {
  if(level.gameended)
    return 0;

  if(!scripts\cp\utility\player::isreallyalive(self)) {
    if(!istrue(_id_3CDA0E0B6A2D1F97) || scripts\cp\utility\player::isinkillcam()) {
      if(!scripts\cp\utility\player::isusingremote())
        return 1;
    }
  }

  return 0;
}

givemidmatchaward(ref, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F) {
  if(!isPlayer(self)) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(istrue(level.gameended)) {
    isvalidevent = 0;

    if(isarray(ref)) {
      if(isnumber(level.gameendtime)) {
        if(ref[1] <= level.gameendtime) {
          isvalidevent = 1;
          ref = ref[0];
        }
      }
    } else if(isDefined(ref))
      isvalidevent = 1;

    if(!isvalidevent)
      return;
  } else if(isarray(ref))
    ref = ref[0];

  if(!_func_D03495FE6418377B(ref))
    ref = _func_1823FF50BB28148D(ref);

  if(self ispcplayer() && scripts\cp\utility::gameflag("prematch_done"))
    createnvidiavideo(ref);

  if(shouldqueuemidmatchaward(_id_51BDAE03B05BC75E)) {
    queuemidmatchaward(ref, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_51BDAE03B05BC75E, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo);
    return;
  }

  thread giveaward(ref, objweapon, _id_91185FF4A2E16A72, _id_4B5A99C16ABFDFB1, _id_30E33D4E4669117F, victim, _id_F459A13A227B8DE6, streakinfo, _id_AD8C6C5CC50AF10B, _id_7EC7671A1E0C788F);
}

createnvidiavideo(ref) {
  _id_7861CC7F1384834E = undefined;

  if(ref == "stat_AA851578EFEA8575")
    _id_7861CC7F1384834E = 1;
  else if(ref == "stat_01359A3079F1D01E")
    _id_7861CC7F1384834E = 2;
  else if(ref == "stat_FA09C7954013CDF0")
    _id_7861CC7F1384834E = 3;
  else if(ref == "stat_F3D5ADB30A50AA6D")
    _id_7861CC7F1384834E = 4;
  else if(ref == "stat_F3D913B30A538D96")
    _id_7861CC7F1384834E = 5;
  else if(ref == "stat_F3DC99B30A56A71F")
    _id_7861CC7F1384834E = 6;
  else if(ref == "stat_8368A43E439D8A67")
    _id_7861CC7F1384834E = 7;
  else if(ref == "stat_29065087E352EB71")
    _id_7861CC7F1384834E = 8;

  if(isDefined(_id_7861CC7F1384834E))
    self setclientomnvar("nVidiaHighlights_events", _id_7861CC7F1384834E);
}

addawardtoaarlist(ref) {
  if(!isDefined(self.aarawards)) {
    self.aarawards = [];
    self.aarawardcount = 0;

    for(_id_44D5A2614EED724E = 0; _id_44D5A2614EED724E < 10; _id_44D5A2614EED724E++) {
      struct = spawnStruct();
      self.aarawards[_id_44D5A2614EED724E] = struct;
      struct.ref = "none";
      struct.count = 0;
    }
  }

  foreach(_id_44D5A2614EED724E, _id_6DFAC1DD9D7FFAE2 in self.aarawards) {
    if(_id_6DFAC1DD9D7FFAE2.ref == ref) {
      _id_6DFAC1DD9D7FFAE2.count++;
      self setplayerdata("common", "round", "awards", _id_44D5A2614EED724E, "value", _id_6DFAC1DD9D7FFAE2.count);
      return;
    }
  }

  _id_0ECE43214E2FD6E1 = scripts\engine\utility::_id_53C4C53197386572(level._id_6D808D6C553C2D9A[ref], 0);

  for(_id_347E4138D03A99C8 = 0; _id_347E4138D03A99C8 < self.aarawards.size; _id_347E4138D03A99C8++) {
    _id_6DFAC1DD9D7FFAE2 = self.aarawards[_id_347E4138D03A99C8];

    if(_id_6DFAC1DD9D7FFAE2.ref == "none") {
      break;
    }

    _id_CCA79D36F592EF75 = scripts\engine\utility::_id_53C4C53197386572(level._id_6D808D6C553C2D9A[_id_6DFAC1DD9D7FFAE2.ref], 0);

    if(_id_0ECE43214E2FD6E1 > _id_CCA79D36F592EF75) {
      break;
    }
  }

  if(_id_347E4138D03A99C8 >= self.aarawards.size) {
    return;
  }
  for(_id_42D954E3D59B63A3 = self.aarawards.size - 2; _id_42D954E3D59B63A3 >= _id_347E4138D03A99C8; _id_42D954E3D59B63A3--) {
    _id_DC6CBFDA5CAFD043 = _id_42D954E3D59B63A3 + 1;
    self.aarawards[_id_DC6CBFDA5CAFD043] = self.aarawards[_id_42D954E3D59B63A3];
    _id_6DFAC1DD9D7FFAE2 = self.aarawards[_id_DC6CBFDA5CAFD043];

    if(_id_6DFAC1DD9D7FFAE2.ref != "none") {
      self setplayerdata("common", "round", "awards", _id_DC6CBFDA5CAFD043, "award", _id_6DFAC1DD9D7FFAE2.ref);
      self setplayerdata("common", "round", "awards", _id_DC6CBFDA5CAFD043, "value", _id_6DFAC1DD9D7FFAE2.count);
    }
  }

  _id_6DFAC1DD9D7FFAE2 = spawnStruct();
  self.aarawards[_id_347E4138D03A99C8] = _id_6DFAC1DD9D7FFAE2;
  _id_6DFAC1DD9D7FFAE2.ref = ref;
  _id_6DFAC1DD9D7FFAE2.count = 1;
  self setplayerdata("common", "round", "awards", _id_347E4138D03A99C8, "award", _id_6DFAC1DD9D7FFAE2.ref);
  self setplayerdata("common", "round", "awards", _id_347E4138D03A99C8, "value", _id_6DFAC1DD9D7FFAE2.count);

  if(self.aarawardcount < 10) {
    self.aarawardcount++;
    self setplayerdata("common", "round", "awardCount", self.aarawardcount);
  }

  if(istrue(self.savedaarawards))
    saveaarawards();
}

initaarawardlist() {
  self.aarawards = self.pers["aarAwards"];
  self.aarawardcount = self.pers["aarAwardCount"];

  if(isDefined(self.aarawards)) {
    return;
  }
  self setplayerdata("common", "round", "awardCount", 0);

  for(_id_44D5A2614EED724E = 0; _id_44D5A2614EED724E < 10; _id_44D5A2614EED724E++) {
    self setplayerdata("common", "round", "awards", _id_44D5A2614EED724E, "award", "none");
    self setplayerdata("common", "round", "awards", _id_44D5A2614EED724E, "value", 0);
  }
}

saveaarawardsonroundswitch() {
  level waittill("game_ended");

  foreach(player in level.players) {
    if(isDefined(player) && !isbot(player))
      player saveaarawards();
  }
}

saveaarawards() {
  self.pers["aarAwards"] = self.aarawards;
  self.pers["aarAwardCount"] = self.aarawardcount;
  self.savedaarawards = 1;
}

give_operator_based_on_task(_id_D81BCC09A687A6E2) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(_id_D81BCC09A687A6E2) || !isstring(_id_D81BCC09A687A6E2)) {
    return;
  }
  id = int(get_id_based_on_task(_id_D81BCC09A687A6E2));

  switch (_id_D81BCC09A687A6E2) {
    case "paladin":
    case "juggernauts":
    case "all_operations":
    case "crosswind":
    case "kuvalda":
    case "headhunter":
      self reportchallengeuserevent("cp_complete", id);
      break;
    default:
      break;
  }
}

give_reward_based_on_task(_id_D81BCC09A687A6E2) {
  scripts\engine\utility::flag_wait("cp_operator_unlock_ids_initted");

  if(!isDefined(_id_D81BCC09A687A6E2) || !isstring(_id_D81BCC09A687A6E2)) {
    return;
  }
  id = int(get_id_based_on_task(_id_D81BCC09A687A6E2));

  switch (_id_D81BCC09A687A6E2) {
    case "kuvalda_mod":
    case "brimstone_mod_vet":
    case "downtown_3":
    case "downtown_2":
    case "crosswind_mod":
    case "harbinger":
    case "brimstone_mod":
    case "crosswind_mod_vet":
    case "justreward_mod":
    case "kuvalda_mod_vet":
    case "smuggler":
    case "downtown_4":
    case "strongbox_mod":
    case "justreward_mod_vet":
    case "paladin_mod":
    case "strongbox_mod_vet":
    case "harbinger_mod":
    case "paladin_mod_vet":
    case "headhunter_mod":
    case "harbinger_mod_vet":
    case "headhunter_mod_vet":
    case "downtown_1":
      self reportchallengeuserevent("cp_complete", id);
      break;
    default:
      break;
  }
}

get_id_based_on_task(_id_D81BCC09A687A6E2) {
  id = level.operator_unlock_ids[_id_D81BCC09A687A6E2].id;
  return id;
}

challengetrackerforjuggkills() {
  if(istrue(level.juggernautchallengedone)) {
    return;
  }
  foreach(player in level.players)
  player thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_FD0C8FBAC1063EAA");

  level.juggernaut_kills_tracker++;

  if(level.juggernaut_kills_tracker >= 5) {
    foreach(player in level.players)
    player thread give_operator_based_on_task("juggernauts");

    level.juggernautchallengedone = 1;
  }
}