/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\usability.gsc
***********************************************/

setselfusable(var_0) {
  self makeusable();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

setallunusable() {
  foreach(var_1 in level.players)
  self disableplayeruse(var_1);
}

maketeamusable(var_0) {
  self makeusable();
  thread _updateteamusable(var_0);
}

_updateteamusable(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self enableplayeruse(var_2);
        continue;
      }

      self disableplayeruse(var_2);
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

makeenemyusable(var_0, var_1) {
  self makeusable();
  thread _updateenemyusable(var_0, var_1);
}

_updateenemyusable(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0.team;

  for(;;) {
    if(level.teambased) {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          if(var_4.team != var_2 || var_4 == var_0)
            self enableplayeruse(var_4);
          else
            self disableplayeruse(var_4);

          continue;
        }

        if(var_4.team != var_2) {
          self enableplayeruse(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    } else {
      foreach(var_4 in level.players) {
        if(istrue(var_1)) {
          self enableplayeruse(var_4);
          continue;
        }

        if(var_4 != var_0) {
          self enableplayeruse(var_4);
          continue;
        }

        self disableplayeruse(var_4);
      }
    }

    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

notusableforjoiningplayers(var_0) {
  self notify("_encstr_A12D1810DF14F3BF42D6718DACDAF3D86143D0587BD98A5B5BBA");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A12D1810DF14F3BF42D6718DACDAF3D86143D0587BD98A5B5BBA");
  self endon("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_1);

    if(isDefined(var_1) && var_1 != var_0)
      self disableplayeruse(var_1);
  }
}

notusableafterownerchange(var_0, var_1) {
  self notify("_encstr_8B551AE0B70B7307BECA90D01297F189FB2FF468154BF979E632D028");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8B551AE0B70B7307BECA90D01297F189FB2FF468154BF979E632D028");
  self endon("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");

  for(;;) {
    var_1 waittill("_encstr_8A420D18FC784DBB5E48F9E077671B");
    self disableplayeruse(var_0);
  }
}