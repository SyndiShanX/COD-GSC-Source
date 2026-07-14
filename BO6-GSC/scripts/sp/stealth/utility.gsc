/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\stealth\utility.gsc
******************************************/

#using scripts\anim\battlechatter;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\stealth\debug;
#using scripts\stealth\player;
#namespace utility;

function try_announce_sound(snd, delaytime, eventstruct) {
  if(isalive(self) && !should_sound_take_priority(snd)) {
    return 0;
  }

  self notify("\x96i\xa3\x9c\xad\xd4)\x03\xa1\xa8\x1c\x95\xc0\xe6v\xda\b\x17\xb9" + snd);
  self endon("\x96i\xa3\x9c\xad\xd4)\x03\xa1\xa8\x1c\x95\xc0\xe6v\xda\b\x17\xb9" + snd);
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("*\xeb\x7f!\xa4\xb9\xe6/\xcf\a");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  if(!can_announce_sound(snd)) {
    self.stealth.current_requested_snd = undefined;
    return 0;
  }

  return play_stealth_vo(snd, undefined, eventstruct);
}

function should_sound_take_priority(snd) {
  if(!isDefined(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = snd;
    return true;
  }

  if(get_snd_priority(snd) < get_snd_priority(self.stealth.current_requested_snd)) {
    self.stealth.current_requested_snd = snd;
    return true;
  }

  return false;
}

function get_snd_priority(snd) {
  switch (snd) {
    case #"hash_1d0022d9b49074c0":
    case #"hash_412938e72fd9ab35":
    case #"hash_4b0ca4ada825424a":
    case #"hash_9567f12963cd5717":
    case #"hash_f4eac828cdfe2da9":
      return 1;
    case #"hash_184bba7053cc1c15":
    case #"hash_5ee535013b151894":
    case #"hash_7ba904b9ea76ffca":
    case #"hash_a10f8380ee2f93c0":
    case #"hash_ea5a333788b85a6b":
      return 2;
    case #"hash_42197ed1ee6aca75":
    case #"hash_4bfca0c6798b2ca8":
    case #"hash_acae7c77d0d3323d":
    case #"hash_c9585df770639ae7":
    case #"hash_e229e5eb3ca60422":
      return 3;
    case #"hash_5567fda2832cbf6e":
    case #"hash_9ef2596c4c4ce657":
    case #"hash_c5c143ba1ce58744":
      return 4;
    case #"hash_54ef1367f3b7f44c":
    case #"hash_be58fabf4815ede6":
    case #"hash_d90155acf1b84c47":
    case #"hash_d90156acf1b84dda":
    case #"hash_ebe703549b311e56":
    case #"hash_f3cf146b324c8eb7":
      return 5;
    default:

      iprintln("<dev string:x24>" + snd);

      return undefined;
  }
}

function can_announce_sound(snd) {
  if(!isalive(self)) {
    return false;
  }

  if(istrue(self.in_melee_death)) {
    return false;
  }

  if(!(isDefined(level.stealth.next_sound_time) && isDefined(level.stealth.next_sound_time[snd]))) {
    level.stealth.next_sound_time[snd] = -10;
  }

  time = gettime();

  if(time < level.stealth.next_sound_time[snd]) {
    return false;
  }

  add_announce_debounce(snd);
  return true;
}

function add_announce_debounce(snd, delaytime) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  if(isarray(snd)) {
    foreach(snditem in snd) {
      level.stealth.next_sound_time[snditem] = gettime() + level.stealth.next_sound_wait;
    }

    return;
  }

  level.stealth.next_sound_time[snd] = gettime() + level.stealth.next_sound_wait;
}

function play_stealth_vo(snd, var_4d7e472415a973f3, eventstruct) {
  result = 0;
  radiotransmitto = undefined;

  if(!isDefined(self.stealth.voiceid)) {
    return 0;
  }

  prefix = "\"Y^\xd5\xce\xbb\xe7";

  if(istrue(var_4d7e472415a973f3)) {
    prefix = get_country_prefix();
  }

  switch (snd) {
    case #"hash_184bba7053cc1c15":
      snd = "\x11\x06l\x86hQ\xeb\xa5" + randomintrange(1, 4);
      break;
    case #"hash_c9585df770639ae7":
      snd = "\xfa<\x8a4\x822\x11v\xa5\xac\xf6\xbc" + randomintrange(1, 5);
      break;
    case #"hash_acae7c77d0d3323d":
      if(distance(self.origin, level.player.origin) < 450) {
        vol = "4\xa9\xc7";
      } else {
        vol = ":\xbfa^";
      }

      if(cointoss()) {
        snd = "\xbe\x1b\xf67\xb1\xb77\xe6\xf5" + vol + "w" + randomintrange(1, 4);
      } else {
        snd = "#\a\xbb\xe7\xea\xd1\xc6<\x8c\b:" + randomintrange(1, 7) + "w" + vol;
      }

      break;
    case #"hash_ea5a333788b85a6b":
      snd = "kz\xe7 \x02\xeeN\xff\xfc\xf9\xf8\x10" + randomintrange(1, 4);
      break;
    case #"hash_d90156acf1b84dda":
      snd = "\xa7\xcd\x90f\xdc@\xaf\x1c\xe1Z\xc2\xde\xa3";
      break;
    case #"hash_ebe703549b311e56":
      snd = "\xa0\x91\xafM\x94\xf6\xeaxn\x11\xeag\x19";
      break;
    case #"hash_d90155acf1b84c47":
      snd = "2\xa1z\x0e\xae\x14-\x15\x02\xec\x8c\xcb";
      break;
    case #"hash_a10f8380ee2f93c0":
      snd = "\xe1\xd9\xcd\x90\x12\x8aU]L\x90\xf94";
      break;
    case #"hash_5ee535013b151894":
      snd = "_\x1aW\xe6\x8e\xa5s;_" + randomintrange(1, 5);
      break;
    case #"hash_f3cf146b324c8eb7":
      if(self.stealth.voiceid == "\x17\xe2\xc9") {
        snd = "F<\xdf\xce@\xad\xe5\xc6\xb6u\xfa\xc4\xbd\x8c\xf6\x1a" + randomintrange(1, 7);

        if(isDefined(eventstruct) && isDefined(eventstruct.entity) && isai(eventstruct.entity) && isalive(eventstruct.entity) && distance2d(self.origin, eventstruct.entity.origin) >= 350) {
          radiotransmitto = eventstruct.entity;
        }
      } else {
        snd = "v\xd5\x9a\f0\xa4<\xb4\xe3|\x8a\xab\xb9\x9e)";
      }

      break;
    case #"hash_7ba904b9ea76ffca":
      if(cointoss()) {
        snd = "Ev\xc2\x0f\xeaN\x1eh\x98\x1eb\xcb";
      } else {
        snd = "C\xa9\xa6\x10\xd4\xa3\xf71";
      }

      break;
    case #"hash_4bfca0c6798b2ca8":
    case #"hash_e229e5eb3ca60422":
      if(self.alertlevelint > 2) {
        self.stealth.current_requested_snd = undefined;
        return 0;
      }

      snd = "}\x95\x9be\xday3\xb4\xcd\xc8\xe0c\v/e\x9c";

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(guy in level.stealth.candidatesvoice) {
          if(isalive(guy) && distance(self.origin, guy.origin) > 550) {
            radiotransmitto = guy;
            break;
          }
        }
      }

      break;
    case #"hash_9ef2596c4c4ce657":
      snd = "\xa7\xcd\x90f\xdc@\xaf\x1c\xe1Z\xc2\xde\xa3";
      break;
    case #"hash_c5c143ba1ce58744":
      snd = "\xbf\x04J[QT*\x91\xa0)\xf3\xff";
      break;
    case #"hash_1d0022d9b49074c0":
      if(cointoss()) {
        snd = "n\x14\xb0\t\xb5\xed\xa7\xfen\xdb\x95";
      } else {
        snd = "\xeb\vG\x86/\x91wvf";
      }

      break;
    case #"hash_42197ed1ee6aca75":
      snd = "G\xdd\xb4\x11\x1a\xda5_\xdb\x1d\xa8";
      break;
    case #"hash_412938e72fd9ab35":
    case #"hash_9567f12963cd5717":
      if(cointoss() && isDefined(eventstruct.origin)) {
        snd = try_cardinal_gunshot(eventstruct);
      } else {
        snd = random(["y\xbd\xdb\x03\x8a\ny\xbc\xd4m", "`_\xe7\xaf[\xba\xc1\x06\xb2\xb5", "`_\xe7\xaf[\xba\xc1\x06\xb2U", "5+\xc1\xba\xb9\x8e<\xc7~\xa4\x81"]);
      }

      break;
    case #"hash_4b0ca4ada825424a":
      if(cointoss() && isDefined(eventstruct.origin)) {
        snd = try_cardinal_gunshot(eventstruct);
      } else {
        snd = random(["\xfa{\xe9\xc0Vz\x975<\xa3", "T\xd6\xfc\xb5\xde\x8d\xeb\xfe\x18W", "rQ\xf7\xafk\x021>\x8c&", "\x8d\xd2\xff\x01\xe2\x01\xbb\xe7\xde\xd4", "]\x8b;'\xfe\xac\xa82}I", "]\x8b;'\xfe\xac\xa82}G"]);
      }

      break;
    case #"hash_54ef1367f3b7f44c":
      snd = try_cardinal_patrol_update("4\xa9\xc7");

      if(!isDefined(snd)) {
        snd = random(["Q\xa3N\xd2\xbe[\xaf\x01zC\x89\xd1\xb5\xa2\xd5\xd6\x9d\x84\x13", "6\x91\xd9t\x86i\xb6\x880\x83\x7f\x83u\xbe\xa3\x04N\xfd\xff", "\xfa\xb0\xc9+X\xe6\xb2\xd8W'\x95\xfae\xfa&\xeb\x8d\xde\xee", "<\x03\xeb]\x8fm5\xb9\x16\xdb.\xaf\xb1\x83D\xa5%\xdb\x0f"]);
      }

      if(isDefined(level.stealth.candidatesvoice) && level.stealth.candidatesvoice.size > 1) {
        foreach(guy in level.stealth.candidatesvoice) {
          if(isalive(guy) && distance(self.origin, guy.origin) > 550) {
            radiotransmitto = guy;
            break;
          }
        }
      }

      break;
    case #"hash_be58fabf4815ede6":
      snd = try_cardinal_patrol_update(":\xbfa^");

      if(!isDefined(snd)) {
        snd = random(["\xb8\xbd%\xd2C\xfa:\xa6\x8a\x14\xd6?\xc4\x7f}\xb8\xd6\xcd\x0f\xc8", "TU(>\x97gJ0)+\x06r\x1f\xf6TU'\xd7u\xee", "\xc1\xb9d\xc1\xcf{pB+\xcb\xd3\xf3\xff%G\xf8D\x8c\xe0\x06", "\x9f\xc7\f\x9a\f\xd7\x13C}\xef}\x9f\xa3\x86\xec\xa8\xe2\x93K\xc9"]);
      }

      break;
    case #"hash_5567fda2832cbf6e":
      if(isDefined(eventstruct) && isDefined(eventstruct.typeorig) && eventstruct.typeorig == "\xeb\x80\x99yg\xa5\x0e\rB\x13\xd5u\xf2m\x91w\xbd\xe1$&\r" && isDefined(eventstruct.origin)) {
        snd = "\x19\xf7p\xa5\"N`u\xff\xc3B\xf5\x9e\x8f" + randomintrange(1, 7);
        radiotransmitto = eventstruct.origin;
      } else {
        snd = "\x9b#\x9c\x1b\xb9Y\xf0\xd8:\xa0{\xbcy";
      }

      break;
    case #"hash_f4eac828cdfe2da9":
      snd = "\xf5\xadX7\x91\xbd\xbb7";
      break;
  }

  alias = prefix + self.stealth.voiceid + snd;
  result = play_stealth_vo_alias(alias, radiotransmitto);
  return result;
}

function get_country_prefix() {
  if(!isDefined(anim.countryids)) {
    return "";
  }

  if(!(isDefined(self.voice) && isDefined(anim.countryids[self.voice]))) {
    return "";
  }

  return anim.countryids[self.voice] + "w";
}

function try_cardinal_patrol_update(volume) {
  cardinaldirection = battlechatter::getdirectioncompass(self.origin, (0, 0, 0));

  if(isDefined(cardinaldirection) && cardinaldirection == ";\xeblCx0\xc2b \xeb") {
    return undefined;
  }

  volume = isDefined(volume) ? "w" + volume : "\xa3NW\xb8";
  num = randomintrange(1, 5);

  switch (cardinaldirection) {
    case #"hash_b9ff0a9f617355e4":
      alias = "4\x10\x94a\xbck\x9f\xfdJ\xc3# vc" + num + volume;
      break;
    case #"hash_b66b59dcd06dfad3":
      if(cointoss()) {
        alias = "4\x10\x94a\xbck\x9f\xfdJ\xc3# vc" + num + volume;
      } else {
        alias = "gK\r\xc6\x1b\xa1i`w-\x19\xdc\xa5\xab" + num + volume;
      }

      break;
    case #"hash_493bfd7122639b31":
      if(cointoss()) {
        alias = "4\x10\x94a\xbck\x9f\xfdJ\xc3# vc" + num + volume;
      } else {
        alias = "\x16\xc8vO9l~\x81Ag\xb16\xb1\x98" + num + volume;
      }

      break;
    case #"hash_fbd39e4f5634905a":
      alias = "s\xa4\xb6\xe0\x16~\xd3w\xbb\b\x7f\xdc\xbbI" + num + volume;
      break;
    case #"hash_abed5ad834825ff1":
      if(cointoss()) {
        alias = "s\xa4\xb6\xe0\x16~\xd3w\xbb\b\x7f\xdc\xbbI" + num + volume;
      } else {
        alias = "gK\r\xc6\x1b\xa1i`w-\x19\xdc\xa5\xab" + num + volume;
      }

      break;
    case #"hash_8856b747c93e7793":
      if(cointoss()) {
        alias = "s\xa4\xb6\xe0\x16~\xd3w\xbb\b\x7f\xdc\xbbI" + num + volume;
      } else {
        alias = "\x16\xc8vO9l~\x81Ag\xb16\xb1\x98" + num + volume;
      }

      break;
    case #"hash_22ce3b03c1e51a9c":
      alias = "\x16\xc8vO9l~\x81Ag\xb16\xb1\x98" + num + volume;
      break;
    case #"hash_a1e9b77432f55b0e":
      alias = "gK\r\xc6\x1b\xa1i`w-\x19\xdc\xa5\xab" + num + volume;
      break;
    default:

      iprintln("<dev string:x43>");

      alias = undefined;
      break;
  }

  assert(isDefined(alias));
  return alias;
}

function play_stealth_vo_alias(alias, radiotransmitto) {
  result = 0;
  self.stealth.current_requested_snd = undefined;

  if(soundexists(alias)) {
    if(!isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    }

    if(isDefined(self.stealth_vo_ent)) {
      if(isDefined(self.model) && hastag(self.model, "\xa6\xeb\x1ae\x85#")) {
        self.stealth_vo_ent linkTo(self, "\xa6\xeb\x1ae\x85#", (0, 0, 0), (0, 0, 0));
      }

      self.stealth_vo_ent playSound(alias, "\xd7\x9f\xf8\xcfc5Cv\f\xba", 1);

      if(isDefined(radiotransmitto)) {
        delaythread(0.3, &playradiotransmission, alias, radiotransmitto);
      }

      if(should_try_generic_radio_confirmation(alias) && !isDefined(radiotransmitto)) {
        thread generic_radio_confrimation();
      }
    }

    if(isDefined(self.stealth)) {
      self.stealth.last_sound_time = gettime();
    }

    result = 1;

    thread debug::function_20171bc84e77dfa0("<dev string:x65>" + alias);
  } else {
    thread debug::function_20171bc84e77dfa0("<dev string:x65>" + alias, undefined, undefined, (1, 0, 0));
  }

  return result;
}

function should_try_generic_radio_confirmation(alias) {
  if(randomint(100) > 60) {
    return 0;
  }

  aliasarray = strtok(alias, "w");

  switch (aliasarray[2]) {
    case #"hash_184bba7053cc1c15":
    case #"hash_4b0ca4ada825424a":
    case #"hash_4bfca0c6798b2ca8":
    case #"hash_74df1ed0d203fcdd":
    case #"hash_886e06f1c2006f3c":
      return 1;
    default:
      return 0;
  }
}

function generic_radio_confrimation() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("(\xe6\xe9\xe9\x0efc\xc8\x83Q\xb4r\xc0\xda\xe8*j\xe5(\xd8b\xe4DE\xc4\xce");
  self endon("(\xe6\xe9\xe9\x0efc\xc8\x83Q\xb4r\xc0\xda\xe8*j\xe5(\xd8b\xe4DE\xc4\xce");
  self.stealth_vo_ent waittill("\xd7\x9f\xf8\xcfc5Cv\f\xba");
  wait randomfloatrange(0.2, 0.4);
  alias = "\xc7\xb7\x93p\xc2g\xcc\xb3\x8cE\xcb\xd1\xdci\x83\xb7\x83{\x04\x13";
  utility_sp::play_sound_on_entity(alias);
}

function announce_spotted_acknowledge(guy) {
  origin = guy.origin;
  prefix = guy get_country_prefix();
  wait 1.5;

  if(isDefined(guy) && isDefined(guy.stealth.voiceid)) {
    num = guy.stealth.voiceid;
    origin = guy.origin + (0, 0, 45);
  } else {
    num = randomint(3);
  }

  alias = prefix + num + "\xd8H\xa07a\xed\xf6\xb1\xd0(\xcdq*=0\x01";

  guy thread debug::function_20171bc84e77dfa0("<dev string:x6e>");
}

function try_cardinal_gunshot(eventstruct) {
  cardinaldirection = battlechatter::getdirectioncompass(self.origin, eventstruct.origin);

  if(isDefined(cardinaldirection) && cardinaldirection == ";\xeblCx0\xc2b \xeb") {
    return;
  }

  num = randomintrange(1, 4);

  switch (cardinaldirection) {
    case #"hash_b9ff0a9f617355e4":
      alias = "B\xc2]s\x85H$'\x91m\xd6" + num;
      break;
    case #"hash_b66b59dcd06dfad3":
      if(cointoss()) {
        alias = "B\xc2]s\x85H$'\x91m\xd6" + num;
      } else {
        alias = "\x8e\x9c\x97\x17T\f\x0f\x81\xfe28" + num;
      }

      break;
    case #"hash_493bfd7122639b31":
      if(cointoss()) {
        alias = "B\xc2]s\x85H$'\x91m\xd6" + num;
      } else {
        alias = "aZ;\x8f\xc6 EL\xf3\xb6\xa9" + num;
      }

      break;
    case #"hash_fbd39e4f5634905a":
      alias = "\x9d\xe2\xe4ref\x12/0\xe1\x16" + num;
      break;
    case #"hash_abed5ad834825ff1":
      if(cointoss()) {
        alias = "\x9d\xe2\xe4ref\x12/0\xe1\x16" + num;
      } else {
        alias = "\x8e\x9c\x97\x17T\f\x0f\x81\xfe28" + num;
      }

      break;
    case #"hash_8856b747c93e7793":
      if(cointoss()) {
        alias = "\x9d\xe2\xe4ref\x12/0\xe1\x16" + num;
      } else {
        alias = "aZ;\x8f\xc6 EL\xf3\xb6\xa9" + num;
      }

      break;
    case #"hash_22ce3b03c1e51a9c":
      alias = "aZ;\x8f\xc6 EL\xf3\xb6\xa9" + num;
      break;
    case #"hash_a1e9b77432f55b0e":
      alias = "\x8e\x9c\x97\x17T\f\x0f\x81\xfe28" + num;
      break;
    default:

      iprintln("<dev string:x43>");

      alias = undefined;
      break;
  }

  assert(isDefined(alias));
  return alias;
}

function play_commander_response() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.stealth_vo_ent waittill("\xd7\x9f\xf8\xcfc5Cv\f\xba");
  response = random(array_randomize(["\xd7L\x8d%\x98\xf0:\vX\x18sk\xb5A?\xf9\xe5\xca\xafw\xbf\x1a", "F\xf0}1\xb17\xf5N]\x8d\xfal\xbd\xe6\xe8\xdc\xee\xac\xac\xe0_\x19", "H\xcc\xad\"\"\x81\x11\x1d\xf1\xf9\x1e\x0e\xc1\v\xa0\xb7\xd2\"\xbd\xb4>\xa8", "\xe7dI\xe0G\xaf'#V@\xd9\xf7\x94\xbc\xe9%;\xd8\xde\xffa\xbc\xb1/", "\xbc\x14OF'Gd\x06AX;\xdf\x8c\xc5h\xdbr\xa8.s\xc5\xfc\tL", "G\xf8\xe0j \xdec\xd8s\x1eo2{\xe0\xd8Qh\x8d\xb3.\xee3\xa4\x82", "G\xf8\xe0j \xdec\xd8s\x1eo2{\xe0\xd8Qh\x8d\xb3.\xee7\xa4\x82"]));
  wait randomfloatrange(0.15, 0.25);
  thread utility_sp::play_sound_on_entity(response);
}

function playradiotransmission(alias, transmitto) {
  if(isai(transmitto)) {
    if(!isalive(transmitto)) {
      return;
    }

    temp = transmitto spawn_script_origin();
    transmitto thread delete_on_death(temp);
    transmitto endon("\x1e\xfd\xd1\xa2\a");
    temp linkTo(transmitto, "\xc7\xae?f\x10\xbcr", (0, 0, 0), (0, 0, 0));
    temp setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "\xebe\xe3\x82S\x14");
    temp playSound(alias, "\x8d\xd0\x0e5K\x80\x13w-\xbf");
    temp waittill("\x8d\xd0\x0e5K\x80\x13w-\xbf");
    temp delete();
    return;
  }

  if(isvector(transmitto)) {
    temp = spawn_script_origin(transmitto, (0, 0, 0));
    temp setentitysoundcontext("0P\xd4\xe0\x06\x16\x82\xe3c\x92", "\xebe\xe3\x82S\x14");
    temp playSound(alias, "\x8d\xd0\x0e5K\x80\x13w-\xbf");
    temp waittill("\x8d\xd0\x0e5K\x80\x13w-\xbf");
    temp delete();
  }
}

function function_9c92c048b7db7987(aliasto) {
  assert(isPlayer(self));

  if(!isDefined(self.stealth)) {
    thread player::main();
  }

  if(!isDefined(self.currentalias)) {
    self.currentalias = "-7\xa5\xa3";
  }

  if(!isDefined(aliasto)) {
    setmusicstate("");
    self.currentalias = "";
    return;
  }

  if(aliasto != self.currentalias) {
    self.currentalias = aliasto;
    setmusicstate(aliasto);
  }
}

function function_5a96ca3e80dc3dc() {
  if(!isDefined(level.player.currentalias)) {
    return false;
  }

  if(level.player.currentalias == "-7\xa5\xa3") {
    return false;
  }

  return true;
}

function stealth_music_transition_sp(aliasto) {
  self notify("\xc4\xfd\xda\x88Nr\xeadU\xbau\xce=\xd8\xdc\xa1\xa1\x83\xa3[\xae^h\x80");
  self endon("\xc4\xfd\xda\x88Nr\xeadU\xbau\xce=\xd8\xdc\xa1\xa1\x83\xa3[\xae^h\x80");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  assert(isPlayer(self));

  if(!isDefined(self.stealth)) {
    thread player::main();
  }

  transitiontime = 1;
  frametime = 0.05;

  if(!isDefined(self.stealth.music_ent)) {
    self.stealth.music_ent = [];
  }

  alias = aliasto;

  if(isDefined(alias) && !isDefined(self.stealth.music_ent[alias])) {
    self.stealth.music_ent[alias] = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin);
    self.stealth.music_ent[alias] linkTo(self);
    self.stealth.music_ent[alias].cur_vol = 0;
    self.stealth.music_ent[alias] scalevolume(0);
    self.stealth.music_ent[alias] playLoopSound(alias);
  }

  while(true) {
    wait frametime;
    goaltargets = 0;

    foreach(alias, ent in self.stealth.music_ent) {
      target = undefined;

      if(isDefined(aliasto) && alias == aliasto) {
        ent.cur_vol = min(1, ent.cur_vol + frametime / transitiontime);
        target = 1;
      } else {
        ent.cur_vol = max(0, ent.cur_vol - frametime / transitiontime);
        target = 0;
      }

      ent scalevolume(ent.cur_vol);

      if(ent.cur_vol == target) {
        goaltargets++;
      }
    }

    if(goaltargets == self.stealth.music_ent.size) {
      foreach(alias, ent in self.stealth.music_ent) {
        if(!isDefined(aliasto) || alias != aliasto) {
          self.stealth.music_ent[alias] delete();
          self.stealth.music_ent[alias] = undefined;
        }
      }

      return;
    }
  }
}

function sixthsense_enable(bool) {
  if(!isDefined(bool)) {
    bool = 1;
  }

  assert(isDefined(level.player.sixthsense), "<dev string:x86>");
  level.player.sixthsense.active = bool;
}