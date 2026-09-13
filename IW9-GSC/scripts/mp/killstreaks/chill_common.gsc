/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chill_common.gsc
***************************************************/

chill_init() {
  chill_data = spawnStruct();
  chill_data.blindparts = [];
  chill_data.blindstates = [];
  chill_data.blinddurations = [];
  chill_data.blindparts[0] = "chilledInit";
  chill_data.blindstates[0] = "activeWeak";
  chill_data.blinddurations[0] = 2;
  chill_data.blindparts[1] = "chilledInit";
  chill_data.blindstates[1] = "active";
  chill_data.blinddurations[1] = 2;
  level.chill_data = chill_data;
}

chill(id, duration) {
  if(!isDefined(self.chill_data))
    self.chill_data = spawnStruct();

  struct = self.chill_data;
  thread chill_blind();

  if(!isDefined(struct.active)) {
    self notify("chill");
    struct.active = 1;
    struct.speedmod = 0;
    struct.times = [];
    duration = duration * 1000;
    starttime = gettime();
    endtime = starttime + duration;
    struct.times[id] = (starttime, endtime, duration);
    chill_impair();
    self setscriptablepartstate("chilled", "active", 0);
    thread chill_update();
  } else {
    if(!isDefined(struct.times[id]))
      struct.active++;

    duration = duration * 1000;
    starttime = gettime();
    endtime = starttime + duration;
    struct.times[id] = (starttime, endtime, duration);
  }
}

chillend(id) {
  struct = self.chill_data;
  struct.active--;
  struct.times[id] = undefined;

  if(struct.active == 0) {
    self notify("chillEnd");
    chill_impairend();
    self setscriptablepartstate("chilled", "neutral", 0);
    self.chill_data = undefined;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

ischilled() {
  struct = self.chill_data;
  return isDefined(struct) && isDefined(struct.active);
}

chill_resetdata() {
  self notify("chillReset");
  self.chill_data = undefined;
}

chill_resetscriptable() {
  self setscriptablepartstate("chilled", "neutral", 0);

  foreach(_id_3FCA284E7EC14DB5 in level.chill_data.blindparts)
  self setscriptablepartstate(_id_3FCA284E7EC14DB5, "neutral", 0);
}

chill_impair() {
  _id_3B64EB40368C1450::set("chill_impair", "sprint", 0);
  _id_3B64EB40368C1450::set("chill_impair", "slide", 0);
  _id_3B64EB40368C1450::set("chill_impair", "wallrun", 0);
  _id_3B64EB40368C1450::set("chill_impair", "mantle", 0);
}

chill_impairend() {
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("chill_impair");
}

chill_blind() {
  self endon("death_or_disconnect");
  _id_6C4731C8A94C0275 = self.chill_data;
  _id_1BBC33C92A697155 = level.chill_data;
  _id_4CE5E36055681108 = _id_6C4731C8A94C0275.blindid;
  _id_CDAB1E4A45B9F461 = scripts\engine\utility::ter_op(scripts\mp\utility\perk::_hasperk("specialty_stun_resistance"), 0, 1);
  _id_1A7ECA38A3C7C389 = _id_1BBC33C92A697155.blindparts[_id_CDAB1E4A45B9F461];
  _id_7124641016831C71 = _id_1BBC33C92A697155.blindstates[_id_CDAB1E4A45B9F461];
  _id_BA73382ED630C0A4 = _id_1BBC33C92A697155.blinddurations[_id_CDAB1E4A45B9F461];

  if(!isDefined(_id_4CE5E36055681108)) {
    self setscriptablepartstate(_id_1A7ECA38A3C7C389, _id_7124641016831C71, 0);
    _id_6C4731C8A94C0275.blindid = _id_CDAB1E4A45B9F461;
  } else {
    if(_id_4CE5E36055681108 > _id_CDAB1E4A45B9F461) {
      return;
    }
    _id_7C539BCCA7C6FBEC = _id_1BBC33C92A697155.blindparts[_id_4CE5E36055681108];

    if(_id_7C539BCCA7C6FBEC != _id_1A7ECA38A3C7C389)
      self setscriptablepartstate(_id_7C539BCCA7C6FBEC, "neutral", 0);

    self setscriptablepartstate(_id_1A7ECA38A3C7C389, _id_7124641016831C71, 0);
    _id_6C4731C8A94C0275.blindid = _id_CDAB1E4A45B9F461;
  }

  self notify("chillBlind");
  self endon("chillBlind");
  scripts\engine\utility::waittill_any_timeout_1(_id_BA73382ED630C0A4, "chillEnd");
  self setscriptablepartstate(_id_1A7ECA38A3C7C389, "neutral", 0);
  _id_6C4731C8A94C0275.blindid = undefined;
}

chill_update() {
  self endon("disconnect");
  self endon("chillReset");
  self endon("chillEnd");
  struct = self.chill_data;

  for(;;) {
    time = gettime();
    _id_73B066DD05CF2496 = 0;

    foreach(id, _id_8B462903A1F84F9C in struct.times) {
      start = _id_8B462903A1F84F9C[0];
      end = _id_8B462903A1F84F9C[1];
      duration = _id_8B462903A1F84F9C[2];

      if(time < end) {
        _id_8266A3DC2B6CB1AF = time - start;
        _id_6C8D21B2E54B2478 = 1 - _id_8266A3DC2B6CB1AF / duration;

        if(_id_6C8D21B2E54B2478 > _id_73B066DD05CF2496)
          _id_73B066DD05CF2496 = _id_6C8D21B2E54B2478;

        continue;
      }

      thread chillend(id);
    }

    struct.speedmod = _id_73B066DD05CF2496 * -0.55;
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}