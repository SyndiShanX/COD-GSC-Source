/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\utility\streamhint.gsc
*********************************************/

#namespace streamhint;

function playerwaittillstreamhintcomplete() {
  if(self.prestreaminglocation) {
    self waittill("playerPrestreamComplete");
  }
}

function playerstreamhintlocation(streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d) {
  thread playerstreamhintlocationinternal(streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d);
}

function playerstreamhintlocationinternal(streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d) {
  if(!isDefined(self)) {
    return;
  }

  self notify("playerPrestreamLocationWait");
  self endon("playerPrestreamLocationWait");
  self endon("disconnect");
  waitforstreaming = !self isplayerheadless() && !isbot(self);

  if(!waitforstreaming) {
    println("<dev string:x24>");
  }

  if(!isDefined(timeoutms)) {
    timeoutms = getdefaultstreamhinttimeoutms();
  }

  timeout = gettime() + timeoutms;
  self.prestreaminglocation = 1;
  self.var_7e28ad9fcf969ca = undefined;

  self iprintlnbold("<dev string:x43>" + streamorigin[0] + "<dev string:x6d>" + streamorigin[1] + "<dev string:x6d>" + streamorigin[2] + "<dev string:x73>");

  if(!self ispredictedstreamposready()) {
    self iprintlnbold("<dev string:x79>");

    self clearpredictedstreampos();
  }

  waitstarttime = gettime();
  currenttime = waitstarttime;

  if(waitforstreaming) {
    println("<dev string:xa8>");
    waitframe();

    while(true) {
      currenttime = gettime();

      if(self.pers["streamSyncComplete"]) {
        break;
      }

      if(currenttime >= timeout) {
        break;
      }

      waitframe();
    }
  }

  timedouttext = "<dev string:xc6>" + timeoutms / 1000 + "<dev string:xd5>";
  result = timedouttext;

  if(self.pers["<dev string:xe2>"]) {
    result = "<dev string:xf8>" + (currenttime - waitstarttime) / 1000 + "<dev string:xd5>";
  }

  self iprintlnbold("<dev string:x117>" + result + "<dev string:x12f>");

  if(function_bac26315148e18d3()) {
    println("<dev string:x134>");
    self predictstreamposuntilcleared(streamorigin);
  }

  if(streamcustomization) {
    println("<dev string:x160>");
    self loadcustomizationplayerview(self);
  }

  if(waitforstreaming) {
    waitframe();

    debugwaittime = getdvarfloat(@ "hash_e799b8bb09ac23a4", 0);

    if(debugwaittime > 0) {
      wait debugwaittime;
      self iprintlnbold("<dev string:x180>" + debugwaittime + "<dev string:x1a6>");
    }

    currenttime = gettime();

    if(currenttime < timeout) {
      startms = currenttime;

      while(true) {
        currenttime = gettime();

        if(currenttime >= timeout) {
          break;
        }

        ready = self ispredictedstreamposready();

        if(ready) {
          println("<dev string:x1b4>");
          break;
        }

        waitframe();
      }

      result = timedouttext;

      if(ready) {
        result = "<dev string:x1d5>" + (currenttime - startms) / 1000 + "<dev string:xd5>";
      }

      self iprintlnbold("<dev string:x117>" + result + "<dev string:x12f>");
    }

    if(currenttime < timeout && streamcustomization) {
      startms = currenttime;

      while(true) {
        currenttime = gettime();

        if(currenttime >= timeout) {
          break;
        }

        ready = self hasloadedcustomizationplayerview(self);

        if(ready) {
          println("<dev string:x1f7>");
          break;
        }

        waitframe();
      }

      result = timedouttext;

      if(ready) {
        result = "<dev string:x1d5>" + (currenttime - startms) / 1000 + "<dev string:xd5>";
      }

      self iprintlnbold("<dev string:x117>" + result + "<dev string:x12f>");
    }

    self.var_7e28ad9fcf969ca = 1;

    if(extrawaittime) {
      var_68df72ab7a2b3c5d = getdvarint(@ "hash_6f5f8daeb9f79d47", 5000) / 1000;
      wait var_68df72ab7a2b3c5d;

      self iprintlnbold("<dev string:x217>" + var_68df72ab7a2b3c5d + "<dev string:x1a6>");
    }

    currenttime = gettime();

    if(isDefined(var_654469cb39851c3d)) {
      startms = currenttime;

      var_c044f1d106e95c6c = getdvarint(@ "hash_9d5507c09010bae5", 2000);
      timeout = currenttime + var_654469cb39851c3d;
      var_7ae62165182c2ce6 = 0;

      while(true) {
        currenttime = gettime();

        if(var_654469cb39851c3d != -1) {
          if(currenttime >= timeout) {
            break;
          }
        } else {
          self iprintlnbold("<dev string:x240>");
        }

        if(currenttime > var_7ae62165182c2ce6) {
          self predictstreamposuntilcleared(streamorigin);
          var_7ae62165182c2ce6 = gettime() + var_c044f1d106e95c6c;
        }

        waitframe();
      }

      result = "<dev string:x277>" + (currenttime - startms) / 1000 + "<dev string:xd5>";
      self iprintlnbold("<dev string:x117>" + result + "<dev string:x12f>");
    }
  }

  var_43f78349754581f3 = !waitforstreaming || self ispredictedstreamposready();
  var_4e3de697683e929b = (currenttime - waitstarttime) / 1000;
  println("<dev string:x29b>" + streamorigin[0] + "<dev string:x6d>" + streamorigin[1] + "<dev string:x6d>" + streamorigin[2] + "<dev string:x2d8>" + var_4e3de697683e929b + "<dev string:x2e1>" + (var_43f78349754581f3 ? "<dev string:x2f0>" : "<dev string:x2fc>") + "<dev string:x309>");
  self iprintlnbold("<dev string:x30e>" + var_4e3de697683e929b + "<dev string:x1a6>");

  self.prestreaminglocation = undefined;
  self notify("playerPrestreamComplete");
}

function function_bac26315148e18d3() {
  return !isbrgamemode() || level.skipprematch || !isDefined(level.infilstruct.var_e3fb172254c8751) || level.infilstruct.var_2c8cdd72c4c046d7 || !getdvarint(@ "hash_f49bd659b301fbb0", 1);
}

function getdefaultstreamhinttimeoutms() {
  return getdvarint(@ "hash_aaffd5b201281ad4", 9000);
}