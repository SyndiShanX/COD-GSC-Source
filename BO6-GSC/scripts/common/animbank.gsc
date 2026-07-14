/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\animbank.gsc
***************************************/

#namespace animbank;

function private autoexec init() {
  level.animbank = [];
  bundlenames = getscriptbundlenames("\x86ZjA\xde^\x9f\xba");

  foreach(animbankassetname in bundlenames) {
    bundle = getscriptbundle(animbankassetname);

    if(isDefined(bundle)) {
      level.animbank[animbankassetname] = [];

      foreach(entry in bundle.entries) {
        entryname = tolower(entry.name ?? "");
        level.animbank[animbankassetname][entryname] = spawnStruct();
        level.animbank[animbankassetname][entryname].blend = entry.blend;

        if(isarray(entry.anims)) {
          level.animbank[animbankassetname][entryname].anims = [];

          foreach(animinfo in entry.anims) {
            if(!(isDefined(animinfo.animasset) && isDefined(animinfo.animasset.id))) {
              continue;
            }

            newindex = level.animbank[animbankassetname][entryname].anims.size;
            level.animbank[animbankassetname][entryname].anims[newindex] = animinfo.animasset.id;
          }
        }
      }
    }
  }
}

function check(animbank, animname, animindex) {
  animinfo = function_fe721d46c085d273(animbank, animname, animindex);
  return isDefined(animinfo[0]);
}

function play(animbank, animname, animindex, notifyname) {
  animinfo = function_fe721d46c085d273(animbank, animname, animindex);
  animasset = animinfo[0];
  blendtime = animinfo[1];

  if(isDefined(animasset)) {
    animlength = getanimlength(animasset);

    if(isstring(notifyname)) {
      self setflaggedanimrestart(notifyname, animasset, 1, blendtime, 1);
    } else {
      self setanimrestart(animasset, 1, blendtime, 1);
    }

    if(animlength > 0) {
      wait animlength;
    }
  }
}

function stop(animbank, animname, animindex) {
  if(isDefined(animindex)) {
    animinfo = function_fe721d46c085d273(animbank, animname, animindex);
    animasset = animinfo[0];
    blendtime = animinfo[1];

    if(isDefined(animasset)) {
      self setanim(animasset, 0, blendtime, 1);
    }

    return;
  }

  animbankassetname = getxhashasset("\x16\xe6\x96[\x89\xb0\xb9kG" + animbank);

  if(!isDefined(level.animbank[animbankassetname])) {
    return;
  }

  if(!isDefined(level.animbank[animbankassetname][animname])) {
    return;
  }

  anims = level.animbank[animbankassetname][animname].anims;

  if(isDefined(anims) && anims.size > 0) {
    blendtime = level.animbank[animbankassetname][animname].blend ?? 0.2;

    foreach(animasset in anims) {
      if(isDefined(animasset)) {
        self setanim(animasset, 0, blendtime, 1);
      }
    }
  }
}

function get_length(animbank, animname, animindex) {
  animinfo = function_fe721d46c085d273(animbank, animname, animindex);
  animasset = animinfo[0];
  blendtime = animinfo[1];

  if(isDefined(animasset)) {
    return getanimlength(animasset);
  }

  return 0;
}

function choose_index(animbank, animname) {
  animbank = tolower(animbank);
  animname = tolower(animname);
  result = [];
  animbankassetname = getxhashasset("\x16\xe6\x96[\x89\xb0\xb9kG" + animbank);

  if(!isDefined(level.animbank[animbankassetname])) {
    return result;
  }

  if(!isDefined(level.animbank[animbankassetname][animname])) {
    return result;
  }

  anims = level.animbank[animbankassetname][animname].anims;

  if(isDefined(anims) && anims.size > 0) {
    return randomintrange(0, anims.size);
  }

  return 0;
}

function function_fe721d46c085d273(animbank, animname, animindex) {
  animbank = tolower(animbank);
  animname = tolower(animname);
  result = [];
  animbankassetname = getxhashasset("\x16\xe6\x96[\x89\xb0\xb9kG" + animbank);

  if(!isDefined(level.animbank[animbankassetname])) {
    return result;
  }

  if(!isDefined(level.animbank[animbankassetname][animname])) {
    return result;
  }

  if(!isDefined(animindex)) {
    animindex = choose_index(animbank, animname);
  }

  anims = level.animbank[animbankassetname][animname].anims;

  if(isDefined(anims) && anims.size > 0) {
    animindex = int(clamp(animindex, 0, anims.size - 1));
    result[0] = anims[animindex];
    result[1] = level.animbank[animbankassetname][animname].blend ?? 0.2;
  }

  return result;
}