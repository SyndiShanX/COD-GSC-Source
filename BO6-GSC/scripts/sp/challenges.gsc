/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\challenges.gsc
**************************************/

#using script_782c244f72aad82a;
#using scripts\common\system;
#namespace challenges_sp;

function private autoexec __init__system__() {
  system::register(#"challanges", undefined, &pre_main, undefined);
}

function private pre_main() {
  init_challenges();
}

function private init_challenges() {
  if(isDefined(level.challenges)) {
    return;
  }

  level.challenges = {};
  level.challenges.list = [];
  level.challenges.triggers = [];
  level.challenges.goals = [];
  campaignsettings = undefined;
  challenges = undefined;
  modebundle = getgamemodescriptbundle();

  if(isDefined(modebundle.campaignsettings)) {
    campaignsettings = getscriptbundle(modebundle.campaignsettings);
  }

  if(isDefined(campaignsettings.challenges)) {
    challenges = getscriptbundle(campaignsettings.challenges);
  }

  if(isarray(challenges.list)) {
    foreach(item in challenges.list) {
      if(!isDefined(item)) {
        continue;
      }

      challenge = getscriptbundle(item.challenge);

      if(!isDefined(challenge.name_id)) {
        continue;
      }

      level.challenges.list[challenge.name_id] = index;

      if(isDefined(challenge.triggers)) {
        level.challenges.triggers[challenge.name_id] = strtok(challenge.triggers, "\xc8x");
      }

      if(isDefined(challenge.progressgoal)) {
        level.challenges.goals[challenge.name_id] = int(challenge.progressgoal);
      }
    }
  }

  level.fnchallengeaward = &challengeaward;
  level.var_a27fc34c5fa1412e = &challengeprogressset;
  level.var_71254f85261cde3a = &challengeprogressget;
}

function clear() {
  assert(isPlayer(self));
  assert(isarray(level.challenges.list));

  foreach(index in level.challenges.list) {
    self function_627840b8a7387643("\xa2=S\x88#k\x14\xaf\x92_\x81\xaf\xf3\v\xc2\xe6\x99", index, 0);
    self function_627840b8a7387643(">&_L\xc0\x9d\xa5L\xb5SzD:\x944\x8f\x02", index, 0);
  }
}

function private challengeprogressset(challenge, progress, autoaward = 1) {
  assert(isPlayer(self));
  index = level.challenges.list[challenge];
  goal = level.challenges.goals[challenge];
  progress = int(clamp(progress ?? 0, 0, int(goal ?? 255)));

  if(!isDefined(index)) {
    iprintln("<dev string:x24>" + (challenge ?? "<dev string:x3c>") + "<dev string:x40>");

    return;
  }

  current = self function_6a6a2eb2befc5927("\xa2=S\x88#k\x14\xaf\x92_\x81\xaf\xf3\v\xc2\xe6\x99", index);
  progress = int(max(current, progress));
  self function_627840b8a7387643("\xa2=S\x88#k\x14\xaf\x92_\x81\xaf\xf3\v\xc2\xe6\x99", index, progress);

  if(istrue(autoaward) && (!isDefined(goal) || progress >= goal)) {
    thread challengeaward(challenge);
  }
}

function private challengeprogressget(challenge) {
  assert(isPlayer(self));
  index = level.challenges.list[challenge];

  if(!isDefined(index)) {
    iprintln("<dev string:x24>" + (challenge ?? "<dev string:x3c>") + "<dev string:x40>");

    return 0;
  }

  return self function_6a6a2eb2befc5927("\xa2=S\x88#k\x14\xaf\x92_\x81\xaf\xf3\v\xc2\xe6\x99", index);
}

function private challengeaward(challenge) {
  assert(isPlayer(self));
  index = level.challenges.list[challenge];

  if(!isDefined(index)) {
    iprintln("<dev string:x24>" + (challenge ?? "<dev string:x3c>") + "<dev string:x40>");

    return;
  }

  alreadyawarded = self function_6a6a2eb2befc5927(">&_L\xc0\x9d\xa5L\xb5SzD:\x944\x8f\x02", index);

  if(!istrue(alreadyawarded)) {
    goal = level.challenges.goals[challenge];

    if(isDefined(goal)) {
      progress = int(goal);
      self function_627840b8a7387643("\xa2=S\x88#k\x14\xaf\x92_\x81\xaf\xf3\v\xc2\xe6\x99", index, progress);
    }

    hud_notification::function_90f5d2120c11889d(level.challenges.list[challenge]);
    self function_627840b8a7387643(">&_L\xc0\x9d\xa5L\xb5SzD:\x944\x8f\x02", index, 1);

    foreach(triggerchallenge, triggers in level.challenges.triggers) {
      if(!isarray(triggers) || triggers.size == 0) {
        continue;
      }

      havecount = 0;

      foreach(otherchallenge in triggers) {
        otherindex = level.challenges.list[otherchallenge];

        if(!isDefined(otherindex)) {
          iprintln("<dev string:x45>" + (otherchallenge ?? "<dev string:x3c>") + "<dev string:x40>");

          continue;
        }

        otherawarded = self function_6a6a2eb2befc5927(">&_L\xc0\x9d\xa5L\xb5SzD:\x944\x8f\x02", otherindex);

        if(istrue(otherawarded)) {
          havecount += 1;
        }
      }

      if(isDefined(level.challenges.goals[triggerchallenge])) {
        challengeprogressset(triggerchallenge, havecount);
      }

      if(havecount >= triggers.size) {
        thread challengeaward(triggerchallenge);
      }
    }
  }
}