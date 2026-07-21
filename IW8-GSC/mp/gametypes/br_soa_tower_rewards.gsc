/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_soa_tower_rewards.gsc
*************************************************/

init() {
  level.ai_event thread _id_119F0();
}

_id_119F0() {
  level.ai_event._id_119FC = [];
  level.ai_event._id_12D26 = [];
  level._effect["_encstr_BA722020BDFB7E3B82FB281885E1B46F589B07519BBB1D7DAB2B028379B7E43F280F"] = loadfx("_encstr_BEC6342377888A438BE2B7D5D3D69C30250F6BF8DEE1D284B20BBFD78F8A55A8CE695010C53499352B1321FF87E228B8A7BFD8A92A8D");
  level._effect["_encstr_889C1BB3CC0F7D314EEB362BB395E6192CC9977D1BB77BA37D9D36DE77"] = loadfx("_encstr_AC7A2CC0EB0888BB1350F87EDACEFF09759F78885FB1504DEA68F076B2E121F1B51B98203F431011E259D409CD9B");
  _id_119F2();
}

_id_119F2() {
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = getdvarfloat("_encstr_BA691E0328D5F9AF6BA96B4F355177FD67A8FB5990532DDFA6374F7CDBF80347", 1.0);
  var_0["_encstr_83D8191DAACDA8781B3191187A1F38D0241CB99B32F908B73F8A49"] = getdvarfloat("_encstr_861C239B8D397DB0E4DA6EBE32CA0BB1FAC63AFAC25BB6DEEBB65AD8D8B24ED7132CCD2B46", 0.7);
  _id_119E8(var_0, "_encstr_8F6D10D8BDDEA3BE8E8589B195BEC2B6ADDB");
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = getdvarfloat("_encstr_A66926F05AF2CF59B3ED3E20FC37816111124009324ECF302F04C820C4B7C8C9C9DA20D81AE43DE9", 10);
  var_0["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922"] = getdvarfloat("_encstr_85C12E3B629BE040DA2DDF8F4C471831872A53268A2F2EC0B9349FF76421908DDFB2492BA27F65C84E1F93FB975559EF", 10);
  var_0["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"] = getdvarfloat("_encstr_ADC12E13A7F0B1EF56D84B71012527B54111ACB73F0BC293E8D0827A2B107FEFE9F7310341498B43AEA8BA4250D06FB2", 5);
  var_0["_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC"] = getdvarfloat("_encstr_97C12E3EEB4366530A4A3851F2E70B589F9CC5A043B72B89B942E0C88B31D391473BC72ED0A753FD9E9AF8D012958703", 2);
  var_0["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"] = getdvarfloat("_encstr_B28B2AB91B4E7D8539DA6EBE8C95B08DF5C61DFA8DC23743BEB1DEB747AF2D8CFAC6586EA1EB27B09C2BF5C4", 0.5);
  var_0["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = getdvarfloat("_encstr_B48B2A4AF993CF9ABE5BB70FA1ED4224C1A003D991E0AB42AF413FD7B9988A6419A9FE5A68B952EAEE7BF7AA", 0.25);
  var_0["_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926"] = getdvarfloat("_encstr_8D222A23792E6746B0F3436789600ED3C0F0CB69C10F1FFC01C9472FB189D43B6889121348C81FB2983F7F79", 0.1);
  var_0["_encstr_B8F81BDDD3DAA8585CF93BB01B3E78D553FF57637F4278C0704C41AED2"] = getdvarfloat("_encstr_8C222A9AF6ADB9311B30AF1750D1E9521F99A3196E333370C620E7CF284EA99A47A66E8A4327EA9028302FB2", 0.05);
  _id_119E8(var_0, "_encstr_977F1036EDDE3AFAE816896356FAD8B0CDA1");
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = getdvarfloat("_encstr_8D38263656AB37A9F2CFE891F33D6199C13D2DA82FB213F3F7237B189B6F38312925284544AAC519", 10);
  var_0["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"] = getdvarfloat("_encstr_844429E78F23A80B624D73CE375D4879A9DB913707FA0F40B7E5F8C05B3F30A5414F3BD3FBA1C708AD3D43", 4);
  var_0["_encstr_81D6144C4E63B7F6477D7B9933342CB9327D339358D9"] = getdvarfloat("_encstr_A557286E1B397D0BE45BB97D91AC168DFA8D8E7DD9CA5839FA36B7DED1AFB432FAEC560BE4F5CC9C16CE", 0.5);
  var_0["_encstr_96B6164C938DDEDEA3D7B73399D00BDC46D7E6B2B5A3B20F"] = getdvarfloat("_encstr_87512A0F078649D920AD7A4919A0E1B2C8819B47E7A512822148754DF399216AA03F473775C07B4D6853EF90", 0.35);
  var_0["_encstr_8D2A1562F0B930ED7CAFBFBB6D21171B7AD0F32C57EEF1"] = getdvarfloat("_encstr_A13729D73A13B9CB931D3B6814B72F2B4E9BABB85CD8B2EA81F965981B46D4119FA29DE2134965E2689742", 0.5);
  var_0["_encstr_91A915AE025A4778E4F7F848EB68718D02E19EA1DD422B"] = getdvarfloat("_encstr_8B01299BC6ED71EB1B6AEAAF302B6AC1C088E32E074A373E476BB78FEB69B0CFC1A70147725F8017A87FBD", 0.25);
  var_0["_encstr_B4C917454B4230F0E441706937D0C8F89A9723D7ABDA05281E"] = getdvarfloat("_encstr_B8322BF8FB6379E7A625FB699CE9B289219CDB6F6FD229DDAF75E2486BA960B886F19FE01B76E2A87BF89158FB", 0.2);
  _id_119E8(var_0, "_encstr_B6A31063DEF61DBED1C2C41BB2D73BAC1639");
  var_0 = [];
  var_0["_encstr_A7201F9A1D9825BF3DE613DA8B18AB1FC0DF13E177E0611FE899FAF290E0CB5922"] = getdvarfloat("_encstr_97CE2F93B845491FDB39FBDF45C1E74DF7586BE9181DBB031108FC17E8CB575439298282E881F9DF280EF71DF1F04B11FB", 5);
  var_0["_encstr_AB201FCBA509CA5790C63A05BB7864A2DE67473F4FA371052829F54D5098A65996"] = getdvarfloat("_encstr_88CE2F17F6AD17A1ADE5AEC80C0AC6E8CF991B71921293839D47F98A85D1C0A0392F72FAFE72B633989FDFBB8DCF30F9D3", 1);
  var_0["_encstr_99201FC49CB1DBDB1D7D0EB1EAB932CAC9BED858B9A17DABE61BF6DADADB9B7DCC"] = getdvarfloat("_encstr_81CE2F378D4E7D854EADCDD7322BB08DEB36E8F5899CABA395EBB1B7B7D1EBB423D7B1B0DC347DAB37B17BDAADBD377D66", 0.7);
  var_0["_encstr_AC611B9843E4685F3BA1575103B28191425F08083F88265DB212C5F00A"] = getdvarfloat("_encstr_8A152B1BD62B1F06BD387BB118FB7EABE6C984BFFEF37F8B4B9192CA58E1397739381B398E188F526B100AC182", 0.5);
  var_0["_encstr_BE611B23BDD940EF98B99AEBEB609FBD08A61B6FC363217A878B888FA3"] = getdvarfloat("_encstr_84152BE35793411FA6089B41317557C511217C47EDA813B3C566624A38D5777C60DFE3C127A0D1E3FF3BCA31AB", 0.25);
  _id_119E8(var_0, "_encstr_BE1311637BEDE8AFA316C41B95BE984EAEA395");
  var_0 = [];
  var_0["_encstr_862B21C666B99207E389A717809BCF4A07F18D31CD7B2B5CA8E0EB2F30118732DB9C17"] = 1;
  _id_119E8(var_0, "_encstr_99322281E7AA65991C3639F0DFCF889EE3131B5F4352A42B2E4F41CBC0E7685D1AEB97B5");
  var_0 = [];
  var_0["_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132"] = 1;
  _id_119E8(var_0, "_encstr_864D1B51E75D20D0AB6221E80A2F76A87354DBBF86866081737918F1D3");
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = getdvarfloat("_encstr_8C542D6E6C9CFA85C96B37D719AC1663BE1BD1BE46CAC1D8DBBCB0C4D8566ED71BBDBD1DD79691F5E67BE81A2DE676", 18);
  var_0["_encstr_AC85165B4058B72A094832ABC7C3337F01A8FFE7F831FF23"] = getdvarfloat("_encstr_8B1D358750030F42BDE9BAB9454B9AF44ED013AFC05978DAEFFB06EEB963F3BF7060878B81B0A411EF954A279E6FEA5AF8F87B9F13A878", 1.0);
  var_0["_encstr_B6C113D67689A237D399ABC3700BF56949B79B0ED3"] = getdvarfloat("_encstr_AC1533CB7F286947FE60E329695D7F1DE9F9441F99486A3B289ADAC270A5FF990857C7BC5740372FC7D3121A5B90A7CE6037483559", 1.0);
  var_0["_encstr_91AF137EAB808F2AED6F0757619C51EAA0B334C3E1"] = getdvarfloat("_encstr_8DF5312037CA5E738BFD263897D2BBE03FE3E0C9B375F33122E017BE6D0AA7CE6457B008F701C99FCB8F99B48913C313D95B78", 1.0);
  var_0["_encstr_91591A4CE463DE7BA3AF9B57C12BE4AFB6AB734B3A4BB7379B31DB3C"] = getdvarfloat("_encstr_B8CD331387751F6FEA3AB70692278F38D9BA7B798C62C0DA605BD77AA26A634EF56097750F1AB4BF9F1F1B88349F2590C076EA5FF3", 1.0);
  var_0["_encstr_8F561BAD4BD0CA7F535F8B2B432D33F71211E7FB582FAD7F0988E307A0"] = getdvarfloat("_encstr_B2CF34AFC0FB1EF9C64537C0BBF8B92D17694B31D9E5411017E7A98D0D57D630D2821FAB6EF1E32F0BABDFF89108A3A7207B5FEBAA33", 1.0);
  _id_119E8(var_0, "_encstr_AD711736DBF6A3F5E8C289362BBE19B207B1F6E5851336B26E");
  var_0 = [];
  var_0["_encstr_B24F18D0D50860050977EA2739C8E3272B969CA180DFF8D3604F"] = 1;
  _id_119E8(var_0, "_encstr_A27D1FDD70178B8F5BD06B5BD81678E2CF9DA299EC9592FA46E0676FF1AB212A9F");
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = getdvarfloat("_encstr_9A55394FCB3A592F5342E36E3AE7D738992CD99F602550650B59793372C38080AFAE6B751D8190B84792509E8A9F4068491989AF8E75D873B73A49", 1.0);
  var_0["_encstr_A2FF1CCAA3D94F2D58BF6A7FD1E8F687FD98238129AB7B22D8576C71FD60"] = getdvarfloat("_encstr_87BD49F34710510FB638AB51210547D521318C57F950E3C75E96E28BE9EE878A18BD19E67B29EBA78AC96A4150B08F43716B8C47A97B73772EA6F29BD91E173AC8CD09D62BD97B175A999A", 0.25);
  _id_119E8(var_0, "_encstr_8D6223FC4FE88BE7A5898A721168130550337A47E7A816EBD8C3F2DBF8D49FF1E0BFEBC51D");
}

_id_119F7(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  wait(var_3);
  var_4 = level.ai_event._id_119FC[var_0];
  var_2.dropstruct = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_2.dropstruct.ml_p3_to_safehouse_transition = scripts\engine\utility::ter_op(var_1 == 1, 6 + randomintrange(1, 10), 6);
  var_2.dropstruct.silencer_pick_up_monitor = 0;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = randomfloat(1.0);

    foreach(var_13, var_8 in var_4) {
      var_9 = var_8[2];
      var_10 = var_8[3];

      if(var_6 >= var_9 && var_6 <= var_10) {
        var_11 = undefined;

        switch (var_13) {
          case "_encstr_8DDE08CDF61D434BB9B3":
            return;
          case "_encstr_83D8191DAACDA8781B3191187A1F38D0241CB99B32F908B73F8A49":
            if(isDefined(var_2)) {
              var_12 = weaponclass(var_2.eattacker getcurrentweapon());

              switch (var_12) {
                case "_encstr_965306392D3336B2":
                  var_11 = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
                  break;
                case "_encstr_BE0703A54C":
                  var_11 = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
                  break;
                case "_encstr_8D940738966ED1DB8D":
                  var_11 = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
                  break;
                case "_encstr_BE1904DCDA9D":
                  var_11 = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
                  break;
                case "_encstr_850707F7E5833355B8":
                  var_11 = "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
                  break;
                case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
                  var_11 = "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
                  break;
                case "_encstr_A1100738A33A638123":
                  var_11 = "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
                  break;
              }
            }

            break;
          default:
            var_11 = var_13;
            break;
        }

        var_2.dropstruct.ml_p3_to_safehouse_transition = var_2.dropstruct.ml_p3_to_safehouse_transition + 2;
        thread _id_119F8(var_11, var_2);
        wait 0.002;
      }
    }
  }
}

_id_119F8(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = (0, 0, 0);
  var_1.legendary = 0;

  if(issubstr(var_0, "_encstr_A2AD058D56B3CA")) {
    var_3 = randomintrange(15, 40);
    var_1.dropstruct.ml_p3_to_safehouse_transition = var_3;
    var_1.legendary = 1;
  }

  switch (var_0) {
    case "_encstr_88AF28F02B8C30079319770E6EFA47FBD7F760C8DB67C9CF3AFF608CC6D3B1C36FA388C81FF280B9D132":
      var_3 = 0;
      var_1.dropstruct.ml_p3_to_safehouse_transition = var_3;
      var_1.legendary = 1;
      break;
  }

  var_4 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A41(var_0, var_1.dropstruct, var_1.origin + (0, 0, var_1.dropstruct.silencer_pick_up_monitor), var_1.angles, 0, var_1.legendary, 0);
  var_1.dropstruct.silencer_pick_up_monitor = var_1.dropstruct.silencer_pick_up_monitor + 3;
}

_id_119E8(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0)
  var_3 = var_3 + var_5;

  var_7 = 0;
  var_8 = getarraykeys(var_0);
  var_9 = undefined;

  foreach(var_14, var_5 in var_0) {
    var_2[var_14] = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2[var_14] = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  level.ai_event._id_119FC[var_1] = var_2;
}

_id_12D28(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_4 = var_0 _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_set_hot();

  if(!var_4) {
    return;
  }
  if(!isDefined(self._id_12D29) || self._id_12D29 != var_0) {
    self._id_12D2A = self._id_12D29;
    self._id_12D29 = var_0;
  }

  if(!isalive(self) && isDefined(var_1) && isDefined(var_2)) {
    var_5 = 0;
    var_5 = scripts\mp\utility\damage::isheadshot(var_1, var_2, var_0);
    self._id_12D25 = var_5 && !self.enemy_left_monitor;
  }

  if(!isalive(self)) {
    if(!isDefined(var_0.boardroomopen))
      var_0.boardroomopen = 1;
    else
      var_0.boardroomopen = var_0.boardroomopen + 1;
  }

  if(self.enemy_left_monitor && isalive(self)) {
    if(!isDefined(var_0.body0))
      var_0.body0 = var_3;
    else
      var_0.body0 = var_0.body0 + var_3;
  }
}

_id_12D22(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "_encstr_85DE0947B06DAC23DBDDB9":
      if(isDefined(self._id_12D29)) {
        if(!self.enemy_left_monitor) {
          var_1 = scripts\engine\utility::ter_op(self._id_12D25, "_encstr_AB752861D557BB0D61C725106F37506F9E5FC30FAAC9C9D3200BBD2619BFBF5865378892319BA340B788", "_encstr_83081F06D361EB623F3753C79FD57B0FD099FB4E4BD0BF7A03793B0F9B8C726648");
          var_3 = self.is_correct_wire_color.smeansofdeath == "_encstr_911B0C7DA090E9A7F799FD50DD48" || self.is_correct_wire_color.smeansofdeath == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421";
          var_1 = scripts\engine\utility::ter_op(var_3, "_encstr_8F7B29C66A0117ED899F78A817A5FB17BBD7C4DFC20A8748794B803137FFD1BD03F1B5DBDA625F3351CBC0", var_1);
          var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

          if(self._id_12D29 _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_origin())
            var_2 = 1;

          self._id_12D29 thread scripts\mp\rank::giverankxp(var_1, var_2);
          self._id_12D29 thread scripts\mp\rank::scoreeventpopup(var_1);

          if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
            self._id_12D29 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_871E3BFB7B57DA981EC0B3B7133144C18B790435CB4DB2CC61196FAB2BE8092A7F188E6AA1DFA9E409C043677080EA3117869933AF2B732DB01097FF88", 1);
        } else {
          var_1 = "_encstr_83581FC4C9FA37ED2CF5D1BDDDCA937D9CB2EE0B9C46D76D961B1BBE31C9AB3A59";
          var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

          foreach(var_5 in level.ai_event._id_12662) {
            var_5 thread scripts\mp\rank::giverankxp(var_1, var_2);
            var_5 thread scripts\mp\rank::scoreeventpopup(var_1);

            if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
              var_5 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_871E3BFB7B57DA981EC0B3B7133144C18B790435CB4DB2CC61196FAB2BE8092A7F188E6AA1DFA9E409C043677080EA3117869933AF2B732DB01097FF88", 1);
          }
        }
      }

      break;
    case "_encstr_A1BD075837DCD29B47":
      if(isDefined(self._id_12D2A) && !self.enemy_left_monitor) {
        var_1 = "_encstr_B1AE2675C279301027691B60F3EF5699CA2DD7EB6A1F096A6F72106E7ACF8568E3BF0347F304A02D";
        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

        if(self._id_12D2A _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_origin())
          var_2 = 1;

        self._id_12D2A thread scripts\mp\rank::giverankxp(var_1, var_2);
        self._id_12D2A thread scripts\mp\rank::scoreeventpopup(var_1);

        if(getdvarint("_encstr_B8B00BCDB1BEE60DBCD0C1F0E1", 0) == 6)
          self._id_12D2A scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_871E3BFB7B57DA981EC0B3B7133144C18B790435CB4DB2CC61196FAB2BE8092A7F188E6AA1DFA9E409C043677080EA3117869933AF2B732DB01097FF88", 1);
      }

      break;
    case "_encstr_92A70DB84263F9805DA70775C44528":
      if(isDefined(self._id_12D29) && self.enemy_left_monitor) {
        var_1 = "_encstr_96092CA040E1CE0A89812B380FC9C5676E6DCB47D3FA997CD09A3110364BA353A2DFF7883D79D3BDA49FDB35CABC";
        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

        if(self._id_12D29 _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_origin())
          var_2 = 1;

        self._id_12D29 thread scripts\mp\rank::giverankxp(var_1, var_2);
        self._id_12D29 thread scripts\mp\rank::scoreeventpopup(var_1);
      }

      break;
  }
}

_id_12D21(var_0) {
  switch (var_0) {
    case "_encstr_BDCB11D9B55B818E01C77838936740F3D21D4E":
      var_1 = scripts\engine\utility::array_sort_with_func(level.ai_event._id_12662, ::_id_12D1F);

      foreach(var_3 in var_1) {
        if(!isDefined(var_3.boardroomopen) || var_3.boardroomopen == 0)
          var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }

      var_5 = var_1[0];

      if(!isDefined(var_5)) {
        return;
      }
      if(!var_5 _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_set_hot()) {
        return;
      }
      var_6 = "_encstr_AF3F2B262AC7A8A88917A0688F475BA723124FF0E0D8E8EA828D18810650CD66BC86C88F40D40E50D9CCB563A1";
      var_7 = scripts\mp\rank::getscoreinfovalue(var_6);
      var_5 thread scripts\mp\rank::giverankxp(var_6, var_7);
      var_5 thread scripts\mp\rank::scoreeventpopup(var_6);
      _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_locations_logic(var_5, "_encstr_99EF2D02DBB177E051D091C2803B382943A377B76265E767B7E1017FAB0EF25729D6EC91BD089F69CF202198055A5D", var_5.boardroomopen);
      break;
    case "_encstr_A6851252683E5B59807DD5DC7B41DF5769C18A5A":
      var_8 = scripts\engine\utility::array_sort_with_func(level.ai_event._id_12662, ::_id_12D20);

      foreach(var_3 in var_8) {
        if(!isDefined(var_3.body0) || var_3.body0 == 0)
          var_8 = scripts\engine\utility::array_remove(var_8, var_3);
      }

      var_5 = var_8[0];

      if(!isDefined(var_5)) {
        return;
      }
      if(!var_5 _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_set_hot()) {
        return;
      }
      var_6 = "_encstr_A7E72B90F00977023FF12B37DCC1F867CE977CA88E9038BCB9A0F5D1B07BCBA3F2E0E06DF36B1E3519FA5BFF1A";
      var_7 = scripts\mp\rank::getscoreinfovalue(var_6);
      var_5 thread scripts\mp\rank::giverankxp(var_6, var_7);
      var_5 thread scripts\mp\rank::scoreeventpopup(var_6);
      _encstr_8EE62F83DA235360C3AB8F13B07D902F27D2FB4A53D796629E826727C7D6896D876B5193491FC3A9777E2B65E4ED3BB66F::objective_locations_logic(var_5, "_encstr_81C02DC493EBCD7B85AF3AEDEEB24E7D9C95BB582719D7CD1C1B58E634AF3127AE8E2BBED6B737A3BE8CC25BC2CE2B", var_5.body0);
      break;
  }
}

_id_12D1F(var_0, var_1) {
  var_2 = var_0.boardroomopen;
  var_3 = var_1.boardroomopen;

  if(!isDefined(var_2) || !isDefined(var_3))
    return 1;

  return var_2 > var_3;
}

_id_12D20(var_0, var_1) {
  var_2 = var_0.body0;
  var_3 = var_1.body0;

  if(!isDefined(var_2) || !isDefined(var_3))
    return 1;

  return var_2 > var_3;
}