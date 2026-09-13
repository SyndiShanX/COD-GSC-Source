/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_controlled_callbacks.gsc
**********************************************************/

registercontrolledcallback(tag, eventcallback, timeout, evaluationcallback, bisthread, bischildthread, _id_8808E5AF3DD6CB90, biscodefunc, bnoself) {
  if(!isDefined(level.controlledcallbacks))
    level.controlledcallbacks = [];

  if(!isDefined(level.controlledcallbacksqueue))
    level.controlledcallbacksqueue = [];

  if(istrue(biscodefunc)) {
    if(!isbuiltinfunction(eventcallback) && !isbuiltinmethod(eventcallback))
      return;
  } else if(!isfunction(eventcallback)) {
    return;
  }
  level.controlledcallbacks[tag] = spawnStruct();
  level.controlledcallbacks[tag].eventcallback = eventcallback;
  level.controlledcallbacks[tag].bisthread = bisthread;
  level.controlledcallbacks[tag].bischildthread = bischildthread;
  level.controlledcallbacks[tag].biscodefunc = biscodefunc;
  level.controlledcallbacks[tag].bnoself = bnoself;
  level.controlledcallbacks[tag].timeout = timeout;
  level.controlledcallbacks[tag].evaluationcallback = evaluationcallback;
}

runcontrolledcallback(tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6) {
  if(!isDefined(level.controlledcallbacks[tag])) {
    return;
  }
  _id_FA89613ACD0EB87E = level.controlledcallbacks[tag].eventcallback;
  _id_76422EF20493DCD8 = ::evaluatecontrolledcallback;
  _id_782B865A4E685610 = 1;

  if(isDefined(_id_D2806125E4C7F8E6))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
  else if(isDefined(_id_D2806C25E4C81117))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
  else if(isDefined(_id_D2806B25E4C80EE4))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
  else if(isDefined(_id_D2806E25E4C8157D))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
  else if(isDefined(_id_D2806D25E4C8134A))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
  else if(isDefined(_id_D2806825E4C8084B))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
  else if(isDefined(_id_D2806725E4C80618))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618);
  else if(isDefined(_id_D2806A25E4C80CB1))
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag, _id_D2806A25E4C80CB1);
  else
    _id_782B865A4E685610 = [[_id_76422EF20493DCD8]](tag);

  if(_id_782B865A4E685610) {
    thread managecontrolledcallbacktimeout(tag);

    if(istrue(level.controlledcallbacks[tag].biscodefunc)) {
      if(istrue(level.controlledcallbacks[tag].bnoself)) {
        if(isDefined(_id_D2806125E4C7F8E6)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

          return;
        }

        if(isDefined(_id_D2806C25E4C81117)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

          return;
        }

        if(isDefined(_id_D2806B25E4C80EE4)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

          return;
        }

        if(isDefined(_id_D2806E25E4C8157D)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

          return;
        }

        if(isDefined(_id_D2806D25E4C8134A)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

          return;
        }

        if(isDefined(_id_D2806825E4C8084B)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

          return;
        }

        if(isDefined(_id_D2806725E4C80618)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

          return;
        }

        if(isDefined(_id_D2806A25E4C80CB1)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
          else
            [[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);

          return;
        }

        if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
          call[[_id_FA89613ACD0EB87E]]();
        else
          [[_id_FA89613ACD0EB87E]]();

        return;
      } else {
        if(isDefined(_id_D2806125E4C7F8E6)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

          return;
        }

        if(isDefined(_id_D2806C25E4C81117)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

          return;
        }

        if(isDefined(_id_D2806B25E4C80EE4)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

          return;
        }

        if(isDefined(_id_D2806E25E4C8157D)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

          return;
        }

        if(isDefined(_id_D2806D25E4C8134A)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

          return;
        }

        if(isDefined(_id_D2806825E4C8084B)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

          return;
        }

        if(isDefined(_id_D2806725E4C80618)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

          return;
        }

        if(isDefined(_id_D2806A25E4C80CB1)) {
          if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
            self call[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
          else
            self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);

          return;
        }

        if(isbuiltinfunction(_id_FA89613ACD0EB87E) || isbuiltinmethod(_id_FA89613ACD0EB87E))
          self call[[_id_FA89613ACD0EB87E]]();
        else
          self[[_id_FA89613ACD0EB87E]]();

        return;
      }
    }

    if(istrue(level.controlledcallbacks[tag].bisthread)) {
      if(isDefined(_id_D2806125E4C7F8E6)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
        return;
      }

      if(isDefined(_id_D2806C25E4C81117)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
        return;
      }

      if(isDefined(_id_D2806B25E4C80EE4)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
        return;
      }

      if(isDefined(_id_D2806E25E4C8157D)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
        return;
      }

      if(isDefined(_id_D2806D25E4C8134A)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
        return;
      }

      if(isDefined(_id_D2806825E4C8084B)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
        return;
      }

      if(isDefined(_id_D2806725E4C80618)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
        return;
      }

      if(isDefined(_id_D2806A25E4C80CB1)) {
        self thread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
        return;
      }

      self thread[[_id_FA89613ACD0EB87E]]();
      return;
    }

    if(istrue(level.controlledcallbacks[tag].bischildthread)) {
      if(isDefined(_id_D2806125E4C7F8E6)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
        return;
      }

      if(isDefined(_id_D2806C25E4C81117)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
        return;
      }

      if(isDefined(_id_D2806B25E4C80EE4)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
        return;
      }

      if(isDefined(_id_D2806E25E4C8157D)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
        return;
      }

      if(isDefined(_id_D2806D25E4C8134A)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
        return;
      }

      if(isDefined(_id_D2806825E4C8084B)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
        return;
      }

      if(isDefined(_id_D2806725E4C80618)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
        return;
      }

      if(isDefined(_id_D2806A25E4C80CB1)) {
        self childthread[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
        return;
      }

      self childthread[[_id_FA89613ACD0EB87E]]();
      return;
    }

    if(isDefined(_id_D2806125E4C7F8E6)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);
      return;
    }

    if(isDefined(_id_D2806C25E4C81117)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);
      return;
    }

    if(isDefined(_id_D2806B25E4C80EE4)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);
      return;
    }

    if(isDefined(_id_D2806E25E4C8157D)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);
      return;
    }

    if(isDefined(_id_D2806D25E4C8134A)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);
      return;
    }

    if(isDefined(_id_D2806825E4C8084B)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);
      return;
    }

    if(isDefined(_id_D2806725E4C80618)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);
      return;
    }

    if(isDefined(_id_D2806A25E4C80CB1)) {
      self[[_id_FA89613ACD0EB87E]](_id_D2806A25E4C80CB1);
      return;
    }

    self[[_id_FA89613ACD0EB87E]]();
  } else {}
}

evaluatecontrolledcallback(tag, _id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6) {
  if(scripts\engine\utility::array_contains(level.controlledcallbacksqueue, tag))
    return 0;

  if(isDefined(level.controlledcallbacks[tag].evaluationcallback)) {
    if(isDefined(_id_D2806125E4C7F8E6))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117, _id_D2806125E4C7F8E6);

    if(isDefined(_id_D2806C25E4C81117))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4, _id_D2806C25E4C81117);

    if(isDefined(_id_D2806B25E4C80EE4))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D, _id_D2806B25E4C80EE4);

    if(isDefined(_id_D2806E25E4C8157D))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A, _id_D2806E25E4C8157D);

    if(isDefined(_id_D2806D25E4C8134A))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B, _id_D2806D25E4C8134A);

    if(isDefined(_id_D2806825E4C8084B))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618, _id_D2806825E4C8084B);

    if(isDefined(_id_D2806725E4C80618))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1, _id_D2806725E4C80618);

    if(isDefined(_id_D2806A25E4C80CB1))
      return [[level.controlledcallbacks[tag].evaluationcallback]](_id_D2806A25E4C80CB1);

    return [[level.controlledcallbacks[tag].evaluationcallback]]();
  }

  return 1;
}

managecontrolledcallbacktimeout(tag) {
  level endon("game_ended");
  timeout = 0.05;
  level.controlledcallbacksqueue = scripts\engine\utility::array_add_safe(level.controlledcallbacksqueue, tag);

  if(isDefined(level.controlledcallbacks[tag].timeout))
    timeout = level.controlledcallbacks[tag].timeout;

  wait(timeout);
  level.controlledcallbacksqueue = scripts\engine\utility::array_remove(level.controlledcallbacksqueue, tag);
}