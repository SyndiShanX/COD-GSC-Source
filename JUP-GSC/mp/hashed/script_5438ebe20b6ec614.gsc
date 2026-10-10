/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5438ebe20b6ec614.gsc
*************************************************/

#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_ced1636a962433d2;

function init(moodlist) {
  if(!isDefined(moodlist) || moodlist == "") {
    return;
  }

  scriptbundle = getscriptbundle(hashcat(%"hash_2bbcecc836419d0b", moodlist));

  if(!isDefined(scriptbundle)) {
    return;
  }

  moodlist = scriptbundle.var_ef1866c5d314a352;

  if(!isDefined(moodlist) || moodlist.size == 0) {
    return;
  }

  totalweight = 0;
  weightoverrides = strtok(getDvar(@ "hash_8422039c51781bf1", ""), " ");

  for(k = 0; k < moodlist.size; k++) {
    if(weightoverrides.size > 0 && isDefined(weightoverrides[k])) {
      moodlist[k].weight = float(weightoverrides[k]);
    }

    if(!isDefined(moodlist[k].weight)) {
      moodlist[k].weight = 0;
    }

    totalweight += moodlist[k].weight;
  }

  randomnumber = randomfloat(totalweight);
  cumulativeweight = 0;

  for(i = 0; i < moodlist.size; i++) {
    nextweight = cumulativeweight + moodlist[i].weight;

    if(nextweight > randomnumber) {
      var_41368388d296a0d0 = moodlist[i];
      setup(var_41368388d296a0d0.moodset);
      return;
    }

    cumulativeweight = nextweight;
  }
}

function setup(moodset) {
  if(!isDefined(moodset) || moodset == "") {
    return;
  }

  scriptbundle = getscriptbundle(hashcat(%"hash_7d9482f6248686c3", moodset));

  if(!isDefined(scriptbundle)) {
    return;
  }

  if(!isDefined(scriptbundle.moods) || scriptbundle.moods.size == 0) {
    return;
  }

  level.var_e198c297ceb14c19 = getdvarint(@ "hash_37763c7311e5b8da", 256);
  level.var_fbca612d854a3975 = getdvarfloat(@ "hash_d1676be1e671f038", 0.306);
  level.var_ae361b9fc9ed6213 = getdvarfloat(@ "hash_8eebbbe30d21a94a", 1);
  level.var_8ee11212ceb130ef = getdvarfloat(@ "hash_64e3e719e88b3ffa", 0.922347);
  level.var_f8397ff86c4282e8 = getdvarfloat(@ "hash_2b9d51c935985eff", 0.870588);
  level.moods = scriptbundle.moods;

  for(i = 0; i < level.moods.size; i++) {
    level.moods[i].state = getscriptbundle(hashcat(%"hash_6b3d349b362ec62", level.moods[i].state));
  }

  pregamemood = function_8725cc1e47d95528(-1);

  if(isDefined(pregamemood) && isDefined(pregamemood.state)) {
    level thread function_5d6d8ec8b7599cfd(pregamemood);
  }

  level thread watchcircles();
  level thread watchtime();

  level thread debug_init();
}

function setmood(mood) {
  if(!isDefined(mood)) {
    return;
  }

  if(isDefined(level.currentmood)) {
    if(level.currentmood.transitiontype == "circles" && mood.transitiontype == "circles") {
      circleindexa = isDefined(mood.circleindex) ? mood.circleindex : 0;
      circleindexb = isDefined(level.currentmood.circleindex) ? level.currentmood.circleindex : 0;

      if(circleindexa == circleindexb) {
        return;
      }
    }
  }

  if(!isDefined(mood.state)) {
    return;
  }

  level.currentmood = mood;
  level thread switchvisionsets();
  level function_519c36cfe2838f8a();
  level function_24427ed3f5c1ccc3();
  level thread function_d579bab00a3ef871();
  level thread function_2ef05a1df426a720();
}

function function_37ff5d03f010f57e(mood) {
  if(!isDefined(mood)) {
    return;
  }

  if(!isDefined(self.currentmood)) {
    self.currentmood = level.currentmood;
  }

  if(isDefined(self.currentmood)) {
    if(self.currentmood.transitiontype == "circles" && mood.transitiontype == "circles") {
      circleindexa = isDefined(mood.circleindex) ? mood.circleindex : 0;
      circleindexb = isDefined(self.currentmood.circleindex) ? self.currentmood.circleindex : 0;

      if(circleindexa == circleindexb) {
        return;
      }
    }
  }

  self.currentmood = mood;
  thread switchvisionsets(self);
  function_519c36cfe2838f8a(self);
  function_24427ed3f5c1ccc3(self);
}

function switchvisionsets(player) {
  suffix = self.currentmood.state.visionsetsuffix;

  if(!isDefined(suffix)) {
    suffix = "";
  }

  duration = 0;

  if(isDefined(self.currentmood.transitiontime) && self.currentmood.transitiontime >= 0) {
    duration = self.currentmood.transitiontime;
  }

  if(istrue(level.var_5872a7af669d9983)) {
    duration = 0;
  }

  if(istrue(self.var_5872a7af669d9983)) {
    duration = 0;
  }

  if(isDefined(player) && isPlayer(player)) {
    self function_eb0326e0c8803f41(duration, suffix);
    return;
  }

  replacevisionset(duration, suffix);
}

function function_5d6d8ec8b7599cfd(mood) {
  level endon("prematch_fade_done");

  if(!isDefined(mood.state)) {
    return;
  }

  level.currentmood = mood;
  thread function_d579bab00a3ef871();

  while(true) {
    level waittill("connected", player);
    player thread function_a56c4e72231ce9a2();
    thread function_519c36cfe2838f8a(player);
    thread function_24427ed3f5c1ccc3(player);
  }
}

function function_a56c4e72231ce9a2() {
  self waittill("spawned_player");
  duration = 0;
  suffix = level.currentmood.state.visionsetsuffix;
  self function_eb0326e0c8803f41(duration, suffix);
}

function watchcircles() {
  level endon("game_ended");

  while(true) {
    level waittill("br_circle_set");
    newmood = function_8725cc1e47d95528(level.br_circle.circleindex);

    if(isDefined(newmood)) {
      setmood(newmood);
      continue;
    }

    continue;
  }
}

function watchtime() {
  level endon("game_ended");
  level waittill("prematch_fade_done");

  if(!isDefined(level.starttime)) {
    level.starttime = gettime();
  }

  waittime = 60;
  newmood = undefined;
  var_35963274858b5330 = 1;

  while(true) {
    if(isDefined(newmood)) {
      setmood(newmood);
      newmood = undefined;
      waittime = 60;
      continue;
    } else {
      newmood = function_12f05fef0df24cd7(waittime, var_35963274858b5330);
      var_35963274858b5330 = 0;
    }

    if(isDefined(newmood)) {
      waittime = newmood.starttime * 60 - (gettime() - level.starttime) / 1000;
      waittime = max(waittime, 0);
    }

    wait waittime;
  }
}

function function_8725cc1e47d95528(index) {
  foreach(mood in level.moods) {
    if(mood.transitiontype != "circles") {
      continue;
    }

    if(!isDefined(mood.circleindex)) {
      if(index == 0) {
        mood.circleindex = index;
        return mood;
      }

      continue;
    }

    if(mood.circleindex == index) {
      return mood;
    }
  }

  return undefined;
}

function function_12f05fef0df24cd7(timedelta, var_35963274858b5330) {
  currenttime = gettime() - level.starttime;
  currenttime /= 1000;

  foreach(mood in level.moods) {
    if(mood.transitiontype != "time") {
      continue;
    }

    if(!isDefined(mood.starttime)) {
      mood.starttime = 0;
    }

    if(istrue(var_35963274858b5330) && mood.starttime == 0) {
      return mood;
    }

    moodtime = mood.starttime * 60;

    if(moodtime > currenttime && moodtime - currenttime <= timedelta) {
      return mood;
    }
  }

  return undefined;
}

function function_519c36cfe2838f8a(player) {
  exploders = self.currentmood.state.exploders;

  if(!isDefined(exploders) || exploders.size == 0) {
    return;
  }

  foreach(exploder in exploders) {
    exploder thread handleexploder(player);
  }
}

function handleexploder(player) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.delay)) {
    delay = self.delay;

    if(istrue(level.var_5872a7af669d9983)) {
      delay = 0;
    }

    if(istrue(player.var_5872a7af669d9983)) {
      delay = 0;
    }

    wait delay;
  }

  if(istrue(self.active)) {
    if(isDefined(player) && isPlayer(player)) {
      player waittill("spawned_player");
      activateclientexploder(self.name, player, gettime(), level.var_e198c297ceb14c19);
    } else {
      activateclientexploder(self.name, level.players, gettime(), level.var_e198c297ceb14c19);
    }

    return;
  }

  stopclientexploder(self.name);
}

function function_24427ed3f5c1ccc3(player) {
  soundeffects = self.currentmood.state.soundeffects;

  if(!isDefined(soundeffects) || soundeffects.size == 0) {
    return;
  }

  foreach(soundeffect in soundeffects) {
    soundeffect thread function_6fad46877de34a3b(player);
  }
}

function function_6fad46877de34a3b(index, player) {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  id = isDefined(self.id) ? self.id : "";
  state = isDefined(self.state) ? self.state : "";
  fadetime = 10;
  fadetimes = level.currentmood.var_c55ce35ed96a2d2c;

  if(isDefined(fadetimes) && isDefined(fadetimes[index])) {
    fadetime = isDefined(fadetimes[index].fadetime) ? fadetimes[index].fadetime : fadetime;
  }

  if(istrue(level.var_5872a7af669d9983)) {
    fadetime = 0;
  }

  if(istrue(player.var_5872a7af669d9983)) {
    fadetime = 0;
  }

  if(isDefined(player) && isPlayer(player)) {
    player waittill("spawned_player");
    setaudiotriggerstate(id, state, fadetime, player);
    return;
  }

  setaudiotriggerstate(id, state, fadetime);
}

function function_d579bab00a3ef871() {
  level endon("game_ended");

  if(level.currentmood.transitiontype == "circles" && isDefined(level.currentmood.circleindex) && level.currentmood.circleindex == -1 && !istrue(level.debugtransition)) {
    level waittill("prematch_fade_done");
  }

  if(!isDefined(level.currentmood.state.sunlight)) {
    return;
  }

  sunlight = [];

  if(isDefined(level.currentmood.state.sunlight.color) && level.currentmood.state.sunlight.color != "") {
    tokens = strtok(level.currentmood.state.sunlight.color, " ");
    red = float(tokens[0]);
    green = float(tokens[1]);
    blue = float(tokens[2]);
    sunlight[sunlight.size] = red != 0 ? red : undefined;
    sunlight[sunlight.size] = green != 0 ? green : undefined;
    sunlight[sunlight.size] = blue != 0 ? blue : undefined;
  }

  sunlight[sunlight.size] = level.currentmood.state.sunlight.intensity;
  thread function_e926344af0b8a54e(sunlight, level.currentmood.transitiontime);
}

function function_e926344af0b8a54e(final, time) {
  level endon("game_ended");

  if(!isDefined(final)) {
    return;
  }

  if(istrue(level.var_5872a7af669d9983)) {
    time = 0;
  }

  changecolor = isDefined(final[0]) && isDefined(final[1]) && isDefined(final[2]);
  changeintensity = isDefined(final[3]) || isDefined(final[0]) && !changecolor;

  if(!istrue(changecolor) && !istrue(changeintensity)) {
    return;
  }

  if(!isDefined(level.var_8c4540ab5278f235)) {
    level.var_8c4540ab5278f235 = [];
  }

  initial = [];

  if(changecolor) {
    initial[0] = isDefined(level.var_8c4540ab5278f235[0]) ? level.var_8c4540ab5278f235[0] : level.var_ae361b9fc9ed6213;
    initial[1] = isDefined(level.var_8c4540ab5278f235[1]) ? level.var_8c4540ab5278f235[1] : level.var_8ee11212ceb130ef;
    initial[2] = isDefined(level.var_8c4540ab5278f235[2]) ? level.var_8c4540ab5278f235[2] : level.var_f8397ff86c4282e8;
  }

  if(changeintensity) {
    if(changecolor) {
      index = 3;
    } else {
      index = 0;
    }

    initial[index] = isDefined(level.var_8c4540ab5278f235[3]) ? level.var_8c4540ab5278f235[3] : level.var_fbca612d854a3975;
  }

  if(isDefined(time) && time > 0) {
    range = [];

    for(i = 0; i < final.size; i++) {
      if(isDefined(final[i])) {
        range[i] = final[i] - initial[i];
      }
    }

    next = initial;
    interval = 0.25;
    count = int(time / interval);

    if(count > 0) {
      delta = [];

      for(i = 0; i < range.size; i++) {
        if(isDefined(range[i])) {
          delta[i] = range[i] / count;
        }
      }

      while(count) {
        for(i = 0; i < delta.size; i++) {
          if(isDefined(delta[i])) {
            next[i] += delta[i];
          }
        }

        if(changecolor && changeintensity) {
          setsuncolorandintensity(next[0], next[1], next[2], next[3]);
        } else if(changecolor) {
          setsuncolorandintensity(next[0], next[1], next[2]);
        } else {
          setsuncolorandintensity(next[0]);
        }

        wait interval;
        count--;
      }
    }
  }

  if(changecolor && changeintensity) {
    setsuncolorandintensity(final[0], final[1], final[2], final[3]);
    level.var_8c4540ab5278f235[0] = final[0];
    level.var_8c4540ab5278f235[1] = final[1];
    level.var_8c4540ab5278f235[2] = final[2];
    level.var_8c4540ab5278f235[3] = final[3];
    return;
  }

  if(changecolor) {
    setsuncolorandintensity(final[0], final[1], final[2]);
    level.var_8c4540ab5278f235[0] = final[0];
    level.var_8c4540ab5278f235[1] = final[1];
    level.var_8c4540ab5278f235[2] = final[2];
    return;
  }

  setsuncolorandintensity(final[0]);
  level.var_8c4540ab5278f235[3] = final[0];
}

function function_2ef05a1df426a720(player, var_44c0bd46a9c3517e) {
  level endon("game_ended");

  if(!isDefined(self.currentmood.state.configuration)) {
    return;
  }

  if(isDefined(self.var_b50a28b117aa65cd)) {
    function_90fb4916aa7fd9f3(self.var_b50a28b117aa65cd);
  }

  if(isDefined(self.currentmood.var_e3cf72e793015995)) {
    delay = self.currentmood.var_e3cf72e793015995;

    if(istrue(level.var_5872a7af669d9983)) {
      delay = 0;
    }

    if(istrue(self.var_5872a7af669d9983)) {
      delay = 0;
    }

    wait delay;
  }

  if(isDefined(player) && isPlayer(player)) {
    if(istrue(var_44c0bd46a9c3517e)) {
      player waittill("spawned_player");
    }

    player function_451319f93d30ebe5(self.currentmood.state.configuration);
  } else {
    if(istrue(level.var_5872a7af669d9983)) {
      function_ee7c0ccde65de2ec(self.currentmood.state.configuration);
      self.var_b50a28b117aa65cd = self.currentmood.state.configuration;
      return;
    }

    if(istrue(self.var_5872a7af669d9983)) {
      function_ee7c0ccde65de2ec(self.currentmood.state.configuration);
      self.var_b50a28b117aa65cd = self.currentmood.state.configuration;
      return;
    }

    function_7c2e0421aa80f818(self.currentmood.state.configuration, 15000, "MIDDLE");
  }

  self.var_b50a28b117aa65cd = self.currentmood.state.configuration;
}

function get_mood(var_4fba68bebfee306e) {
  return level.moods[var_4fba68bebfee306e];
}

function debug_init() {
  devgui_init();
}

function devgui_init() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x30>", "<dev string:x3d>", &function_40c5de300f64bca5);
  scripts\common\devgui::function_fe953f000498048f();

  for(i = 0; i < level.moods.size; i++) {
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x4a>" + i);
    scripts\common\devgui::function_fe953f000498048f();
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x4a>" + i + "<dev string:x63>");
    scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x79>", "<dev string:x7d>" + i, &function_9fb263cc4b9c7d63);
    scripts\common\devgui::function_fe953f000498048f();
    scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x4a>" + i + "<dev string:x98>");
    scripts\common\devgui::function_b23a59dfb4ca49a1("<dev string:x79>", "<dev string:xaf>" + i, &function_557893706e808ca5);
    scripts\common\devgui::function_fe953f000498048f();
  }
}

function function_9fb263cc4b9c7d63(params) {
  index = int(params[0]);
  level.debugtransition = 1;
  level.player function_37ff5d03f010f57e(level.moods[index]);
  level.debugtransition = 0;
}

function function_557893706e808ca5(params) {
  level.var_5872a7af669d9983 = 1;
  level.debugtransition = 1;
  index = int(params[0]);
  level.player function_37ff5d03f010f57e(level.moods[index]);
  level.var_5872a7af669d9983 = 0;
  level.debugtransition = 0;
}

function function_40c5de300f64bca5() {
  if(!isDefined(level.var_8c4540ab5278f235)) {
    return;
  }

  final = level.var_8c4540ab5278f235;
  resetcolor = isDefined(final[0]) && isDefined(final[1]) && isDefined(final[2]);
  resetintensity = isDefined(final[3]);

  if(resetcolor && resetintensity) {
    setsuncolorandintensity(level.var_ae361b9fc9ed6213, level.var_8ee11212ceb130ef, level.var_f8397ff86c4282e8, level.var_fbca612d854a3975);
    return;
  }

  if(resetcolor) {
    setsuncolorandintensity(level.var_ae361b9fc9ed6213, level.var_8ee11212ceb130ef, level.var_f8397ff86c4282e8);
    return;
  }

  if(resetintensity) {
    setsuncolorandintensity(level.var_fbca612d854a3975);
  }
}

function function_aaadc13812c2ef4b() {
  replacevisionset(0, "<dev string:x79>");

  if(isDefined(level.currentmood)) {
    level.currentmood = undefined;
  }
}

function function_abcd11e9abe86202() {
  function_40c5de300f64bca5();
  function_aaadc13812c2ef4b();
  function_cac2f4c1694c723f();

  if(isDefined(level.activeexploders)) {
    foreach(explodername, active in level.activeexploders) {
      if(istrue(level.activeexploders[explodername])) {
        stopclientexploder(explodername);
        level.activeexploders[explodername] = undefined;
      }
    }

    level.activeexploders = undefined;
  }
}

# /