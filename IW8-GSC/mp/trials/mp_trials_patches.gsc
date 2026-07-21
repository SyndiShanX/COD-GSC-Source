/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trials_patches.gsc
***********************************************/

init_trial_patches() {
  level.create_script_file_ids = [];
  level.cs_scripted_spawners = [];
  level.scripted_spawners = [];
  level.cs_scripted_spawners_triggers = [];
  level.scripted_spawners_triggers = [];
  level.cs_scripted_spawners_models = [];
  level.scripted_spawners_models = [];
  level.createscriptfilesinitialized = 0;
  level.scripted_spawner_func_strings = [];
  level.scripted_spawner_map_strings = [];
  level.scripted_spawner_func = [];
  var_0 = level.trial["_encstr_836105A5EFB2E5"];
  var_1 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_2 = level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"];
  var_3 = level.trial["_encstr_B6A208B3C2275AC2B9E8"];

  switch (level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"]) {
    case "_encstr_8A1804DAAB75":
      break;
    case "_encstr_8E95062EE46DB683":
      level._effect["_encstr_9A561345CDBCE82E2BC26629FBB351209229EFFD22"] = loadfx("_encstr_87762DD9CCF0E52DEEC17D5BC1979DB21A5AB1D82B97CE66C37D53ACB2E0EBB6E0D7322BB04743F5AC3C1C7167CC1E");
      level._effect["_encstr_9BF6123B2B1A5A8DC62B7DB20F0736BD6E96F6B9"] = loadfx("_encstr_AFA632AB717358881B603EEB5FE0D7D8CFA5A7930322BE95CA8BD5E6D39B5783F85171AA22B0DBC73B70E848F142B3C0A5E8B391");
      level._effect["_encstr_B1190D56EB607CA71999C922606EF7"] = loadfx("_encstr_97AA30EB370B67D3BFB05A3B42C3A76B1203CCD7C5D27E60E1DF36ABE0C329DB0D61702383C8A1B72DE10E6CF7D23646C281");
      level._effect["_encstr_83E317ECCA0DA5368DCAEB26B7DA26BEB2870E637B6EA5F6DC"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
      level._effect["_encstr_961C123E562BEDA96C87D82823B42027227DA01F"] = loadfx("_encstr_BEE930EB333A17AAAF5B854A66B773AFE380631F48539122C19D9A954C5D2B97AB28B33F70A9DAEB3B21E93FB3590666F1A8");
      level._effect["_encstr_821C121E760BCD894C6738C8C394ED07421D80BE"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
      level._effect["_encstr_87C513C416C993CA63D79963C2B6957DDCD62C63D8"] = loadfx("_encstr_847535EC66875ED2BB0E97C193DBC1976EB1275A83A3C289C6AC9B97CECCC3F519ACB91DF531589CE4ACD8F566B43956D7E6B5179DCC87");
      level._effect["_encstr_88740C2A8BD8D2C761B602FA3BCD"] = loadfx("_encstr_883A32D39980C0D07742D238CDCADB158872DAE7B19B39E358B367B0E8FF8887C8DF8313275831AD936804FF7B7B5DCDC0C8EBBB");
      level._effect["_encstr_AD331373AB6D56D7C9DE36B14BE6D9AF23B2C28ED0"] = loadfx("_encstr_929E3215460326182B29D73A038AEFD01C158F6B5B0741AC52AB478389DEE7527061EA924F410FF2C7632321A0C9F1C770B865D0");
      break;
    case "_encstr_83AD0559672E3A":
      break;
    case "_encstr_AFDD05A6AB763B":
      break;
    case "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0":
      break;
    case "_encstr_8E4708C12DE8D834AC27":
      break;
    case "_encstr_AC1F058B9EABE0":
      level._id_142A5 = loadfx("_encstr_A2F02785F3EBF86817E22968CDD0D206321B2BAFDB721BC1367D51DBF797D8C9EAE7E7B3235EE43050");
      level._id_14297 = loadfx("_encstr_A3BE32E3B7484A834B9E1789CF03DD18FB5D091B5AB7684FE6F38DA90FDA1D398926B15106F688688AA3FB851F41C78216FB59CA");
      level._effect["_encstr_A78F076CA54E1B1B56"] = loadfx("_encstr_B8D92B063382E5148FE91E8292CF20A3B4C723206F23D6E9BEDBB5C1912282B1B3D13DC7CFAB3B6B6142B5E7A3");
      break;
    case "_encstr_A1790BD0BB7517785F6EB4BD6A":
      break;
    case "_encstr_850707F7E5833355B8":
      level._effect["_encstr_95411458AD89AB37D0FADCE65AE0B2E4BE3B36A5378E"] = loadfx("_encstr_A5CF2B9BCF2022EB138A2FA117EB25C09FA4E031F477189BCE8BA571E783F8A0787F0B8E5FC480D853828D4553");
      level._effect["_encstr_A2690CA383FC6B20CFDE8977A24F"] = loadfx("_encstr_916735EC3387CB5ABB07BE5B0779592E5D960EDA56731DBCD1856CAFD2CD6E5693D1E59DCC3CF54716B17D99631627B2FACADCE2D9993C");
      level._effect["_encstr_93BC0F0B03FBD74DA18968159DE8D44B15"] = loadfx("_encstr_AC223A0B5FB0B27BA33A5F2D3B0EB1907FF2B361471928215E1B1501770206A10B8B9959AC6D50F0F21713215F7AC5C0B566637193A98810BE4B05F1");
      level._effect["_encstr_88D6138E27B416D8D78E34AC4EB6D21D95D72B3723"] = loadfx("_encstr_84BB2A68BAC0BFC837C8584978AEB1CB6BD2D008221D71481BBED3A8549BF995D53A68C0F9778DF922B6D433");
      break;
    default:
      break;
  }

  switch (level.trial["_encstr_836105A5EFB2E5"]) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      _id_11DDE();
      break;
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      _id_11DCC();
      break;
    case "_encstr_BA4D0DED61799A1FB5DB6AD2E30753":
      _precalcsafecirclecenters::switcharray();
      break;
    case "_encstr_AB5D0960CBB77E40E7D955":
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      _id_121EF(var_0, var_1);
      thread _id_11D7E(var_0, var_1);
      break;
    case "_encstr_8E020FABE7B9F00F4EC0F83381FDDA9004":
      _id_11DDF();
      break;
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
    case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
      _id_11DE7(var_2, var_1, var_3);
      break;
    case "_encstr_A3890850E25F90B79A83":
      _id_11DE6();
      break;
    case "_encstr_A6640D9D1109AF2FC7082B029395FF":
      _id_11DD4();
      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      _id_11DC4();
      break;
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      _id_11DE4(var_3);
      break;
    case "_encstr_AA160FAD077DB6FA7B9D2B9CBAE62359C9":
      _id_11DDD();
      break;
    case "_encstr_A2200CDA13D6CBC897E1A0EBAA93":
      _id_11DE9();
      break;
    case "_encstr_9B2D0A451FCEFB46DF18EA43":
      _id_11DEF();
      break;
    case "_encstr_82670A6D9FF7A9AAD022B0CA":
      _id_11DCB();
      break;
    case "_encstr_93D20D28714743B99070632BAF3944":
      _id_11DD5();
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
      _id_11DD6();
      break;
    case "_encstr_99020BB0027F38974BA78783FF":
      _id_11DCA();
      break;
    case "_encstr_8C340BB60EBE5BD7373A85B1D6":
      _id_11DE0();
      break;
    case "_encstr_AC880C67503EA82A05DD62214CE7":
      _id_11DE5();
      break;
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      _id_11DCF();
      break;
    case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
      _id_11DC6();
      break;
    case "_encstr_8E2D0CDA88B79E8791429C87E593":
      _id_11DC5();
      break;
    case "_encstr_A35F0CF7A1907B67A081BF05B9C8":
      _id_11DED(var_3, var_2);
      break;
    case "_encstr_9B8808AD1CD7E457DC1D":
      _id_11DE8(var_3);
      break;
    case "_encstr_ACF70BABB3814330E4DF603B83":
      _id_11DD9();
      break;
    case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
      _id_11DDA();
      break;
    case "_encstr_A9940CCB60D9B8B3B33AD901B212":
      _id_11DF1();
      break;
    case "_encstr_85D20CA53351B931695A3B560129":
      _id_11DE1();
      break;
    case "_encstr_992B0BABB3814370F29F80B983":
      _id_11DD8();
      break;
    case "_encstr_BD960C6B0ED7CAD61CED395AD5B6":
      _id_11DD1();
      break;
    case "_encstr_96040A5B1CAF0D163926ED9C":
      _id_11DD7();
      break;
    case "_encstr_A6990AD8730FD991BC09859F":
      _id_11DDC();
      break;
    case "_encstr_8B390FDD8B79ED89C6AFA3DB95FB125408":
      _id_11DDB(var_2);
      break;
    case "_encstr_87B60AA0124F68A3DAEBFBFF":
      _id_11DE3();
      break;
    case "_encstr_8AB90FF540070C6FB3CD91321126CA1AC8":
      _id_11DEE();
      break;
    case "_encstr_8C690B68C3BF0D206ED1496BAA":
      _id_11DD2();
      break;
    default:
      break;
  }

  if(level.scripted_spawner_func.size < 1)
    scripts\engine\utility::flag_set("_encstr_BE9D114EEBD323808D9F90A06FB45E616A15CD");
}

_id_121EF(var_0, var_1) {
  if(var_0 == "_encstr_AB5D0960CBB77E40E7D955" || var_0 == "_encstr_8E940C29F87032C3FF82F50F725A") {
    if(isDefined(var_1)) {
      var_2 = scripts\engine\utility::string(var_1);
      var_3 = undefined;

      if(var_0 == "_encstr_8E940C29F87032C3FF82F50F725A")
        var_3 = "_encstr_8AC62F1197BAA9433366E26A289C728A8A399173DBB0AACF6899DA51B36E231572AF01E463B836870E11926AF9C8A70FA0";
      else
        var_3 = "_encstr_B6DC1F5ADD83F5C12DD7767B1BCCC8896537D2B1ACCDB1CA4E9858D81637D8AC19";

      switch (var_2[2]) {
        case "_encstr_A34C02BB":
          var_4 = (692.695, -2043.02, 117.313);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_962D454B7707BE37DABE5B072C1C0B4D95C1A537E8BDD89D939638C09856890B27B9B4B17D6BC10B1C16D4AC86BCC4E45AC8BEDD2BDC478133AC3BABDCE0ACC9ADAF98EA93DC3A";
          var_5[0].script_noteworthy = "_encstr_B64D1A2368014062A72773F73E313C9BF74EB3921E73B078D75E487F";
          var_4 = (692.75, -2092.47, 115.505);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = var_3;
          var_5[0].script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";
          var_5[0].origin = (692.75, -2096.8, 115.505);
          var_4 = (694.5, -2021.58, 134.055);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_9AFF5C2DEE1CD7B9ADBE8316E0C24EC0CAE459CCD8ACC3AFEE2B371DC09865CD2D6359E6D8B2C9375B9DBEBB566E1D6098B20E2DE61D7B1BD9E496E00C13F5E0B00EB09C81591BB0DC2B392758E63BCA7DCDB6ECFA1C851C0B9306BEB346";
          var_4 = (693.772, -2100.09, 137.15);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_97DF602DBB0EBE0B9CEBC2B6D2C6BDD09BACB54BCD2DC9B23246ED3ACA892C27376BEC7DB0B55A8DED6873656E477B1BB6E67BD72CB5D2D8ED436EB23685D8CD5BD9EBB06DA51BDE869B65E6D2B1B29B36CA4EEB9516CD8E18C4BE58B5D21BDBA1B9";
          break;
        case "_encstr_A74C0222":
          var_4 = (692.538, -2032.93, 115.817);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_96CC4BA5BB1CD70BC97D37B186C29C639695B2CD5AC62B9BB12B9CAC3B93D20E3BB2E447B2E647F636ADB1579BA36536C2E6B227C9C273D95695C92BCCB19587FA77B2E6470313D74B93F6B9E6";
          var_5[0].script_noteworthy = "_encstr_B64D1A2368014062A72773F73E313C9BF74EB3921E73B078D75E487F";
          var_4 = (695.223, -2033.98, 156.209);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_A26E2F1C90C3464023A65FC34B3BFFE61B032A7CF8C1A83421B649783392E3C0D12F18626733383B44EC631A6804E71291";
          var_4 = (692.604, -2093.99, 118.358);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_8501354BBBC1D7C2937D33B0C6C1430B6593CA331B950FFAEE596EA36089CA9B2D1BCAB9C695C965D9C92DE0CE5693A3CADC47ED1BDADC";
          var_4 = (693.636, -2101.48, 137.097);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_8EB86DCC2CE969C1EB51073780E1AA22234DC4829D8D920D72697757407B200F1FDEDCBD75353A551B817F5F68937867F7FEA6B2694F229FC60817730B0BEC2A33A2AAAB40FFCAA8EE201F7B2823D4929B0AF2643609C2E431A02F23BAB3AF9A6F333E5A115BBA7B5988272B58704F";
          var_4 = (695.083, -2097.3, 153.988);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_A5BC3A94040ADFCE33F7C3D8096FE51ACB5E33F0B2AF01A7D58F21FA6983A95712EBD1B966DF604040820696A807D3BF3E8C45D0A1832821C5930E1F";
          var_4 = (693.113, -2043.55, 136.183);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);

          foreach(var_7 in var_5) {
            if(var_7.script_parameters == "_encstr_87CB346F27DB31A1285EF67CB0F0E73FF4379FE7E9ADEA9BC88361C7A9F024378FAF1B1F7F4DA25C30ABE48A6BCA47FA0A43D38F6954") {
              var_7.script_parameters = var_3;
              var_7.script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";
              var_7.origin = (693.113, -2048, 133.25);
            }
          }

          break;
        case "_encstr_A14C023B":
          var_4 = (691.32, -2045.88, 120.804);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_ACB93EE2A36259F4D8DE1CC23A18413389C69A73E772A429E8CA28BABEEAD7B282C18803659BA02F556023B7238098D3ADEF2DF6D093DAB34191708522A392F2";
          var_5[0].script_noteworthy = "_encstr_B64D1A2368014062A72773F73E313C9BF74EB3921E73B078D75E487F";
          var_4 = (694, -2111.61, 150.817);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_87463D2C135A51A87027D24A823C57EAC71FDF4ECF700F97278E295AA240A9FB5F3B5F5B73507182ADD08733B66B08F328AF5F8BDA1A4BDDF1677BB963E8EF";
          var_4 = (693.377, -2106.26, 116.755);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);

          if(var_5.size != 0)
            var_5[0].script_parameters = "_encstr_8BC13D098FA2B1EF569E6AB3A0256B32B0ABEAC33B10C5AFE8F162BB2BA71E3C88E33C154DA88F3306AE7AA39055DBA260FBFAD3E7C8D403CC8143DBDB36F7";

          var_4 = (692.996, -2042.65, 136.554);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);

          if(var_5.size != 0)
            var_5[0].script_parameters = "_encstr_AC0638636F3718D8AD11C3B88484886A1A97F7F7370ADF18ECA2E3B82A7948F5820F6B2553D294B107CFD36B02093A3C9B4FF9A5EF8BE5903AA5";

          var_4 = (684, -2118, 105);
          var_9 = (2, 124, 90);
          var_7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4);
          var_7.angles = var_9;
          var_7.targetname = "_encstr_811F0DF09B396191B1E3859F3AEACD";
          var_7.script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";
          var_7.script_parameters = var_3;
          break;
        case "_encstr_AC4C024A":
          var_4 = (691.56, -2034.7, 120.85);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_8210508AE42A6F1B4E09C8D11868BB577B92D38AA02F017FCC95035C2F6AB84B4C8A5D48B7CA5B91F8F308332B4B181F83F21F6112CF6029CB5CA20512AA16F3186EE170A8BF93A07762F3FFE028ABE9FA7B";
          var_5[0].script_noteworthy = "_encstr_B64D1A2368014062A72773F73E313C9BF74EB3921E73B078D75E487F";
          var_4 = (692.145, -2107.21, 118.634);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = var_3;
          var_5[0].script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";
          var_5[0].origin = (692.145, -2111.5, 118.35);
          var_4 = (693.044, -2045.93, 135.554);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_BA6659A28841F9E7E8B0797C3FF077ABB9929ABA086F6CDF030D7F69D9DB1BC6EBE2F6134839E72319FD5A73E0A34B81EB98CB1A60530A7E93D3438C0808D79203105707295355CBC8CF0DC03233C31DBF701A7930318AE3C10D70";
          break;
        case "_encstr_B84C027E":
          var_4 = (691.239, -2086.17, 117.865);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_95EB3C634B3A8F5BB3C7DF11B7D327080F0BE0D380F6029F99B72BCA4002D894E33F05EB1696E5AEF1A7796870531DC1FA9209C8BA62E83F3F4EDA5B0331";
          break;
        case "_encstr_8F4C026A":
          var_4 = (694.323, -2041.51, 147.329);
          var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
          var_5[0].script_parameters = "_encstr_918B5DA5DD70AFB91A7D1BD0B093369656DC64A659CD4BD859E6C695C9E6A11DB3B9BEC6D085271B9656DC464DAC260BE4DC86ED3947D7D886163936D295CD194D656EE8ED1BD637DBEB36D00B9C36D22B73C8A656990B6E474E591BEDC232";
          var_5[0].origin = (695, -2038, 149.25);
          break;
      }
    }
  }

  if(var_0 == "_encstr_8E940C29F87032C3FF82F50F725A") {
    var_4 = (704, 2712, -37);
    var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
    var_5[0].script_parameters = "_encstr_842E1C52DC42468E99077B8ABDC8EF763A236F2AB3BAC72ED749E14B713F";
    var_4 = (100, 3489.25, -3.25);
    var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
    var_5[0].script_parameters = "_encstr_84201CB4BB07D7D8B5F51CB62D1BDB59C616379527E4B09B7656FA4C2C9C";
    var_4 = (-610, 2547.75, 19.25);
    var_5 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", var_4, 1);
    var_5[0].script_parameters = "_encstr_97351E2963885FC9C2F9813720A1BAED372A8C6667E58B90C1CD59510132A236";
  }
}

_id_11D7E(var_0, var_1) {
  while(!isDefined(level.player))
    wait 0.05;

  while(!isalive(level.player))
    wait 0.05;

  wait 1;

  if(var_0 == "_encstr_AB5D0960CBB77E40E7D955" || var_0 == "_encstr_8E940C29F87032C3FF82F50F725A") {
    var_2 = undefined;
    var_3 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

    foreach(var_5 in var_3) {
      if(var_5.model == "_encstr_B6751D6C3DFB5ADFBEFAC0814215514E73A1F9EC917F5BF927A120F0FAEC09")
        var_2 = var_5;
    }

    if(isDefined(var_2)) {
      var_7 = var_2 getlinkedchildren();
      var_2 delete();
      scripts\engine\utility::array_delete(var_7);
      var_8 = getentarrayinradius("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009", (-38.8918, 3264, -43), 1);
      var_8[0] delete();
    }

    var_9 = scripts\engine\utility::getStructArray("_encstr_8F1B0ECD900917C027088B92C0AD3F93", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 = (912, 1664, 272);
    var_11 = scripts\engine\utility::getclosest(var_10, var_9, 50);
    var_11.origin = (933, 1701, 272);
    var_12 = (-496, 352, 144);
    var_13 = (-464, 360, 144);
    var_14 = getnodesinradius(var_12, 5, 0, 50, "_encstr_B68E06D8F6B3CA27");
    var_15 = spawncovernode(var_13, var_14[0].angles, "_encstr_AFFF0C6E8FE899DDE6174B068510");
    var_14[0] disconnectnode();
  }
}

trial_chevron_init() {
  var_0 = getDvar("_encstr_9570084B1793A090CDFF");
  level.trial_chevron_vfx = loadfx("_encstr_AF3C262C3EE04AAE874D286ABB132E9B80630782C0C87BA99283818E44404457AF23C9A3AAD62932");
  var_1 = [];
  var_2 = getEntArray("_encstr_869311ED4A4213409763384927C839655BB568", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = scripts\engine\utility::array_combine(var_1, var_2);

  switch (var_0) {
    case "_encstr_AB5D0960CBB77E40E7D955":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (448, -1998, 75));
      var_3[0].angles = (0, 90, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (552, -1998, 75));
      var_3[1].angles = (0, 90, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (598, -1888, 75));
      var_3[2].angles = (0, 180, 0);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (402, -1888, 75));
      var_3[3].angles = (0, 0, 0);
      break;
    case "_encstr_8E940C29F87032C3FF82F50F725A":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (448, -1998, 75));
      var_3[0].angles = (0, 90, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (552, -1998, 75));
      var_3[1].angles = (0, 90, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (598, -1888, 75));
      var_3[2].angles = (0, 180, 0);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (402, -1888, 75));
      var_3[3].angles = (0, 0, 0);
      break;
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 328, 256));
      var_3[0].angles = (0, 0, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 360, 256));
      var_3[1].angles = (0, 0, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 392, 256));
      var_3[2].angles = (0, 0, 0);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2688, 400, 256));
      var_3[3].angles = (0, 270, 0);
      var_3[4] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2720, 400, 256));
      var_3[4].angles = (0, 270, 0);
      var_3[5] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2752, 400, 256));
      var_3[5].angles = (0, 270, 0);
      var_3[6] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 392, 256));
      var_3[6].angles = (0, 180, 0);
      var_3[7] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 360, 256));
      var_3[7].angles = (0, 180, 0);
      var_3[8] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 328, 256));
      var_3[8].angles = (0, 180, 0);
      break;
    case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 328, 256));
      var_3[0].angles = (0, 0, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 360, 256));
      var_3[1].angles = (0, 0, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2658, 392, 256));
      var_3[2].angles = (0, 0, 0);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2688, 400, 256));
      var_3[3].angles = (0, 270, 0);
      var_3[4] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2720, 400, 256));
      var_3[4].angles = (0, 270, 0);
      var_3[5] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2752, 400, 256));
      var_3[5].angles = (0, 270, 0);
      var_3[6] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 392, 256));
      var_3[6].angles = (0, 180, 0);
      var_3[7] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 360, 256));
      var_3[7].angles = (0, 180, 0);
      var_3[8] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (2782, 328, 256));
      var_3[8].angles = (0, 180, 0);
      break;
    case "_encstr_99020BB0027F38974BA78783FF":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1934, -1264, -23));
      var_3[0].angles = (0, 270, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1870, -1264, -16));
      var_3[1].angles = (0, 270, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-2000, -1292, -24));
      var_3[2].angles = (180, 180, 180);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-2000, -1342, -24));
      var_3[3].angles = (180, 180, 180);
      var_3[4] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-2000, -1388, -26));
      var_3[4].angles = (180, 180, 180);
      var_3[5] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-2000, -1438, -22));
      var_3[5].angles = (180, 180, 180);
      var_3[6] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1870, -1462, -16));
      var_3[6].angles = (0, 90, 0);
      var_3[7] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1934, -1462, -16));
      var_3[7].angles = (0, 90, 0);
      break;
    case "_encstr_A9940CCB60D9B8B3B33AD901B212":
      var_3 = [];
      var_3[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1208, -2061, 422));
      var_3[0].angles = (0, 0, 0);
      var_3[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1208, -2103, 417));
      var_3[1].angles = (0, 0, 0);
      var_3[2] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1208, -2141, 412));
      var_3[2].angles = (0, 0, 0);
      var_3[3] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1183, -2159, 406));
      var_3[3].angles = (0, 90, 0);
      var_3[4] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1131, -2159, 406));
      var_3[4].angles = (0, 90, 0);
      var_3[5] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1085, -2159, 406));
      var_3[5].angles = (0, 90, 0);
      var_3[6] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1047.5, -2159, 421.5));
      var_3[6].angles = (0, 90, 0);
      var_3[7] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1029, -2072.5, 424.5));
      var_3[7].angles = (0, 180, 0);
      var_3[8] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1029, -2106.5, 424.5));
      var_3[8].angles = (0, 180, 0);
      var_3[9] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1029, -2141, 423));
      var_3[9].angles = (0, 180, 0);
      break;
    default:
      var_3 = [];
      break;
  }

  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_4[var_5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1[var_5].origin);
    var_4[var_5].angles = var_1[var_5].angles;
    var_4[var_5] setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }

  scripts\engine\utility::array_call(var_1, ::delete);
  return var_4;
}

trial_chevron_vfx_action(var_0, var_1) {
  if(var_1 == "_encstr_8BF50833D895F5178868") {
    foreach(var_3 in var_0) {
      waitframe();
      playFXOnTag(level.trial_chevron_vfx, var_3, "_encstr_A2B40B8A283A7DD3254A1D4A27");
    }
  }

  if(var_1 == "_encstr_A51309AB0D5D5A9F28F84B") {
    foreach(var_3 in var_0)
    stopFXOnTag(level.trial_chevron_vfx, var_3, "_encstr_A2B40B8A283A7DD3254A1D4A27");
  }
}

_id_11DDE() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (60, 2140, 26), (0, 180, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-260, 2140, 32));
  var_1.angles = (0, 0, 0);
  var_1.targetname = "_encstr_A6D617A3395A858DFAA9AE3B9D5927E62CD53AFA6CE4161D59";
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  register_create_script_arrays("_encstr_9573193893EF39715AF0B3BB0C89487EAF3A93A109276650F4E869", "_encstr_8EB811CDAF274AFFCB28272FE026ACC3234F15", _encstr_A58838937A8AAFFA40E25F3307387838F8268E884090B84F30578F521C6720B887AD310F08D1354957A342B53FD3C2E670FF321480FDB5675BFF::main);
}

_id_11DCC() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AFDD05A6AB763B") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-728, 588, 460), (0, 320, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-532, 424, 460));
    var_1.angles = (0, 320, 0);
    var_1.targetname = "_encstr_A6D617A3395A858DFAA9AE3B9D5927E62CD53AFA6CE4161D59";
  } else if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AC1F058B9EABE0") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (1118, -4101, 328), (9, 153, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    register_create_script_arrays("_encstr_A3DE1A1BB069980537EAEA70721FD068FA3D8BD14DC1985E1352A31B", "_encstr_851E1212407FA72F999DD2CFA021FF6B8D105AFA", _encstr_A9703A9B2E8AB0C743C74FC3E3DE8148208288D092FF9075CA63FDFF8302F8E0D81169A97E2CB838524FBFEF9B2A177065F933E12299A06D6E5F1FF7::main);

    if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_9B720BE3D59B3A44E8B00A5469") {
      level._id_13D5B = 1;
      level._id_13D3A = "_encstr_AB4112F465C8DE3B33389B32C1185315E001996F";
      return;
    }

    var_2 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_4 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = [];
    var_6 = [];
    var_7 = [];
    var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-279, -1940, 224));
    var_5[0].angles = (0, 350, 0);
    var_5[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1075, -2018, 265));
    var_5[1].angles = (0, 26, 0);
    var_5[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1102, -1878, 271));
    var_5[2].angles = (0, 9, 0);
    var_5[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1086, -1743, 271));
    var_5[3].angles = (0, 351, 0);
    var_5[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1266, 1816, 322));
    var_5[4].angles = (0, 0, 0);
    var_5[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-530, 2909, 185));
    var_5[5].angles = (0, 0, 0);
    var_5[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-393, 2906, 182));
    var_5[6].angles = (0, 353, 0);
    var_5[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-265, 2861, 186));
    var_5[7].angles = (0, 334, 0);
    var_5[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (664, -1922, 192));
    var_5[8].angles = (0, 43, 0);
    var_5[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (847, -2058, 203));
    var_5[9].angles = (0, 343, 0);
    var_5[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1065, -2072, 201));
    var_5[10].angles = (0, 3, 0);
    var_5[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2294, -2189, 174));
    var_5[11].angles = (0, 37, 0);
    var_5[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2356, -2350, 167));
    var_5[12].angles = (0, 0, 0);
    var_5[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2332, -2526, 167));
    var_5[13].angles = (0, 341, 0);
    var_5[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1568, -4350, 131));
    var_5[14].angles = (0, 98, 0);
    var_5[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1354, -4365, 132));
    var_5[15].angles = (0, 84, 0);
    var_5[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1167, -4318, 141));
    var_5[16].angles = (0, 80, 0);

    foreach(var_9 in var_5)
    var_9 clonebrushmodeltoscriptmodel(var_2);

    var_6[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1101, 2090, 327));
    var_6[0].angles = (0, 134, 0);
    var_6[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (975, 2234, 337));
    var_6[1].angles = (3, 225, 0);
    var_6[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (283, 1789, 408));
    var_6[2].angles = (0, 78, 0);
    var_6[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (206, 1789, 406));
    var_6[3].angles = (0, 98, 0);
    var_6[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-100, 1519, 447));
    var_6[4].angles = (0, 268, 0);
    var_6[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-192, 1495, 440));
    var_6[5].angles = (0, 60, 0);
    var_6[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-795, 1391, 451));
    var_6[6].angles = (0, 304, 0);
    var_6[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-837, 1440, 451));
    var_6[7].angles = (0, 304, 0);
    var_6[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-974, 1506, 438));
    var_6[8].angles = (0, 324, 0);
    var_6[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (346, 950, 436));
    var_6[9].angles = (0, 5, 0);
    var_6[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (755, -1325, 331));
    var_6[10].angles = (357, 23, 3);
    var_6[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1587, -3411, 293));
    var_6[11].angles = (0, 356, 0);
    var_6[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1583, -3478, 293));
    var_6[12].angles = (0, 356, 0);
    var_6[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (914, -4208, 283));
    var_6[13].angles = (357, 328, 2);
    var_6[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1047, -1708, 403));
    var_6[14].angles = (356, 345, 2);
    var_6[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-609, -1561, 415));
    var_6[15].angles = (357, 312, 3);
    var_6[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-611, -1501, 416));
    var_6[16].angles = (351, 270, 10);
    var_6[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1836, -1879, 334));
    var_6[17].angles = (352, 43, 1);
    var_6[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1877, -1910, 335));
    var_6[18].angles = (359, 321, 7);

    foreach(var_9 in var_6)
    var_9 clonebrushmodeltoscriptmodel(var_3);

    var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1153, -1966, 413));
    var_7[0].angles = (359, 2, -5);
    var_7[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1155, -1935, 411));
    var_7[1].angles = (359, 2, -5);
    var_7[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1159, -1869, 405));
    var_7[2].angles = (360, 3, 4);
    var_7[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1161, -1838, 408));
    var_7[3].angles = (360, 3, 4);
    var_7[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1166, -1780, 409));
    var_7[4].angles = (360, 3, 6);
    var_7[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1168, -1749, 413));
    var_7[5].angles = (360, 3, 6);
    var_7[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1098, 1659, 433));
    var_7[6].angles = (360, 22, -4);
    var_7[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1111, 1689, 431));
    var_7[7].angles = (360, 22, -4);
    var_7[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1131, 1747, 431));
    var_7[8].angles = (0, 18, 3);
    var_7[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1141, 1778, 433));
    var_7[9].angles = (0, 18, 3);
    var_7[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1154, 1837, 430));
    var_7[10].angles = (0, 12, 3);
    var_7[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1161, 1869, 432));
    var_7[11].angles = (0, 12, 3);
    var_7[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-526, 2859, 324));
    var_7[12].angles = (358, 86, 3);
    var_7[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-494, 2856, 322));
    var_7[13].angles = (358, 86, 3);
    var_7[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-436, 2855, 321));
    var_7[14].angles = (3, 82, 2);
    var_7[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-404, 2850, 320));
    var_7[15].angles = (3, 82, 2);
    var_7[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-351, 2840, 323));
    var_7[16].angles = (3, 72, -2);
    var_7[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-320, 2830, 324));
    var_7[17].angles = (3, 72, -2);
    var_7[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-267, 2805, 331));
    var_7[18].angles = (360, 65, 1);
    var_7[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-237, 2791, 330));
    var_7[19].angles = (360, 65, 1);
    var_7[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (685, -1761, 333));
    var_7[20].angles = (357, 16, 7);
    var_7[21] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (694, -1791, 329));
    var_7[21].angles = (357, 16, 7);
    var_7[22] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (733, -1885, 328));
    var_7[22].angles = (0, 33, -8);
    var_7[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (750, -1911, 333));
    var_7[23].angles = (0, 33, -8);
    var_7[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (834, -2002, 346));
    var_7[24].angles = (4, 59, -4);
    var_7[25] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (861, -2019, 348));
    var_7[25].angles = (4, 59, -4);
    var_7[26] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1572, -4302, 272));
    var_7[26].angles = (0, 280, -1);
    var_7[27] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1541, -4308, 272));
    var_7[27].angles = (0, 280, -1);
    var_7[28] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1441, -4328, 276));
    var_7[28].angles = (360, 274, -1);
    var_7[29] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1410, -4331, 276));
    var_7[29].angles = (360, 274, -1);
    var_7[30] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1305, -4315, 282));
    var_7[30].angles = (360, 254, -3);
    var_7[31] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1275, -4306, 283));
    var_7[31].angles = (360, 254, -3);
    var_7[32] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1179, -4270, 290));
    var_7[32].angles = (358, 238, 1);
    var_7[33] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1152, -4254, 290));
    var_7[33].angles = (358, 238, 1);

    foreach(var_9 in var_7)
    var_9 clonebrushmodeltoscriptmodel(var_4);
  }
}

_id_11DE9() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-654.833, 1994.12, 15.9902), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-278.833, 1994.12, 15.9902));
  var_1.angles = (0, 0, 0);
  var_1.targetname = "_encstr_A6D617A3395A858DFAA9AE3B9D5927E62CD53AFA6CE4161D59";
}

_id_11DDF() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_0.targetname = "_encstr_81F20CA34DEDEF635F1296D1C755";
  var_0.target = "_encstr_BDBB0616C6C186C2";
  var_0.script_noteworthy = "_encstr_99AD06D3A5B1538B";
  var_0 thread pavelow_boss_health_bar(::_id_11DEA);
  var_1 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-892, 5, 16), (0, 43.1957, 0));
  scripts\mp\spawnlogic::bdiedonce([var_1]);
  init_nuke_vault((-739.378, 167.847, 66.9861), (285.714, 315.5, -46.9039), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_8F753904B39A0792F9F7F39FEB979F265ABBBF4F4898D85AC3BDEF9EDD4FC3BBE860F253488881F3A5A7E3B7E563ABB0C2402A9C18485ECA757596");
  init_nuke_vault((-738.471, 187.473, 63.2056), (38.4734, 89.4932, -0.965993), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_84B942D2BB70BE38A5D79DDED833468995998537E8399563ED8519958E39D2D936EA371D06CCCA36C26E5627C916CDCEB2B2373AB78DD68D57CD47CA875B1676CDD8393B");
  init_nuke_vault((-739.5, 188.25, 54.5), (18.2161, 89.5772, -0.784029), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_97FA39A5BB07FA83D2FAE00BC1B0CC230CCA66B0DC3A932B36DE1632AC47394BD9D857DC8E0366B2B116E6CAE439B0DCB3CA56F05BB0CE6E36C93B");
  init_nuke_vault((-740.8, 75.613, 65.6452), (296.215, 48.4494, 45.8564), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_AC6B3B206B57D7EAF11F529A4977DFD0749A2A9321D3B1A6BB4AAF78C967F7ABA827D873FF4F8350512423EE87D2E3A37F03A34020CA507B575338D528");
  init_nuke_vault((-740.187, 103.475, 69.1132), (284.965, 342.911, -72.7181), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_B4492E31B79A89E75E86624BA83D533AB8A3E2CB17A0CDA78A3BDE83B00E033568E73A01692A425E261143BBB868C32B");
  init_nuke_vault((-740.294, 116.337, 71.5601), (292.978, 47.6906, 43.0764), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_AD9A3BA5EEE0F59B737D5B5A6DCA898659C658B959E4C4C28DB037B1B246AC385A6ED1DEC6D9C92D83188DAC0FADB0EC6E8D4E76954C1639DC34ED271D");
  init_nuke_vault((-739.47, 86.873, 69.4761), (282.94, 337.806, -67.6405), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_A1D72CD2EE07BE2C39AFCC16B1965B2CB29B47B7D86D73BD9583966EE8B7D876C9B4C18119592616933743ED4EE8");
  init_nuke_vault((-737.721, 189.723, 75.7056), (10.9774, 89.6008, -0.726613), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_8B96405A770ED71C5ABE360E0B0E16953358CDD1935663BDB019CA8E9C2DCE8D5D37A3AC1B161BC6BA9B4719B2E0D2CDE8F6639DC9A51C038C5913B04E9B86F639A3");
  init_nuke_vault((-741.622, 154.403, 67.7361), (282.486, 61.4191, 28.8511), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_9BE23D7B7797168932FFAD18F3C5D42601F1F71342E56DE80F41EF37FB8DB713089F63CC4A4DFFC98F836A883BB63737C9553098A333C80250BCD0C05D030C");
  init_nuke_vault((615.378, -154.847, 52.986), (277.284, 38.6086, 9.38197), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_99D42EC97B732996C3DFD8D18A9A5D4630503CC937537DBA2220D8266B3BF2F28055E7EF094363E3AFA2076349386F2A");
  init_nuke_vault((-353.3, 626.613, 52.3952), (0.706816, 90.4638, 3.21603), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_AC6B3B206B57D7EAF11F529A4977DFD0749A2A9321D3B1A6BB4AAF78C967F7ABA827D873FF4F8350512423EE87D2E3A37F03A34020CA507B575338D528");
  init_nuke_vault((-209.47, 372.373, 49.7261), (272.789, 302.444, -32.1599), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_A96046D2BBC1F5B0C9AF37B1A1B093B1B4AC95CC0B6EE8E4AC8DDE0B23561B586E952798B063589BB1958C65CDD1F61BDA365607D2B91DED633BC9A50E60C8592685E49B1AF627E8");
  init_nuke_vault((-253.687, -265.525, 17.8632), (359.286, 238.951, -92.3844), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_B4492E31B79A89E75E86624BA83D533AB8A3E2CB17A0CDA78A3BDE83B00E033568E73A01692A425E261143BBB868C32B");
  init_nuke_vault((-721.294, 136.337, 56.5601), (286.817, 86.2294, 2.34117), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_BA6740A28841F9E7E8B06B72B573772C1BD04ADA0ADFEFE7230D526DD9383F87D76352132805261FF8FF466365212E8AC180FA2A286F1A77F35D5F940CCBEF12B102");
  init_nuke_vault((-720.471, 129.723, 55.9556), (10.9774, 89.6008, -0.726613), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_A28D424BEE0E7DC1B4FAB1C185E0B0956685E63AC92B8DBDC246CA1DE4A59D1BAB9B1DACD80BDC2BE427C2DC3BCAB2835ACDA3B78D3B9C96078164B289169C6E34DE931D");
  init_nuke_vault((495.597, 512.911, 59.2126), (278.32, 353.274, 4.7039), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_AFFF42E4979ADEDFB5962F4246B0B0E226BAD9332DB6BD064007184B37D9645B2B67B2E270D0AA9833CAE8751409D377BB728D36501858A72582515730799D7B734243E4");
  register_create_script_arrays("_encstr_B4F61D68DA97A060E31B2B2363DAB7704CF9510307112025590F1F15AF2305", "_encstr_8FDD153848F1ED5757BF58CF8A960FAC7907CD7A5B6B8B", _encstr_A907406BDF8844E31D43C6EA4BD8EF3EF067BFCD51398D97461B7A12D14617B5A8B76558F76B597FEF51720A392F7BEDD997F2D523B01F0716893BC283FDBAE7E07F::main);
}

_id_11DE7(var_0, var_1, var_2) {
  if(var_0 == "_encstr_8E95062EE46DB683") {
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (2731, 727.75, 253), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_3]);
    init_nuke_vault((3023.75, -289.25, 125.75), (0, 270, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    init_nuke_vault((2587, 611, 305), (360, 270, 0), "_encstr_8BD3162CBD1006D3C8A3625BA83F23BB4903A39333A80DFB", undefined, "_encstr_8FAB21C97038B9900A0FCD1727BD9CCAAD2038EBE8E8792FED5322BF52ABD1639FC538");
    init_nuke_vault((2587.5, 613, 322), (0, 270, 0), "_encstr_8BD3162CBD1006D3C8A3625BA83F23BB4903A39333A80DFB", undefined, "_encstr_ABC425D277E0FA589CBEB0B92DCAC99C16892395B62DCDD2C9B232467B1D56D939A538CEB2398E");
    init_nuke_vault((2586.75, 549.25, 308), (0, 270, 0), "_encstr_8BD3162CBD1006D3C8A3625BA83F23BB4903A39333A80DFB", undefined, "_encstr_A1E648BB8CDA89418851C187D609E5AA62C2FAB4DBCCD69961254F04CF84BAEDD8967AC3635ADC8D7D43832F93CD8F38297FEBA27D3AB73AA6BE1A1B23C39398D0B5B07BE10837AFCE1A");
    init_nuke_vault((2585.75, 553, 323), (0, 270, 0), "_encstr_8BD3162CBD1006D3C8A3625BA83F23BB4903A39333A80DFB", undefined, "_encstr_ADF652B454810199B3F9C79F580942FA9BE5ACEA35556AA5DA11979FA8C35897F70684E5AD9D52EDE32927B7D0FB90DFAF94CADC8F054A220BE23FFB18F1B323EF361614FF751271F1FA5BB7E069627B6BC09FCF");
    init_nuke_vault((2587, 550, 325.75), (360, 270, 0), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_B8E12DB4DDE0D7C6D6AFB5CEDBB166991BB29BE8BD1BD6C6653616B11BEADC4795EC9C4B1C2CCDB395C416C9B6A523");
    init_nuke_vault((2586, 558, 305), (0, 270, 0), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_B4CA2B535F0728E8FD41304975D4F0569F461FDBAB7A08480DE2F0A29D81C0AE8693A3776322C120323C83B392");
    init_nuke_vault((2587.5, 618, 322), (360, 270, 5.48232), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_B19A36980FE8261112698F1AFC5A4FE019E72070474D39E7ABDA273252E281914E8FC8502BE1D0FBF23675ADBC3AC5D8B84340A8DBA8EBAF");
    init_nuke_vault((2588, 621, 305), (0, 270, 0), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_8F6330F0CBB07F487F8F626B844FDB6D5A96A808923FA5E137CAF9516767DB9BB2CB2A425E96E35BC7C4685A71F380FB4AE7");
    init_nuke_vault((2586.6, 611.86, 312.064), (359, 270, -0.000128963), "_encstr_AA2A148B9A610B39E1C3E3CD972A70F03FF5506184C4", undefined, "_encstr_87C22ED277E0FAE04BD7C10BE0B0CCC80CB26E4BD859CDC6CA93AC9958E6D14ECAC6ED2C2356632CE6953993C29BB395");
    level._id_12489 = "_encstr_8BBB0B9D41E718D9E922D8582A";
    level._id_1248B = "_encstr_BD170C5B689B786221E98009A80C";
    level._id_1248A = 1;
    thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
    register_create_script_arrays("_encstr_A17418C21BB8D34350F5554AFF50CAF7DFF3DA69C30E1BBC78F9", "_encstr_A17418C21BB8D34350F5554AFF50CAF7DFF3DA69C30E1BBC78F9", _encstr_A6AC36C2970AFF57537F3E5F7B062518FB578587E0119B9D526D653242CD89879BB510586F2E58571A5829A81D193A719B4118FCCEB7CBE0::main);

    if(var_1 == 323) {
      level._id_124C9 = 1;
      return;
    }
  } else if(var_0 == "_encstr_83AD0559672E3A") {
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (1472, -1121, 311), (0, 53.5, 0));
    scripts\mp\spawnlogic::bdiedonce([var_3]);
    var_4 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_5 = [];
    var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-390, 25, 256));
    var_5[0].angles = (0, 0, 0);
    var_5[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-342, 25, 256));
    var_5[1].angles = (0, 0, 0);
    var_5[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-938, -207, 168));
    var_5[2].angles = (0, 342, 0);
    var_5[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-954, -257, 168));
    var_5[3].angles = (0, 342, 0);
    var_5[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-916, -427, 174));
    var_5[4].angles = (0, 0, 0);
    var_5[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1006, -563, 171));
    var_5[5].angles = (8.5, 84, -2.4);
    var_5[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1209, -591, 168));
    var_5[6].angles = (0, 326, 0);
    var_5[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1704, -765, 168));
    var_5[7].angles = (0, 0, 0);
    var_5[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2180, -801, 168));
    var_5[10].angles = (0, 0, 0);
    var_5[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2365, -804, 168));
    var_5[11].angles = (0, 0, 0);
    var_5[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2365, -804, 168));
    var_5[12].angles = (0, 330, 0);
    var_5[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2530, -747, 168));
    var_5[13].angles = (0, 330, 0);
    var_5[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2629, -598, 168));
    var_5[14].angles = (0, 270, 0);
    var_5[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2650, -412, 170));
    var_5[15].angles = (0, 270, 0);
    var_5["_encstr_91170BD14EAE36D6C185C9D14C"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1620.21, -958.617, 236));
    var_5["_encstr_91170BD14EAE36D6C185C9D14C"].angles = (0, 230, 0);
    var_5["_encstr_93170B1BB3473ED09AE19D995A"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1583.66, -927.504, 236));
    var_5["_encstr_93170B1BB3473ED09AE19D995A"].angles = (0, 230, 0);

    foreach(var_7 in var_5)
    var_7 clonebrushmodeltoscriptmodel(var_4);

    var_9 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 = [];
    var_10[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1542.18, -976.239, 236));
    var_10[0].angles = (0, 230, 0);
    var_10[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1578.73, -1007.35, 236));
    var_10[1].angles = (0, 230, 0);
    var_10[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1500.69, -1024.97, 236));
    var_10[2].angles = (0, 230, 0);
    var_10[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1537.24, -1056.09, 236));
    var_10[3].angles = (0, 230, 0);
    var_10[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1459.21, -1073.71, 236));
    var_10[4].angles = (0, 230, 0);
    var_10[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1495.76, -1104.82, 236));
    var_10[5].angles = (0, 230, 0);
    var_10[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1423.82, -1127.63, 236));
    var_10[6].angles = (0, 230, 0);
    var_10[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1460.37, -1158.74, 236));
    var_10[7].angles = (0, 230, 0);
    var_10[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1403.07, -1152, 256));
    var_10[8].angles = (0, 230, 0);
    var_10[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1427.44, -1172.74, 256));
    var_10[9].angles = (0, 230, 0);
    var_10[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1403.07, -1152, 320));
    var_10[10].angles = (0, 230, 0);
    var_10[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1427.44, -1172.74, 320));
    var_10[11].angles = (0, 230, 0);

    foreach(var_7 in var_10)
    var_7 clonebrushmodeltoscriptmodel(var_9);

    var_13 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_14 = [];
    var_14[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1508.34, -978.958, 324));
    var_14[0].angles = (0, 230, 90);
    var_14[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1425.38, -1076.43, 324));
    var_14[1].angles = (0, 230, 90);
    var_14[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1504.57, -1143.84, 324));
    var_14[2].angles = (0, 230, 90);
    var_14[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1587.54, -1046.37, 324));
    var_14[3].angles = (0, 230, 90);

    foreach(var_7 in var_14)
    var_7 clonebrushmodeltoscriptmodel(var_13);

    var_17 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_18 = [];
    var_18[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1422.72, -1116.44, 380));
    var_18[0].angles = (0, 230, 0);
    var_18[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1459.28, -1147.56, 380));
    var_18[1].angles = (0, 230, 0);
    var_18[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1500.94, -1098.73, 380));
    var_18[2].angles = (0, 230, 0);
    var_18[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1464.39, -1067.62, 380));
    var_18[3].angles = (0, 230, 0);
    var_18[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1542.43, -1049.99, 380));
    var_18[4].angles = (0, 230, 0);
    var_18[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1505.88, -1018.88, 380));
    var_18[5].angles = (0, 230, 0);
    var_18[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1583.91, -1001.26, 380));
    var_18[6].angles = (0, 230, 0);
    var_18[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1547.36, -970.147, 380));
    var_18[7].angles = (0, 230, 0);
    var_18[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1584.21, -926.617, 300));
    var_18[8].angles = (14, 230, 0);
    var_18[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1622.21, -958.617, 300));
    var_18[9].angles = (14, 230, 0);

    foreach(var_7 in var_18)
    var_7 clonebrushmodeltoscriptmodel(var_17);

    var_21 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1607.7, -979.485, 340));
    var_21.angles = (90, 230, 0);
    var_21.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
    var_21 clonebrushmodeltoscriptmodel(var_17);
    var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1565.06, -943.187, 340));
    var_22.angles = (90, 230, 0);
    var_22.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
    var_22 clonebrushmodeltoscriptmodel(var_17);
    var_23 = (0, 0, 0);
    var_24 = (0, 0, 0);
    var_25 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_23);
    var_25.angles = var_24;
    var_25.targetname = "_encstr_811F0DF09B396191B1E3859F3AEACD";
    var_25.script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";

    if(var_2 == "_encstr_A59306426009CA07")
      var_25.script_parameters = "_encstr_87610AB4EE83FAD6374B3395";
    else {
      var_25.script_parameters = "_encstr_8BE20ED75722A6731BF84F3064CA126B";
      level._id_13D93 = 1;
    }

    register_create_script_arrays("_encstr_AF481B6B83D7E45DE6B9AC937D385BFA8DE4562C1D2B7DDC6C9CB4078E", "_encstr_B2781C72DBE17A554DB2AD66C943A5A17112A95EED2FBAFBF3133CF733C0", _encstr_A6493C43F642780F7B8F178B9B96D970F84A4018DA877845F2938BBD0F8B11BA8DE2F67303EED075CB6FD9BBF782E620597B392E2A4BC83BC32B6DA76FEA::main);
  }
}

_id_11DC4() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2144, -1263, 312), (0, 7, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  register_create_script_arrays("_encstr_85C91831F8F7A14DCC0BA8E841662D7967844DA053BF0B8B72C3", "_encstr_BA8C10D6E0AF2CDC5ACBB034D7A39CD22C8D", _encstr_A9EB36D2368BD038C47247EBD89F60AF03A37F08C97F9F96B8D8128A40605B39F8A577DB763B2FC77B2F0FAD70A7D321256372D3A224CB37::main);
  var_1 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-191, -1785, 116));
  var_2[0].angles = (0, 146, 0);
  var_2[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-70, -1630, 116));
  var_2[1].angles = (0, 161, 0);
  var_2[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-38, -1443, 116));
  var_2[2].angles = (0, 180, 0);
  var_2[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3688, 1959, 199));
  var_2[3].angles = (0, 199, 0);
  var_2[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3601, 2100, 199));
  var_2[4].angles = (0, 242, 0);
  var_2[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3424, 2198, 199));
  var_2[5].angles = (0, 242, 0);
  var_2[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (231, 593, 116));
  var_2[6].angles = (0, 29, 0);
  var_2[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (90, 494, 116));
  var_2[7].angles = (0, 12, 0);
  var_2[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-70, 445, 116));
  var_2[8].angles = (0, 0, 0);
  var_2[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3690, 563, 116));
  var_2[9].angles = (0, 13, 0);
  var_2[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3901, 492, 116));
  var_2[10].angles = (0, 42, 0);
  var_2[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4064, 356, 116));
  var_2[11].angles = (0, 71, 0);
  var_2[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4110, 125, 116));
  var_2[12].angles = (0, 81, 0);
  var_2[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4170, -201, 116));
  var_2[13].angles = (0, 81, 0);
  var_2[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4164, -522, 116));
  var_2[14].angles = (0, 113, 0);
  var_2[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4129, -718, 116));
  var_2[15].angles = (0, 113, 0);
  var_2[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-4026, -890, 116));
  var_2[16].angles = (0, 133, 0);
  var_2[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3854, -1058, 116));
  var_2[17].angles = (0, 156, 0);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);
}

_id_11DE6() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AC1F058B9EABE0") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2700, 748, 271), (0, 70, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  } else if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_850707F7E5833355B8") {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-155, 3420, 521), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    init_nuke_vault((-176, 3172, 532), (315, 270, 0), undefined, "_encstr_8D360838D3CB51A8EEEF", "_encstr_AFC687FA83730FAA083FEBE247387233703B56E2A8A197E9488DEFEB57D83DDF8A117BAAF38567DED1970ACF2F6886F7CCC0B2125B5D539760E711CCB720CA37F7E67AAB20B69F0EA0CF43C2335859571E98F32329B7D79428E10FDBC7F011AF46300BABB1E81FEC901B2BB4CF8825AB65AE820378BEB77618377BBF93286F0380C10B5A4316BB6D80");
    level._id_13D8F = 1;
    level.showdebugresult = 10000;
    level._id_13D94 = 1;
    level._id_13D95 = 3;
  }

  register_create_script_arrays("_encstr_88EF16AD0E7DE4B09632F5B1C9B2C2E8CA7DCDD839B41C47", "_encstr_AC6E0B78FA363B1E2B72B3BF74", _encstr_978F321B30CD7CE393AE3F65C7105F8631584672103FF2DF681D376DDF267BCEAB78C92A6813EE43C1E8539BF688BB537DC8F3A2::main);
}

_id_11DD4() {
  var_0 = [];
  var_1 = [];

  switch (level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"]) {
    case "_encstr_850707F7E5833355B8":
      var_2 = spawnStruct();
      var_2.origin = (193, -12, 23);
      var_2.angles = (0, 330, 0);
      register_create_script_arrays("_encstr_85F11B298269533BE02B1070A30D33EF72AA95A71BA25FA3DB6BC0F08B", "_encstr_85F11B298269533BE02B1070A30D33EF72AA95A71BA25FA3DB6BC0F08B", _maphint_computerscriptableused::main);
      init_nuke_vault((428, -176, 38), (278, 360, 90), "_encstr_84331585B267E91119B3D0707AAEDD83675B37F328FF33", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_8D900DB477077D1C2DD736E0C28385");
      init_nuke_vault((428, -176, 38), (278, 360, 90), "_encstr_84331585B267E91119B3D0707AAEDD83675B37F328FF33", "_encstr_8D360838D3CB51A8EEEF", "_encstr_A1412D4BEE70AFCDE6FA3295B1D158B2260B933743EDE43A599D4F37C6DEE0B2AC165B5BEDB6DB467DA5AD382CB18E");
      init_nuke_vault((0, 0, 0), (0, 0, 0), "_encstr_BD0715A13A1C48094753016B8A97305839900327C445E8", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
      init_nuke_vault((480.5, -105.5, 58.5), (17, 90, 6), "_encstr_BD0715A13A1C48094753016B8A97305839900327C445E8", "_encstr_8D360838D3CB51A8EEEF", "_encstr_BA713292B871293BD8408C8566C07F7C41081A0A70B39AE31B1EDBA0098917B2072002D3B06F15F7202E8AB112D1FE7E3FB0EA5F");
      level._id_13D8F = 1;
      thread _id_13A69();
      break;
    case "_encstr_B1FC0EF94B76E128D293E9EBFB1AE7F0":
      var_2 = spawnStruct();
      var_2.origin = (388, 712, 28);
      var_2.angles = (0, 218, 0);
      register_create_script_arrays("_encstr_8B5128D6E0F556EA388627C23AAC6ED7C64EB2B0D159D7DC6C935AC1A3AFECBA9BE6B7CD362DDCCAC24E", "_encstr_8B5128D6E0F556EA388627C23AAC6ED7C64EB2B0D159D7DC6C935AC1A3AFECBA9BE6B7CD362DDCCAC24E", _maphint_keypadscriptableused::main);
      init_nuke_vault((-81.47, 604.373, 47.9761), (358.504, 182.354, 90.2531), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_ABF6432DDDC1AFE04BF58DC10BE01656C6D56E1D37D8DB38CAFAC60E0BC10B65310B93B17B37767DD80E16C116AC0EB4DCD1DE1B9D9CB4E07D07B9D1C6C0D0AF8DE00B3885");
      init_nuke_vault((493.53, -167.877, 54), (358.5, 8, 0), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_915E71586318A731EB7799832BDFD337F66A18F85A251F0E4F79928D6CDEE3411DD258B8B13D5BC047CC8AF6112BA91BC20B81C04AD48BF3D7D50FDAFB7BF3DDAA8288B0226123102FAD974DFF6F7BD7174B18385AC267EE97D5B1EB93DF40117F62F868839EAB40B7F64ED5B496E9C3621A78");
      init_nuke_vault((16.53, -987.627, 47.726), (0, 211, 90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_95D86C28DB30F1B69267E7F9B71B711805A33B2B54D2C8EE2ABFC5FF37524B90CACDD8B9FB6AD20AF35BFBF7AF7906A071A2E0B09737A2FD2E5FE3A7AB835E5018FF0E497CC97819E22F6F2D466E9E38AC5790C1A722B0478A2725973F42E6F86CAF18DE4E905086E22F3B370A7F");
      init_nuke_vault((596.53, -1595.63, 47.7261), (0, 0, -90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_B2CC3D9B605F1EEBC87707DB9BA8E138C66E0E583BE87FD37B7FE89B0D7FF383A643736DE9F3C32F8AECDC7B0382B6F7B87B2BABCA90298379032F94D00607");
      var_0[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-80, 568, 15));
      var_0[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-80, 600, 15));
      var_0[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18, -1016, 15));
      var_0[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (18, -984, 15));
      var_0[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (594, -1624, 15));
      var_0[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (594, -1592, 15));
      var_0[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (499, -177, 15));
      var_0[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (499, -145, 15));
      var_0[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (548, -514, 15));
      var_0[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (548, -482, 15));
      var_0[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (548, -482, 24));
      var_0[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (548, -514, 32));
      var_0[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (524, -514, 32));
      var_0[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (524, -514, 15));
      var_0[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (524, -482, 24));
      var_0[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (524, -482, 15));
      var_0[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-12, -542, 32));
      var_0[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-12, -542, 15));
      var_0[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-12, -510, 24));
      var_0[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-12, -510, 15));
      var_0[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-36, -542, 32));
      var_0[21] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-36, -542, 15));
      var_0[22] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-36, -510, 24));
      var_0[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-36, -510, 15));
      var_0[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (568, -1691, 24));
      var_0[25] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (568, -1691, 15));
      var_0[26] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (568, -1723, 32));
      var_0[27] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (568, -1723, 15));
      var_0[28] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (592, -1691, 24));
      var_0[29] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (592, -1691, 15));
      var_0[30] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (592, -1723, 32));
      var_0[31] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (592, -1723, 15));
      var_0[32] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-55, 699, 24));
      var_0[33] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-55, 699, 15));
      var_0[34] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-55, 667, 32));
      var_0[35] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-55, 667, 15));
      var_0[36] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-79, 699, 24));
      var_0[37] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-79, 699, 15));
      var_0[38] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-79, 667, 32));
      var_0[39] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-79, 667, 15));
      var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (535, -491, 14));
      var_1[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25, -518, 12));
      var_1[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (579, -1699, 12));
      var_1[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-68, 691, 12));
      thread _id_11DD3();
      thread _id_13A69();
      break;
    case "_encstr_AC1F058B9EABE0":
      var_2 = spawnStruct();
      var_2.origin = (2430, -1939, -102);
      var_2.angles = (0, 68, 0);
      init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
      register_create_script_arrays("_encstr_ABBB26B6C1F58E271BF56C9C2B16A3B2FA16EBCD36C94BC18EFA4EB08DACAF565D0ED04EB0E8596E", "_encstr_B1821A903BA77B4FBABBE7E352D25101D3EF1078EF35D6C133A457F9", _purchasemenuclosedbyclient::main);
      var_3 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_4 = [];
      var_4[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-346, -819, -290));
      var_4[0].angles = (0, 37, 0);
      var_4[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1829, -1039, -267));
      var_4[1].angles = (0, 29, 0);
      var_4[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1945, -1113, -248));
      var_4[2].angles = (0, 19, 0);
      var_4[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2006, -1133, -246));
      var_4[3].angles = (0, 19, 0);
      var_4[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2048, -1158, -255));
      var_4[4].angles = (0, 45, 0);
      var_4[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2266, -989, -256));
      var_4[5].angles = (0, 2, 0);
      var_4[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2331, -989, -256));
      var_4[6].angles = (0, 2, 0);
      var_4[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2398, -989, -264));
      var_4[7].angles = (0, 0, 0);
      var_4[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1858, -153, -264));
      var_4[8].angles = (0, 333, 0);
      var_4[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1915, -124, -264));
      var_4[9].angles = (0, 333, 0);
      var_4[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1972, -95, -264));
      var_4[10].angles = (0, 333, 0);
      var_4[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2092, -45, -276));
      var_4[11].angles = (0, 318, 0);
      var_4[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2135, -93, -276));
      var_4[12].angles = (0, 318, 0);
      var_4[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2185, -48, -276));
      var_4[13].angles = (0, 318, 0);
      var_4[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2199, 14, -269));
      var_4[14].angles = (0, 285, 0);
      var_4[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2208, 47, -269));
      var_4[15].angles = (0, 285, 0);
      var_4[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2278, 80, -269));
      var_4[16].angles = (0, 343, 0);
      var_4[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2340, 98, -269));
      var_4[17].angles = (0, 343, 0);
      var_4[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3508, 987, -159));
      var_4[18].angles = (0, 332, 0);
      var_4[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-198, -1276, -283));
      var_4[19].angles = (0, 15, 0);
      var_4[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-214, -1214, -283));
      var_4[20].angles = (0, 15, 0);
      var_4[21] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-220, -1145, -277));
      var_4[21].angles = (0, 356, 0);
      var_4[22] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-216, -1080, -277));
      var_4[22].angles = (0, 356, 0);
      var_4[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1887, -1071, -267));
      var_4[23].angles = (0, 29, 0);
      var_4[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2095, -1203, -253));
      var_4[24].angles = (0, 45, 0);
      var_4[26] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1242, 1102, -231));
      var_4[26].angles = (0, 70, 0);
      var_4[27] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1181, 1080, -231));
      var_4[27].angles = (0, 70, 0);
      var_4[28] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1061, 673, -231));
      var_4[28].angles = (0, 25, 0);
      var_4[29] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1090, 736, -231));
      var_4[29].angles = (0, 25, 0);
      var_4[30] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2501, -631, -248));
      var_4[30].angles = (0, 54.5, 0);
      var_4[31] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2443, -590, -248));
      var_4[31].angles = (0, 54.5, 0);
      var_4[32] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3060, -928, -212));
      var_4[32].angles = (0, 70, 0);
      var_4[33] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3127, -952, -212));
      var_4[33].angles = (0, 70, 0);
      var_4[34] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1563, 1033, -231));
      var_4[34].angles = (0, 340, 0);
      var_4[35] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1539, 1099, -231));
      var_4[35].angles = (0, 340, 0);
      var_4[36] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2441, -809, -291));
      var_4[36].angles = (0, 0, 0);
      var_4[37] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2505, -811, -291));
      var_4[37].angles = (0, 0, 0);
      var_4[38] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2769, -334, -269));
      var_4[38].angles = (0, 307, 0);
      var_4[39] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2509, -289, -281));
      var_4[39].angles = (0, 275, 0);
      var_4[40] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2515, -226, -281));
      var_4[40].angles = (0, 275, 0);
      var_4[41] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2834, -284, -281));
      var_4[41].angles = (0, 322, 0);
      var_4[42] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2884, -246, -281));
      var_4[42].angles = (0, 322, 0);
      var_4[43] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3502, 803, -144));
      var_4[43].angles = (0, 275, 0);
      var_4[44] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-3437, 1054, -158));
      var_4[44].angles = (0, 315, 0);
      var_4[45] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1204, -249, -268));
      var_4[45].angles = (0, 268, 0);
      var_4[46] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2336, 275, -230));
      var_4[46].angles = (0, 268, 0);
      var_4[47] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2343, 339, -230));
      var_4[47].angles = (0, 268, 0);
      var_4[48] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (115, -1789, -247));
      var_4[48].angles = (0, 275, 0);

      foreach(var_6 in var_4)
      var_6 clonebrushmodeltoscriptmodel(var_3);

      var_8 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_9 = [];
      var_9[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1426, -1755, -59));
      var_9[23].angles = (340, 0, 0);
      var_9[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1306, -1755, -102));
      var_9[24].angles = (340, 0, 0);
      var_9[25] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1158, -1755, -149));
      var_9[25].angles = (340, 0, 0);
      var_9[26] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1068, -1755, -182));
      var_9[26].angles = (340, 0, 0);
      var_9[27] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (948, -1755, -226));
      var_9[27].angles = (340, 0, 0);

      foreach(var_6 in var_9)
      var_6 clonebrushmodeltoscriptmodel(var_8);

      break;
    default:
      var_2 = spawnStruct();
      var_2.origin = (0, 0, 0);
      var_2.angles = (0, 0, 0);
      var_12 = [];
      break;
  }

  var_13 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_0)
  var_6 clonebrushmodeltoscriptmodel(var_13);

  var_16 = getEnt("_encstr_8F1213711FAAA5E8CBF638561EBF6855D37FD7FF83", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_6 in var_1)
  var_6 clonebrushmodeltoscriptmodel(var_16);

  var_19 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", var_2.origin, var_2.angles);
  scripts\mp\spawnlogic::bdiedonce([var_19]);
}

_id_11DD3() {
  level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  var_0 = getentitylessscriptablearrayinradius("_encstr_A976322F47EB7B50AC86A960AF5F90A60397A1B9E752B1B0EFDF3018927728ED3B1F61673B0A0848E479D39BF13C5094937FEB81", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = scripts\engine\utility::getclosest((1876, -1397, -56), var_0, 10);
  var_1 constraintoscriptgoalRadius();

  foreach(var_3 in var_0) {}
}

_id_11DE4(var_0) {
  var_1 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2666, 390, 198), (0, 45, 0));
  scripts\mp\spawnlogic::bdiedonce([var_1]);

  if(var_0 == "_encstr_8D940738966ED1DB8D") {
    var_2 = (0, 0, 0);
    var_3 = (0, 0, 0);
    var_4 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_2);
    var_4.angles = var_3;
    var_4.targetname = "_encstr_811F0DF09B396191B1E3859F3AEACD";
    var_4.script_noteworthy = "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A";
    var_4.script_parameters = "_encstr_88FE0D0157202970845121C58E802F";
  }

  var_5 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2510.15, 508.249, 237));
  var_6.angles = (90, 225, 0);
  var_6.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
  var_6 clonebrushmodeltoscriptmodel(var_5);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2549.75, 547.847, 237));
  var_7.angles = (90, 225, 0);
  var_7.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
  var_7 clonebrushmodeltoscriptmodel(var_5);
  var_8 = [];
  var_8[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1657, -514, 253));
  var_8[0].angles = (0, 41, -7.5);
  var_8[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1615.5, -560.25, 261));
  var_8[1].angles = (0, 41, -7.5);
  var_8[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-226.5, 307.5, 242.75));
  var_8[2].angles = (0, 308, 9.5);
  var_8[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-274, 270.25, 231));
  var_8[3].angles = (0, 308, 13);

  foreach(var_10 in var_8)
  var_10 clonebrushmodeltoscriptmodel(var_5);

  var_12 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = [];
  var_13[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1595, 659, 128));
  var_13[0].angles = (0, 348, 0);
  var_13[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1646, 648, 128));
  var_13[1].angles = (0, 348, 0);
  var_13[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2237, 1303, 131));
  var_13[2].angles = (0, 0, 0);
  var_13[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2185, 1303, 131));
  var_13[3].angles = (0, 0, 0);
  var_13[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2231, 1303, 186));
  var_13[4].angles = (0, 0, 0);
  var_13[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1174, 19, 137));
  var_13[5].angles = (0, 330, 0);
  var_13[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1947, 395, 148));
  var_13[6].angles = (0, 348, 0);
  var_13[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2413, 711, 148));
  var_13[7].angles = (0, 354, 0);
  var_13[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1636.75, -111.5, 126.25));
  var_13[8].angles = (0, 0, 0);
  var_13[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1547.5, -898.75, 98.75));
  var_13[9].angles = (0, 45.75, 0);
  var_13[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1512.5, -862.75, 98.75));
  var_13[10].angles = (0, 45.75, 0);
  var_13[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1512.5, -862.75, 153.75));
  var_13[11].angles = (0, 45.75, 0);
  var_13[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-254.25, 285, 127));
  var_13[12].angles = (0, 343, 0);
  var_13[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-254.25, 285, 181.75));
  var_13[13].angles = (0, 301, 0);
  var_13[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-577, 89.5, 127));
  var_13[14].angles = (0, 343, 0);
  var_13[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1093, -408.5, 111));
  var_13[15].angles = (-4, 111, 0);
  var_13[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1112.5, -362.25, 114.25));
  var_13[16].angles = (-4, 111, 0);
  var_13[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1111, -365, 169));
  var_13[17].angles = (-4, 111, 0);

  foreach(var_10 in var_13)
  var_10 clonebrushmodeltoscriptmodel(var_12);

  var_16 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = [];
  var_17[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2705.31, 330.059, 217));
  var_17[0].angles = (0, 225, 0);
  var_17[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2727.94, 352.686, 217));
  var_17[1].angles = (0, 225, 0);
  var_17[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2705.31, 330.059, 153));
  var_17[2].angles = (0, 225, 0);
  var_17[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2727.94, 352.686, 153));
  var_17[3].angles = (0, 225, 0);
  var_17[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2671.37, 341.372, 133));
  var_17[4].angles = (0, 225, 0);
  var_17[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2631.77, 392.284, 133));
  var_17[5].angles = (0, 225, 0);
  var_17[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2586.52, 437.539, 133));
  var_17[6].angles = (0, 225, 0);
  var_17[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2541.26, 482.793, 133));
  var_17[7].angles = (0, 225, 0);
  var_17[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2575.21, 516.734, 133));
  var_17[8].angles = (0, 225, 0);
  var_17[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2620.46, 471.48, 133));
  var_17[9].angles = (0, 225, 0);
  var_17[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2665.72, 426.225, 133));
  var_17[10].angles = (0, 225, 0);
  var_17[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2705.31, 375.314, 133));
  var_17[11].angles = (0, 225, 0);
  var_17[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2496.01, 528.048, 133));
  var_17[12].angles = (0, 225, 0);
  var_17[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2529.95, 561.989, 133));
  var_17[13].angles = (0, 225, 0);

  foreach(var_10 in var_17)
  var_10 clonebrushmodeltoscriptmodel(var_16);

  var_20 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_21 = [];
  var_21[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2609.15, 516.735, 221));
  var_21[0].angles = (0, 230, 90);
  var_21[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2699.66, 426.225, 221));
  var_21[1].angles = (0, 230, 90);
  var_21[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2626.12, 352.686, 221));
  var_21[2].angles = (0, 230, 90);
  var_21[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2535.61, 443.195, 221));
  var_21[3].angles = (0, 230, 90);

  foreach(var_10 in var_21)
  var_10 clonebrushmodeltoscriptmodel(var_20);

  var_24 = [];
  var_24[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2704.97, 386.971, 277));
  var_24[0].angles = (0, 225, 0);
  var_24[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2660.06, 431.882, 277));
  var_24[1].angles = (0, 225, 0);
  var_24[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2614.8, 477.137, 277));
  var_24[2].angles = (0, 225, 0);
  var_24[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2569.55, 522.391, 277));
  var_24[3].angles = (0, 225, 0);
  var_24[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2535.61, 488.45, 277));
  var_24[4].angles = (0, 225, 0);
  var_24[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2580.86, 443.195, 277));
  var_24[5].angles = (0, 225, 0);
  var_24[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2626.12, 397.941, 277));
  var_24[6].angles = (0, 225, 0);
  var_24[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2671.03, 353.029, 277));
  var_24[7].angles = (0, 225, 0);

  foreach(var_10 in var_24)
  var_10 clonebrushmodeltoscriptmodel(var_5);

  var_27 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_28 = [];
  var_28[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1598.5, -580.75, 273));
  var_28[1].angles = (0, 41, -7.5);
  var_28[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2550, 582, 197));
  var_28[2].angles = (0, 45, 0);
  var_28[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2475, 508, 197));
  var_28[3].angles = (0, 45, 0);
  var_28[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2475, 548, 197));
  var_28[4].angles = (0, 135, 0);
  var_28[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-2510, 583, 197));
  var_28[5].angles = (0, 135, 0);
  var_28[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-258, 247, 239));
  var_28[6].angles = (13, 218, 0);
  var_28[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-296.75, 252, 233));
  var_28[7].angles = (0, 308, 13);
  var_28[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-293, 291, 239.25));
  var_28[8].angles = (13, 218, 0);
  var_28[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1858.5, 139.75, 179));
  var_28[9].angles = (0, 352, 0);
  var_28[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1798.5, 123.5, 179));
  var_28[10].angles = (0, 338, 0);
  var_28[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1745, 92.75, 179));
  var_28[11].angles = (0, 323, 0);
  var_28[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1706, 52.75, 179));
  var_28[12].angles = (0, 307.5, 0);
  var_28[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1676.75, 4, 179));
  var_28[13].angles = (0, 296, 0);
  var_28[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1661.25, -50, 179));
  var_28[14].angles = (0, 279, 0);
  var_28[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1863, 129.75, 179));
  var_28[15].angles = (0, 352, 0);
  var_28[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1803, 113.5, 179));
  var_28[16].angles = (0, 338, 0);
  var_28[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1749.5, 82.75, 179));
  var_28[17].angles = (0, 323, 0);
  var_28[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1710.5, 42.75, 179));
  var_28[18].angles = (0, 307.5, 0);
  var_28[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1681.25, -6, 179));
  var_28[19].angles = (0, 296, 0);
  var_28[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1665.75, -60, 179));
  var_28[20].angles = (0, 279, 0);
  var_28[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (979.75, 113, 187.75));
  var_28[23].angles = (0, 307.5, 0);
  var_28[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1269.75, 304.25, 207));
  var_28[24].angles = (0, 305.5, 0);

  foreach(var_10 in var_28)
  var_10 clonebrushmodeltoscriptmodel(var_27, 1);

  register_create_script_arrays("_encstr_8E471CB50EBE1CB46C36854696631BF2FAD8E4592C47B27DE6C639960747", "_encstr_917714E188D820B0BFFE21E358810828B74942400BB0", _encstr_831A3EDFB743CF3F730B50FFC3F049768F0627051B4F6288B0E77159D31189436A51D248372216F6F7D4FC9139BB9E599BB0CF8DF9E89BF0BAB440DBA80186AF::main);
}

_id_11DDD() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (551, 968, 16), (0, 223, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((596.712, 826.265, 52.7056), (38.4733, 358.746, -0.96607), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_88B146A83FD8363942197408ADCAC5B3A3B34068FB5D2ACB6A7D7BAE5483BB2344AF90E87BF963290734ED96DC2AF7ABAB7BFADAB68499671A8AE617F54233D8E2C79058232FB351");
  init_nuke_vault((597.505, 827.286, 44), (18.2161, 358.831, -0.784065), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_859F4083EBB78F23415F7058A765D39BCF822A99C6BBB32B22BF503067F3B373B37BF011DFC31393489A72105FC2EB89DA62F50A731BDB39C3BFA8586EF0E0D3A24A");
  init_nuke_vault((577.046, 826.312, 56.4861), (285.713, 224.755, -46.9075), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_8ADB374BDD1CEBD8B6F55BECB78D9966B1B26E3ADEB15BB1ACDCD2D895DC8DCA939159C6B08D6C57DCA3ACD99CD20758DC76562658C95B5AC8");
  init_nuke_vault((563.626, 828.726, 57.2361), (282.486, 330.676, 28.8378), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_91A83D2B431F27B9E2F7E830DF0DDB07C2ED11A0CA4639E1CB371860DF2C09D5DA979D1A72DACF8B8F0BA8F8E768EBA526BF0EB3CAB2ADD1235B90F09F9939");
  init_nuke_vault((550.079, 827.501, 57.7261), (287.752, 230.356, -51.1188), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_9A494429843A476ED5D132AA58D125220342AFCA139B07F5971AEA02602B5A23A159315EBE415B6C6110034B986157AB183FE89AE22BC3056F28FAB6F8538ACB932D0C4F6F11");
  init_nuke_vault((522.533, 827.936, 61.0601), (292.978, 316.954, 43.057), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_9398404417CF9F2B3B06586710D14EEA4F7ABB6F92E528A04A4FDDCA6B633D627C481C82F726711333F410E9B112E793D286763B9D988B3AB73072889A0E484FAED9");
  init_nuke_vault((505.864, 827.979, 58.6132), (284.965, 252.173, -72.7305), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_AF193C87CF03E97980E61BA638D08FF75FEF673F51C58233106B823CD0B8C47AF607F3B717F55AE458734CF2C3125B732D37372781B2D2A1183B043DE3D0");
  init_nuke_vault((487.901, 827.433, 58.9761), (282.94, 247.059, -67.6423), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_93C03AEC0CC949A18B314B5F80C09512472E76A2F6B182FA13EA073380795B8A3F343A9CDFCBCA371058776F285304B30F7A8716C659C37DC0F83F63");
  init_nuke_vault((-255, 307, 44.5), (277, 271, 90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_9BEE3134B7D9CFA63AA03B0FE13B32DFFC268070F243E08BA11F735DB04770DC80DF0BA357FB73B46F787F874408EF0BED3747");
  init_nuke_vault((0, 655, 47), (0, 0, 0), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_88B146A83FD8363942197408ADCAC5B3A3B34068FB5D2ACB6A7D7BAE5483BB2344AF90E87BF963290734ED96DC2AF7ABAB7BFADAB68499671A8AE617F54233D8E2C79058232FB351");
  init_nuke_vault((130.25, 97.75, 49.7261), (0, 0, 0), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_8F8342237B4F06B142DE981AE0716FD5426359F293BB071C61EBF3B382B77CE1E82893710B900AFE504A93988F8EA7544DE75B2188363A1BF338B7162415C80FB89BDA83");
  init_nuke_vault((224.5, -280.5, 46.75), (0, 90, 0), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_96893C5ABBE0FA6EB9FADAD2B6B22643AC1BBDB60756CE275A38B0DCB3CAC19637D1F636ECC95A831899569985E61D4ECA1BDBB02359E16B2CB36EB19CEC");
  init_nuke_vault((-365.75, -279.75, 11.5), (286, 186, 90), "_encstr_928F15092B725788AF6BD14B54795015C98B8BAFD7DBA7", "_encstr_851904AFBF37", "_encstr_A3C13996EEE0F516C9EBB65AD6590D654CB04EDC43F6C947CA07D29B8EB78DECE4B438C0199586DED8ED56DCE8DB1BB56ECADC4B36B2CD8D599C19");
  var_1 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_A9CD0EB1C62DC16C681E1BA18764A663", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-393, 990.25, 177.5));
  var_3.angles = (270, 0, 0);
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-393, 936.5, 177.5));
  var_4.angles = (270, 0, 0);
  var_4 clonebrushmodeltoscriptmodel(var_1);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-393, 911.5, 177.5));
  var_5.angles = (270, 0, 0);
  var_5 clonebrushmodeltoscriptmodel(var_1);
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-287.75, 321.5, 177.5));
  var_6.angles = (270, 0, 0);
  var_6 clonebrushmodeltoscriptmodel(var_1);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-287.75, 288.5, 177.5));
  var_7.angles = (270, 0, 0);
  var_7 clonebrushmodeltoscriptmodel(var_1);
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (325, 838, 0));
  var_8.angles = (0, 346.838, 0);
  var_8 clonebrushmodeltoscriptmodel(var_2);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (317.5, 827.5, 0));
  var_9.angles = (0, 337.959, 0);
  var_9 clonebrushmodeltoscriptmodel(var_2);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (574.25, 773.75, 0));
  var_10.angles = (0, 0, 0);
  var_10 clonebrushmodeltoscriptmodel(var_2);
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (515.75, 773.75, 0));
  var_11.angles = (0, 0, 0);
  var_11 clonebrushmodeltoscriptmodel(var_2);
  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (507.5, 749.25, 0));
  var_12.angles = (0, 0, 0);
  var_12 clonebrushmodeltoscriptmodel(var_2);
  var_13 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (571.5, 749.25, 0));
  var_13.angles = (0, 0, 0);
  var_13 clonebrushmodeltoscriptmodel(var_2);
  register_create_script_arrays("_encstr_87111DB507D7B6AFB767569CAECD8C95E4BE1B4EACC2E895D76EB139A51C1D", "_encstr_934617D2DF1F4A5BF04A5BBD2C92C5215740DA4E55A0C63AFF", _encstr_BD0140AB669B77D221584E6228FFCD0F73D64F3D07C6AFD12F68928B38A547D76B9085B808281FE5F5D8EBF308997F33262E0225BF533FA1A710F30AE0C1652F1B86::main);
}

_id_11DD6() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (1191, -1372, 62), (0, 154, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);

  switch (level.trial["_encstr_B6A208B3C2275AC2B9E8"]) {
    case "_encstr_A59306426009CA07":
      var_1 = "_encstr_87610AB4EE83FAD6374B3395";
      break;
    case "_encstr_A32D07CFD14BAA94D0":
      var_1 = "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F";
      break;
    case "_encstr_8D940738966ED1DB8D":
      var_1 = "_encstr_88FE0D0157202970845121C58E802F";
      break;
    case "_encstr_BD78059C33C543":
      var_1 = "_encstr_87610AB4EE83FAD6374B3395";
      break;
    default:
      var_1 = "_encstr_8BE20ED75722A6731BF84F3064CA126B";
      break;
  }

  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", var_1);
  level._id_13D93 = 1;
  var_2 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = [];
  var_3[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (210, -923, 18));
  var_3[0].angles = (0, 45, 0);
  var_3[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1594, -323, 18));
  var_3[1].angles = (0, 0, 0);
  var_3[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1578, -707, 18));
  var_3[2].angles = (0, 0, 0);
  var_3[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1466, -787, 18));
  var_3[3].angles = (0, 0, 0);
  var_3[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1290, -763, 18));
  var_3[4].angles = (0, 0, 0);
  var_3[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-374, -1211, 29));
  var_3[5].angles = (0, 0, 0);
  var_3[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-494, 765, 17));
  var_3[6].angles = (0, 0, 0);
  var_3[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-214, 1277, 15));
  var_3[7].angles = (0, 0, 0);
  var_3[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (330, 581, 18));
  var_3[8].angles = (0, 0, 0);
  var_3[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-323, 1618, 23));
  var_3[9].angles = (0, 0, 0);
  var_3[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-211, 1498, 17));
  var_3[10].angles = (0, 0, 0);
  var_3[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-91, 1386, 17));
  var_3[11].angles = (0, 0, 0);

  foreach(var_5 in var_3)
  var_5 clonebrushmodeltoscriptmodel(var_2);

  var_7 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1020.19, -1258.55, 99));
  var_8.angles = (89.9943, 50.4576, 75.86);
  var_8.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
  var_8 clonebrushmodeltoscriptmodel(var_7);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (996.16, -1309.13, 99));
  var_9.angles = (89.9943, 50.4576, 75.86);
  var_9.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
  var_9 clonebrushmodeltoscriptmodel(var_7);
  var_10 = [];
  var_10[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1047.38, -1275.89, 139));
  var_10[0].angles = (0, 334.595, 0);
  var_10[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1026.78, -1319.25, 139));
  var_10[1].angles = (0, 334.595, 0);
  var_10[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1105.18, -1303.35, 139));
  var_10[2].angles = (0, 334.595, 0);
  var_10[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1084.59, -1346.71, 139));
  var_10[3].angles = (0, 334.595, 0);
  var_10[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1163, -1330.81, 139));
  var_10[4].angles = (0, 334.595, 0);
  var_10[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1142.41, -1374.17, 139));
  var_10[5].angles = (0, 334.595, 0);
  var_10[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1228.04, -1361.69, 139));
  var_10[6].angles = (0, 334.595, 0);
  var_10[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1207.44, -1405.06, 139));
  var_10[7].angles = (0, 334.595, 0);

  foreach(var_5 in var_10)
  var_5 clonebrushmodeltoscriptmodel(var_7);

  var_13 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_14 = [];
  var_14[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1090.01, -1260.71, 83));
  var_14[0].angles = (0, 334.595, 89.9989);
  var_14[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1205.63, -1315.63, 83));
  var_14[1].angles = (0, 334.595, 89.9989);
  var_14[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1045.39, -1354.66, 83));
  var_14[2].angles = (0, 334.595, 89.9989);
  var_14[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1161.01, -1409.57, 83));
  var_14[3].angles = (0, 334.595, 89.9989);

  foreach(var_5 in var_14)
  var_5 clonebrushmodeltoscriptmodel(var_13);

  var_17 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_18 = [];
  var_18[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (996.79, -1251.87, -5));
  var_18[0].angles = (0, 334.595, 0);
  var_18[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (976.198, -1295.23, -5));
  var_18[1].angles = (0, 334.595, 0);
  var_18[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1054.6, -1279.32, -5));
  var_18[2].angles = (0, 334.595, 0);
  var_18[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1034.01, -1322.68, -5));
  var_18[3].angles = (0, 334.595, 0);
  var_18[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1112.42, -1306.78, -5));
  var_18[4].angles = (0, 334.595, 0);
  var_18[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1091.82, -1350.14, -5));
  var_18[5].angles = (0, 334.595, 0);
  var_18[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1170.22, -1334.24, -5));
  var_18[6].angles = (0, 334.595, 0);
  var_18[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1149.63, -1377.59, -5));
  var_18[7].angles = (0, 334.595, 0);
  var_18[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1228.46, -1361.47, -5));
  var_18[8].angles = (0, 334.595, 0);
  var_18[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1207.87, -1404.82, -5));
  var_18[9].angles = (0, 334.595, 0);
  var_18[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1253.51, -1382.65, 15));
  var_18[10].angles = (0, 334.595, 0);
  var_18[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1239.78, -1411.56, 15));
  var_18[11].angles = (0, 334.595, 0);
  var_18[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1253.51, -1382.65, 79));
  var_18[12].angles = (0, 334.595, 0);
  var_18[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1239.78, -1411.56, 79));
  var_18[13].angles = (0, 334.595, 0);

  foreach(var_5 in var_18)
  var_5 clonebrushmodeltoscriptmodel(var_17);

  var_21 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_22 = [];
  var_22[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (950.79, -1282.87, 59));
  var_22[0].angles = (0, 244.595, 0);
  var_22[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (970.79, -1239.87, 59));
  var_22[1].angles = (0, 244.595, 0);
  var_22[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (963.79, -1320.87, 59));
  var_22[2].angles = (0, 334.595, 0);
  var_22[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1008.79, -1225.87, 59));
  var_22[3].angles = (0, 334.595, 0);

  foreach(var_5 in var_22)
  var_5 clonebrushmodeltoscriptmodel(var_21, 1);

  if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_A32D07CFD14BAA94D0")
    level._id_125CA = 1;

  register_create_script_arrays("_encstr_A6101E40537FE141C8E02BC7BBC0BB21023A816FF86758B3D0C147D333E7D2EB", "_encstr_BE83163F0866F8825F2A3DF70B7F5BB9ABD07FC3B018299A", _encstr_B6F74293B845C45B1B36A7ED4F88D70EA9A0DECA8847FC57D112FE1DE3AECF5615F04642F0EF348F890AF615FBF6179E7D48C93A48632E93A178D30B16D87B631D38F3B2::main);
}

_id_11DE0() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (960, 0, 152), (0, 180, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((803.97, 4.83, 205.7), (283.41, 238.67, 35.51), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_AC2227E81BF0317652A7290977FBB79A12E4F1E0C45BB82DBA0B1129AF520BF8530E999B2A704066C3");
  init_nuke_vault((804.42, 15.72, 203.25), (282.84, 232.89, 37.28), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_8DD231A92F021107FB3EFB124045BF0EA249132E9BF0635B153022FA898ADB0D785FC3FB17B0EDD7CAA87ED2317EBF84B01D5C");
  init_nuke_vault((805.06, -11.8, 200.98), (283.73, 126.36, -38.79), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_AC0F13570FE2175B31FF20CB683F22FF2AD027D3D0");
  init_nuke_vault((805.17, -24.5, 195.47), (285.92, 237.26, 31.72), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_82A83C04B39A07637BF7F79FE7953F265ABBBF4F4898D85AC3BDEF9EFFC512ABF040B584E10B9B83A6B3E397C3E51EE7C008EA5B39F0444EF65393973B9D");
  init_nuke_vault((804.51, -29.71, 205.95), (38.47, 268.74, -0.9), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_835F40B88B3289A952D1460B729727DEA1E07BA7386FA2234AA0B35F5B38A419B38BC259C2C7B4D18271AB43A5FF1EE72653D64BA2C1953BF1839297057B682B7CC3");
  init_nuke_vault((801.56, -15.55, 221.23), (350.4, 89.83, -4.89), "_encstr_8E15168B23A74F9821862B05B196B08DD7AB80902BC7FD40", undefined, "_encstr_B61939B4BB1CD7E643F5B14316C9C64BB26E64A9CAECD52C39234359C2CECBCA6658CD1DE459C6DE583295DC8EBD36D673F6AC130B939B34BD9C47");
  var_1 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (812.5, -6.5, 209.25));
  var_2[0].angles = (270, 0, 0);
  var_2[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (804.75, -6.5, 209.25));
  var_2[1].angles = (270, 0, 0);
  var_2[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (812.5, -6.5, 173.75));
  var_2[2].angles = (270, 0, 0);
  var_2[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (804.75, -6.5, 173.75));
  var_2[3].angles = (270, 0, 0);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);

  var_6 = getEnt("_encstr_96DF0E4EC202196F2F82B0DA8BFF4822", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = [];
  var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (929.25, 191.75, 209.25));
  var_7[0].angles = (90, 90, 0);
  var_7[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (929.25, -198.5, 209.25));
  var_7[1].angles = (90, 90, 0);

  foreach(var_4 in var_7)
  var_4 clonebrushmodeltoscriptmodel(var_6);

  register_create_script_arrays("_encstr_ABB619599BB7094E2F09AF6047E6A7E01AC6D11A8F6EC7883CCB0D", "_encstr_BE670F91B7AFDB884B63A0A99808F316AD", _encstr_82A138EB5EFAC0B7D357FF73734E71D8903218A0026F28F85B535B7767164998670D9EFBABB9E0AAB1E77573674B8599E366A33052F4C2542BDF::main);
}

_id_11DDC() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-1096, 0, 16), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-982, 85.5, 72.5), (33.6, 127, 0), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_A37C44672FA349C8F846FDC4F8A0B9C6549B87EBCDA5C29FD049640AD150247A332B770B43FA0B5A48316ED30B9820C72269FFE711705207B8D8A28A0B4ABA8A66C7431F8525");
  init_nuke_vault((-991.6, 98.5, 73.2), (33.6, 127, 0), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_B172436778C297CB0378073DD93527217888F3EF6001F5A341A75A2431E30B3D3B803763F8D85B0A4932D2ACA6A182CC21688F9B0AFBDBA3833F1F22A2B5BA9A4B201F2B80");
  init_nuke_vault((-1001, 110, 72.5), (33.6, 127, 0), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_B4283823341031C1B490210F19FF9202B2BB98FA9FF33F63424ACC83E932D27670D33850177AEE93F9B3DBC7CD582E226D4C2917105FD0E3FF0F");
  init_nuke_vault((-993.7, 99.6, 65), (0, 127, 7), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_8C473FA5DDE0EB375BD79BB63BBDC66668D4653959CC632B1EB62DB92DCCCA26164EDCA1BDC91D65B91DDEB1AD6ECA0E2DE647F6633BC95A1C811959B95BB0ECCD");
  init_nuke_vault((-990, 91.5, 52), (0, 127, 7), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_AA43408AF3035F7EB88F592B9B3085BAECE082925874122480CB433CBF184F7B7BE30F1F28D6436DC0D7447BBFA8D53791B93692C92E8764C80D54364FF05BC74631");

  if(_tablethide::_id_13D4C())
    thread _id_13D6D();

  register_create_script_arrays("_encstr_825F18B8136FB9F1DC69253FB70640753FEB31664BE76E08326C", "_encstr_9BE51A8AD8E70D2F20F32E5F80ABD354C39011A2686D4637DB663B55", _maxoutequipmentammo::main);
}

_id_11DD7() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (3915.5, -2334, 236.5), (0, 104, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3844.75, -2172.25, 278.75));
  var_2.angles = (270.6, 350, -62);
  var_2.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3893.25, -2158.25, 278.25));
  var_3.angles = (270.6, 350, -62);
  var_3.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_4 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = [];
  var_5[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2841, -1100, 303));
  var_5[0].angles = (0, 272.7, 0);
  var_5[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2636, -1408, 192));
  var_5[1].angles = (0, 268, 0);
  var_5[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2097, -1282, 192));
  var_5[2].angles = (0, 268, 0);
  var_5[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1954, -1208, 192));
  var_5[3].angles = (0, 271, 0);
  var_5[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1632, -371, 295));
  var_5[4].angles = (0, 271, 0);
  var_5[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-478, -1242, 192));
  var_5[5].angles = (0, 271, 0);
  var_5[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1691, -425, 192));
  var_5[6].angles = (0, 0, 0);
  var_5[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2843, -1048, 248));
  var_5[7].angles = (0, 268, 0);
  var_5[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (2793, -1048, 192));
  var_5[8].angles = (0, 270.5, 0);
  var_5[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3803, -1392, 192));
  var_5[9].angles = (0, 268, 0);
  var_5[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3363, -1584, 192));
  var_5[10].angles = (0, 240, 0);
  var_5[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (3536, -990, 192));
  var_5[11].angles = (0, 249, 0);
  var_5[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (699, -1219, 192));
  var_5[12].angles = (0, 271, 0);

  foreach(var_7 in var_5)
  var_7 clonebrushmodeltoscriptmodel(var_4);

  register_create_script_arrays("_encstr_863724938BB97B582AC68823A1E6E820527B133753E23C106F9E13D9D6DCE870CB97DD8BBBDB", "_encstr_BEC41E8838B9ACE1EBF26A4229C1E5CB9648A91908D5BF9BA8D0CBE9541B7541", _maphint_offerscriptableused::main);
}

_id_11DC5() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-125, 819.5, 104.5), (0, 351, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  var_1 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (46.6, 772.4, 143.6));
  var_2.angles = (270.6, 350, -178);
  var_2.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
  var_2 clonebrushmodeltoscriptmodel(var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (53.6, 822.4, 143.6));
  var_3.angles = (270.6, 350, -178);
  var_3.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
  var_3 clonebrushmodeltoscriptmodel(var_1);
  var_1 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = [];
  var_4[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-167.25, 805.7, 195.9));
  var_4[0].angles = (0.6, 351.8, -180);
  var_4[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-161.25, 847, 195.9));
  var_4[1].angles = (0.6, 351.8, -180);
  var_4[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-104.25, 796.6, 195.2));
  var_4[2].angles = (0.6, 351.8, -180);
  var_4[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-98.25, 838, 195.2));
  var_4[3].angles = (0.6, 351.8, -180);
  var_4[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-41.05, 787.6, 194.7));
  var_4[4].angles = (0.6, 351.8, -180);
  var_4[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-35.05, 829, 194.7));
  var_4[5].angles = (0.6, 351.8, -180);
  var_4[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (22.15, 778.7, 193.9));
  var_4[6].angles = (0.6, 351.8, -180);
  var_4[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (28.15, 820, 193.9));
  var_4[7].angles = (0.6, 351.8, -180);

  foreach(var_6 in var_4)
  var_6 clonebrushmodeltoscriptmodel(var_1);

  var_8 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_9 = [];
  var_9[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-115, 764.25, 127.9));
  var_9[0].angles = (0.6, 351.8, -90);
  var_9[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-13.75, 749.75, 126.9));
  var_9[1].angles = (0.6, 351.8, -90);
  var_9[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-100.75, 865, 127.9));
  var_9[2].angles = (0.6, 351.8, -90);
  var_9[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0.5, 850.5, 126.9));
  var_9[3].angles = (0.6, 351.8, -90);

  foreach(var_6 in var_9)
  var_6 clonebrushmodeltoscriptmodel(var_8);

  var_12 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_13 = [];
  var_13[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-203.25, 810.25, 192.5));
  var_13[0].angles = (0.6, 351.8, -180);
  var_13[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-197, 853.75, 192.5));
  var_13[1].angles = (0.6, 351.8, -180);
  var_13[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-203.25, 810.25, 128));
  var_13[2].angles = (0.6, 351.8, -180);
  var_13[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-197, 853.75, 128));
  var_13[3].angles = (0.6, 351.8, -180);
  var_13[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-147.25, 802, 103.25));
  var_13[4].angles = (0.6, 351.8, -180);
  var_13[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-141, 845.5, 103.25));
  var_13[5].angles = (0.6, 351.8, -180);
  var_13[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-102.5, 795.25, 102.5));
  var_13[6].angles = (0.6, 351.8, -180);
  var_13[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-96.25, 838.75, 102.5));
  var_13[7].angles = (0.6, 351.8, -180);
  var_13[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-48.5, 787.25, 102));
  var_13[8].angles = (0.6, 351.8, -180);
  var_13[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-42.25, 831, 102));
  var_13[9].angles = (0.6, 351.8, -180);
  var_13[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (13.25, 778.75, 101.5));
  var_13[10].angles = (0.6, 351.8, -180);
  var_13[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (19.5, 822.25, 101.5));
  var_13[11].angles = (0.6, 351.8, -180);
  var_13[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (76.25, 769.75, 101));
  var_13[12].angles = (0.6, 351.8, -180);
  var_13[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (82.25, 813.25, 101));
  var_13[13].angles = (0.6, 351.8, -180);

  foreach(var_6 in var_13)
  var_6 clonebrushmodeltoscriptmodel(var_12);

  var_16 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_17 = [];
  var_17[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1056, 161.5, 55.25));
  var_17[0].angles = (0, 267.81, 0);
  var_17[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1278.5, -141.25, 60.25));
  var_17[1].angles = (0, 268, 0);
  var_17[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-993.5, -739, 69.75));
  var_17[2].angles = (358.75, 248.85, 2.35);
  var_17[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-219.75, 1092.25, 56.5));
  var_17[3].angles = (0, 269, -2.4);
  var_17[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1037.75, 794.5, 60.5));
  var_17[4].angles = (3.5, 269, 0);
  var_17[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-532, -704, 62));
  var_17[5].angles = (0, 269, 0);
  var_17[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-404.5, 1299, 62));
  var_17[6].angles = (0, 269, 0);

  foreach(var_6 in var_17)
  var_6 clonebrushmodeltoscriptmodel(var_16);

  var_20 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_21 = [];
  var_21[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (86.75, 841.5, 101));
  var_21[0].angles = (0.6, 351.8, -180);
  var_21[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (110.8, 809.5, 101));
  var_21[1].angles = (0, 261.8, -0.6);
  var_21[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (104.5, 765.25, 101));
  var_21[2].angles = (0, 261.8, -0.6);
  var_21[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (72.25, 741.5, 101));
  var_21[3].angles = (0.6, 351.8, -180);

  foreach(var_6 in var_21)
  var_6 clonebrushmodeltoscriptmodel(var_20, 1);

  register_create_script_arrays("_encstr_BE041A95C331AAD20E6F0317498E79E3E0C90E5B99D963CADE037B73", "_encstr_8FA812CD485FF6901BDF8D0F5B16F7656A204069", _encstr_AA093A6EB1935AE03A9BE5D607BCB52C07B9CBB683AFC4C2C6B6C6EDE88C975B0EEB31C2C6D6B17BA323D78DC9CAC28E59AFDCD84E2D0E475CD9CDB1::main);
}

_id_11DEF() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((3229, 2578, 131), 128, 99999, 9999);
  glassradiusdamage((3069, 2023, 131), 128, 99999, 9999);
  glassradiusdamage((2699, 1683, 131), 128, 99999, 9999);
  thread _id_13A69();
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (3793, 1413, 68), (0, 240, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((3843.58, 1054.18, 124.7), (0, 205, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_971C366B3C4711207007329007737F23C33B57E5E62DC91AF14828C0880C483A4F3BBC43D77F6E33AB8F2F1AAF73F38A808F1087801BA0B9");
  init_nuke_vault((3867.43, 1063.33, 146.36), (0, 24, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_BAA73849A41A674EF5F1D2CAB02B4263E80583EB33F8F7D5FF082BD78207FE3B01F543647AC0179DBFA2A6DB6047B6EF7B72DAE96E4B53656DF0");
  init_nuke_vault((3869.86, 1065.88, 129.89), (0, 24, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_9B503F59DFF2E1F789AE9A53715FF733D27DCDDE11F0F0B7A3E0D2EE7B3B67DB98D94732B383AA027A7B7B92E1025BD562ADF9BA1F68855BFD98027A286ECF8A30");
  init_nuke_vault((3867.48, 1065.71, 113.6), (0, 24, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_B63B3BD2BBC1D7E634AF461CC21C2CC464560E96E6D17B1BEC39B4830C9959B3EA2C2723D8EA9BA3AC983958B52B95982C9CDC43DEC93AB20FD658B39B");
  init_nuke_vault((3789.69, 1044.18, 130.55), (0, 0, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_A1B9366237AA21B8C87E789325CCA7C2BADA9BDB1FC3D509AA63A783F226B2EC6D9B3B1FE060CF57E9B42362917B2DC39A165E50CEE930A7");
  init_nuke_vault((3786.95, 1044.11, 147.39), (0, 0, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_958D39A5DD70AF58C9D7C26D4B36BDD0DC59D99C9607169B7683C9BD56C15A371DDB63D94ED28360C8CACD8EED1BB61B57B947CA26854E365D9BA3");
  init_nuke_vault((3789.21, 1047.14, 112.9), (0, 0, 0), "_encstr_86B8164B5AA1C0F92103230D57EA30B07F3791810605E0AD", undefined, "_encstr_91103EE34720D11197E9B8E1F24BDC7A5BE3616BEBDFE066CFD2F1A95E13039B630F99EF7284388FBAFE6B51B21BCD906BD30D5B1A6D48FD365201788A57FEA8");
  init_nuke_vault((3843.58, 1054.18, 124.7), (0, 205, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_A71341F7E852075BB3C8352CCA4387998B326653E0B37DB2F1DA7A242E593A84E9B0E7A30283E3ABF583875E153F431B52E03F7780C0F2C2BF290E5275E51B1978C8A7");
  init_nuke_vault((3867.43, 1063.33, 146.36), (0, 24, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_B2DB43DA273967BF858F980651425EC08860DAF0D9857590E6190D722C494BE1EF20CFD314A9A831CFA2189313FAF65BC763BBF0526278B032405761BB7BF8DA6AD9A6275B");
  init_nuke_vault((3869.86, 1065.88, 129.89), (0, 24, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_81974A79B40A77DADB0122EBE8399616D09EFDEE41C9B365FB606A5648634AABB00947726BB35AFA07B0432AA85FC58F60E6C90AFE185F32911A3AC2F8A77B2723FA5C9116C1E37A6328629A");
  init_nuke_vault((3867.48, 1065.71, 113.6), (0, 24, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_B678405AEE837D371AAF19830B38C2624665E02DB9A3DBC6EC27960E069965EC5D0B9C32C6AB37D1B2138527E61AEDE447650FAD2CCE9BAC6385375927E40B73CEB2");
  init_nuke_vault((3789.69, 1044.18, 130.55), (0, 0, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_82EE3D89E40B6782F01FC5FE0E745F9E49AE6F0A53B818834CB3E85F79AAD48349707FFB6AB3666524A4CF2A173393BF33289B8F96B196D0CF3BFEDF58DF1D");
  init_nuke_vault((3786.95, 1044.11, 147.39), (0, 0, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_8FE244624881396FAB70B9BB73300FABF7D20A4B10A96E9BE1CF92A73A9BDF82A958C2925073629A739A9BB42001EFCE0320CBEE383B5A1FF39E84934969C79775C00232A89B");
  init_nuke_vault((3789.21, 1047.14, 112.9), (0, 0, 0), "_encstr_9A3614C94EB88A45B19B72B6F11F38830F83CA4010BD", undefined, "_encstr_91103EE34720D11197E9B8E1F24BDC7A5BE3616BEBDFE066CFD2F1A95E13039B630F99EF7284388FBAFE6B51B21BCD906BD30D5B1A6D48FD365201788A57FEA8");
  register_create_script_arrays("_encstr_BA6818E2B08FB3AF49AF7664A8913BBF1B68EA599B4FEAC7430D", "_encstr_97C11031F8F743534E8AD00841A32DF8679C", _encstr_B87036D753B2601FF32BF0A0034659E8CABBE773E851C0EFC722D08B1E678F61E30187E36EC34126BB1A097382D7C648BA91297146EF987E::main);
  thread target_random_models();
  thread player_isusingtacmap("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
  thread _id_11DF0();
}

_id_11DF0() {
  for(;;) {
    level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
    var_0 = getentitylessscriptablearrayinradius("_encstr_8AC1374BFE5A601773BF8591C7A9DE68F2D49323E6B28045F9AFE78DA7C3A610BBEB38D8CD27B80812C3D7E737FAED085C89C156E212A931BB", "_encstr_AC110A7F14873B5B3D073009");
    var_1 = getentitylessscriptablearrayinradius("_encstr_BE1132DFB71B8BC03C1619D03F2FE036B307512957C2C1207F2FA088E2C7D87DAB8FF1F7A71A98E89447AE2141F07AB832BB6B23", "_encstr_AC110A7F14873B5B3D073009");
    var_2 = getentitylessscriptablearrayinradius("_encstr_8AEF2F371BE496C1A3B0C436ACD79BC639A507A32C89D82BFA8CEDF64EAFBBF6F6C8AC9BBEF6CC995A1BB2F50CC47DDA38", "_encstr_AC110A7F14873B5B3D073009");
    var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);

    foreach(var_5 in var_3)
    var_5 vehicle_getinputvalue();
  }
}

_id_11DD9() {
  level.trial_infinite_reserve_ammo = 1;
  glassradiusdamage((112, -1366, 67), 128, 99999, 9999);
  glassradiusdamage((112, -1366, 185.5), 128, 99999, 9999);
  glassradiusdamage((191, -1560, 185.5), 128, 99999, 9999);
  glassradiusdamage((-1088, -951, 67), 128, 99999, 9999);
  thread _id_13A69();
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-98.5, 1639.25, 13), (0, 10, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((101.75, 1765, 84.5), (338.5, 130.25, 5.2), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_971C366B3C4711207007329007737F23C33B57E5E62DC91AF14828C0880C483A4F3BBC43D77F6E33AB8F2F1AAF73F38A808F1087801BA0B9");
  init_nuke_vault((112, 1753.25, 83.7), (347.6, 131, 5), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_A28C184BEE0E7DC1B4FAB6A5ADCA9C956685E63AC92B8DBDC246");
  init_nuke_vault((120.5, 1741.75, 84), (347.6, 131, 5), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_88B146A83FD8363942197408ADCAC5B3A3B34068FB5D2ACB6A7D7BAE5483BB2344AF90E87BF963290734ED96DC2AF7ABAB7BFADAB68499671A8AE617F54233D8E2C79058232FB351");
  init_nuke_vault((107.25, 1757.25, 64), (286.8, 99.23, 28), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_A2D83B2DEEE0AFCDB5F55B1CB00E856A59C4B039DC5A1B4659DC1DF68D6D635933B09B8E392BD8B7852356C15ACD47ED1BCE9CA5C1C064ACF05B0B769B");
  init_nuke_vault((115.75, 1746, 66.25), (286.8, 99.25, 28), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_9B963DA92F021107793E8B4343C1D7C428EB4B3CBD40652F173166DB8BA8B78CE8C7C0B917B0EDEBCCEB5AF31B5EDE06C01D4B2D6F1824C3E1A1B2CBB85637");
  init_nuke_vault((125.5, 1733.25, 66), (286.8, 99.25, 28), "_encstr_BAF113D14E5A581BAFEC2C27962CCD8EEB66B0B98E", undefined, "_encstr_873A3C7CCBE27F2BA1AFBFC33BD7F2EF92D3B345E12004E60EEBDB3731708BE42A996ECA7B40D54AD0838B5E292B433C6060671270A8C8E71AA9976F7FCE");
  init_nuke_vault((62.25, 1797.5, 87), (0, 143, 0), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_9B5B3E1B732F1789D2E7F8C02F1DEB37321E8E1D8A522930A923C218BB3F59CFCB14872BA21BE7989703E8F8921A9835F2EF71A5F8625380714EB878F373E851");
  init_nuke_vault((53, 1801.5, 60), (288, 125.15, 17.4), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_8A22404BBB83EB9B37AF6B5AB5564C4365C1D2DCD17B8D3B395A0781CC569985378EC9B263BDC23256C3D685CEB9B24C169C9B347B4E47954E56991B59876B96735A");
  init_nuke_vault((64.25, 1792.5, 58.5), (287.35, 123.75, 18.74), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_82AB4104B39A074276F7DBBFE993CA715A39BE0A4B20C54AC0A3DB9EFFC512ABF0E3A4522D909C32A9B79B8FE1CF8FAB40096A1A981842BB5275CFBB311DF355B07024");
  init_nuke_vault((75, 1784.25, 61.5), (289.6, 126, 16.6), "_encstr_AADA14A3238A0A8C197321DBE07805730EA97DE08843", undefined, "_encstr_8CD4478AA069C1DFC0A8739356C84F5225B816528897078379AF6491E0D1379F3F783A3B482DFF33B08774C387B8A723CF80C2A318C1E262E07E79921E608F6A51221BAA88A16F13CB");
  var_1 = getEnt("_encstr_BD2B10FEA868500F0E61EBC69DF363E95ABA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1145.25, 291, 0.75));
  var_2[0].angles = (0, 0, 0);
  var_2[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1273.75, 291, 0.75));
  var_2[1].angles = (0, 0, 0);
  var_2[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1145.25, 164.5, 0.75));
  var_2[2].angles = (0, 0, 0);
  var_2[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1273.75, 164.5, 0.75));
  var_2[3].angles = (0, 0, 0);
  var_2[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (203.25, -622.75, 0.75));
  var_2[4].angles = (0, 0, 0);
  var_2[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (93, -599.5, 0.75));
  var_2[5].angles = (0, 350.75, 0);
  var_2[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (124.5, -655.75, 0.75));
  var_2[6].angles = (0, 38.5, 0);
  var_2[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (203.25, -684.75, 0.75));
  var_2[7].angles = (0, 0, 0);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);

  register_create_script_arrays("_encstr_810824EA3847F0CB1957C8731DEF11BD9D216647E5FA88626747280A88A32AE65B4F5380D103", "_encstr_A63C1C90221F43F30AC7878BBB814518F1FE382E0F9D88A01287BB8D4FCA", _encstr_AAE44338923A7BA363CB2871A0664833E23B62403B99B1581BC5B7759CBEB0D981F2D890822DF3B31FEF15E05FA7B86B32EB20C15A021B29EB1508667B9BA0291BA6B85832::main);
  thread target_random_models();
  thread player_isusingtacmap("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
}

_id_11DD5() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (53844, -18822, 4690), (75, 355, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
}

_id_11DE5() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AC1F058B9EABE0") {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (36805, -14366, -152), (0, 300, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
    level._id_13D5B = 1;
    level.localeid = "_encstr_A63409881A3633786F5F9E";
    register_create_script_arrays("_encstr_A2F529B3AB9955E0112608668CC5C803F26F0119973388B83FFAF37E76BAC84F5BAFE7BBE78B6E904152FB", "_encstr_8A5919A8037FC568AC91315FB097A003276A83F33A93E8A0466B3B", _playerwaittillcinematiccompleteinternal::main);
  } else {
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (53844, -18822, 4690), (75, 355, 0));
    scripts\mp\spawnlogic::bdiedonce([var_0]);
  }
}

_id_11DCF() {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AC1F058B9EABE0") {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (22448, -17782, 560), (0, 315.999, 0));
    thread mindia_exterior_sfx();
    level._id_13D5B = 1;
    level.localeid = "_encstr_8D34098D7BB185C6CAEB1C";
  } else {
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_A72E3BB4DD83EBB027EBB64BDA950D65E4959963590FFA77953747032359336B3556382DDCD1DE63EC93B407066456DCE87B1B6DB1CA31854E36F6E676");
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_8B791885530F01093F9FD449F01BF71807FF048F08E92D2D713A", "_encstr_BA090ED4634AD742CFC7BBABA36F5A77");
    var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (28101, -11340, 7000), (75, 200, 0));
  }

  scripts\mp\spawnlogic::bdiedonce([var_0]);
  register_create_script_arrays("_encstr_96021D5B1CAF8CF6BBE68EDBBBCDEBB377AFD839CA85D195EBDC8D274B3847", "_encstr_A50615B6C1F519ED77DCA3EDEE9BEBB3BBFAA3395A2C8D", _encstr_85D140F720732943A1F69D055F2FAAE99B380E77500E9CFACF3753BDC44541B703729F8B9101DFA325259DB3A07F9A6FAE686B4708BB0D6937B6A22C9701C607F3C0::main);
}

_id_11DCA() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2482.78, -1290.79, -28.0287), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  init_nuke_vault((-2262.25, -1500.75, 33), (0, 0, 0), undefined, undefined, "_encstr_AF92242387E011572B2978E0722FB5FACDE1A5BB2A1F102DB7B3B8298B374FE86752E9B7A785");
  init_nuke_vault((-2276.25, -1502.25, 50), (0, 0, 0), undefined, undefined, "_encstr_BA090ED4634AD742CFC7BBABA36F5A77");
  init_nuke_vault((-2204, -1501, 36), (0, 0, 0), undefined, undefined, "_encstr_A3EF0E518C324F35EBD9CA8250CB3A22");
  init_nuke_vault((-2204.25, -1503, 51), (0, 0, 0), undefined, undefined, "_encstr_AF6D4CFB3CCFCF1650FF0A0AA87606B12DDD3AAD92E19D2DF1AF35380FDBC25FCE2B502A2A5B9759CDAF24ED1B2862FE4A98B4AB1793A82EFABBC18636B87FFAF19F03A2D2C3980D2313D71D71AF");
  level._id_12489 = "_encstr_843D095F2B7D52B041D9A3";
  level._id_1248B = "_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61";
  level._id_1248A = 1;
  level._id_124C9 = 1;
  level._id_13D59 = [];
  level._id_13D59 = scripts\engine\utility::array_add(level._id_13D59, "_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  level._id_13D3F = 1;
  level._id_13D41 = 1;
  thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
  register_create_script_arrays("_encstr_920F19E5877FF2A903F8A767801E632BD3972B1FF88F4AE2883803", "_encstr_920F19E5877FF2A903F8A767801E632BD3972B1FF88F4AE2883803", _maphint_cheese2scriptableused::main);
}

_id_11DD8() {
  level.trial_infinite_reserve_ammo = 1;
  level._id_13D87 = 1;
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (864, -752, 288), (0, 270, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  init_nuke_vault((1030, -1040, 382), (0, 60, 0), undefined, undefined, "_encstr_970CBC535F072880E241B16875CEE879FA7F1D7BCA9E0E581A6578601FBFF020C28BBB4B3B82CED274ACC1FB866318F09A0337F5DFAA9EC86A4E03D82F42209F83B785494EB25ED09EEAF169973908D97BF71BF5C7ABAD18AA473BEA2BABB087E28F936DAF136550C25F23F2338390CBDB8B17E1373B3B8048A28EF1CDBFF875924B8B25A687D258350EB6C9F59730BD4AA373AD3E2F6A084DA5F9819B5390E162EFF30DCF732BFA2B7AC3184623682A1A4B179BB34A5408B516E9B3F844");
  init_nuke_vault((1028, -1040, 362), (0, 60, 0), undefined, undefined, "_encstr_9B247B225BABC7A28877A0B901E03ACA17780A2A0369CF1DA00FB8811918E2827FE0725228B3E3175051AF9C71AAB10F08607A6F5B3A234CD069D79CE7F0C41BB85BA393984F5E09A0ABC099271ADA8E56113AA9A34F93FE6235982BBFF815FFF049D2C34B1EDB7529E7C96427181D37ACE33A4B31E0036E28E3AB22E9");
  init_nuke_vault((1026, -1040, 344), (0, 60, 0), undefined, undefined, "_encstr_839E8F97DF33D95B48F6CE1429689C7265BB16235BBE430928DEC61CC140D40ACD13EEBFE56BBBEE58033B227890ABC21E277357A18562B130E83321D1C0292BF943C7F687B7DA7B60902D37EB1060C7EF97572BFBDE5229C0B2F47A2128874A2B03ABB3738D4F5388015D8719A8D362718B46B7E12012DB782E96CC7170047ADD83DE13AB5F1A9B99B14C960BD859F28B");
  init_nuke_vault((976, -1096, 364), (0, 30, 0), undefined, undefined, "_encstr_AAD2CCD2EE0EEB36B6D7E65A59E49C853CCAB046D995C9E659992D2795F5DCB459933916E15631164E0B918DF673D9EB6EA559E4272CC3B25AC9BD73CD46CA66165D6347F5CD9656C9C9C21E65D8C2DC5639138563C2E68D59917DDC5A5993390B87569CACB1BE9BD2AC4E39853C56E6D2632BCDB12B3926581BC2E6D895321B6BD95937D1F6366DE685BB7DB9B4954E39B01E953747B76CDA6E85DDD79B96CAE4E4581EF52CD11D395A13578E59B9568E935AD9B39C5A07D76E4BB29C4EC20FCA87AD0BD99BD79B4BAC9327C287");
  thread target_random_models();
  thread player_isusingtacmap(undefined, undefined, 1);
  register_create_script_arrays("_encstr_B47919BDB2372AB7926B180963CF50EB05A0ABD5F8AE16A25F4F4B", "_encstr_8735110AD37043BE78399061E1E903E3836992", _encstr_917238EE104EE89391F66FC7900728E80B4715602929D1930D2333BFFD1743A9614B1263498BC710F7A1F8D83A4D13EFC848BB03534BF229EFD8::main);
}

pavelow_boss_health_bar(var_0) {
  for(;;) {
    while([[var_0]]())
      waitframe();

    self notify("_encstr_8F5C086405E70FBA4B4A");
    waitframe();
  }
}

_id_11DEA() {
  if(!isDefined(level.player))
    return 1;

  var_0 = level.player.origin[0] < -720;
  var_1 = level.player.origin[1] > -60;
  var_2 = level.player.origin[1] < 330;

  if(!isDefined(level._id_124B8)) {
    if(var_0 && var_1 && var_2)
      level._id_124B8 = 1;
  }

  if(istrue(level._id_124B8)) {
    if(!var_0 || !var_1 || !var_2) {
      level._id_124B8 = 0;
      return 0;
    }
  }

  return 1;
}

_id_11DCB() {
  setdynamicdvar("_encstr_8C851703DE2317BFA33002B968E576AB98B5B581E0E807C669", 0);
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (45, -617, 330), (0, 81, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  register_create_script_arrays("_encstr_B4C12678D3AFF558DD9F775BC642F033C31AF103C9A72E0832B07F6FE22F5005B7F18BA983276798", "_encstr_82670A6D9FF7A9AAD022B0CA", _runmovequestlocale::main);
  var_1 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-56, -587, 333));
  var_2[0].angles = (90, 0, 0);
  var_2[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-56, -715, 333));
  var_2[1].angles = (90, 0, 0);
  var_2[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16, -760, 333));
  var_2[2].angles = (90, 90, 0);
  var_2[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (144, -760, 333));
  var_2[3].angles = (90, 90, 0);
  var_2[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (16, -523, 333));
  var_2[4].angles = (90, 90, 0);
  var_2[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (144, -760, 333));
  var_2[5].angles = (90, 39.786, -82.713);
  var_2[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (144, -523, 333));
  var_2[6].angles = (90, 90, 0);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);

  var_6 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = [];
  var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (21, -565, 268));
  var_7[0].angles = (0, 326.9, 0);
  var_7[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (35, -543, 268));
  var_7[1].angles = (0, 326.9, 0);

  foreach(var_4 in var_7)
  var_4 clonebrushmodeltoscriptmodel(var_6);
}

_id_11DED(var_0, var_1) {
  if(var_1 == "_encstr_A1790BD0BB7517785F6EB4BD6A" || var_1 == "_encstr_8E4708C12DE8D834AC27") {
    var_2 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (1874, 1198.75, 8), (0, 182.4, 0));
    scripts\mp\spawnlogic::bdiedonce([var_2]);

    if(var_0 == "_encstr_A59306426009CA07") {
      init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
      register_create_script_arrays("_encstr_A60826BA63C0A3EA183FEFE54538B51FF039B2D3EEA2936460A3DFFB55E0BED3ADD66B4AD30B231B", "_encstr_A99329CB60D9A83EB30919430217F9882DCF536D277B5806B742738BFFCF26E80721C9CBBF62804EF72B8B", _safecircledurationforplayer::main);
    }

    if(var_0 == "_encstr_AA1C072756CC63ACF0" && _tablethide::_id_13D4C()) {
      register_create_script_arrays("_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4", "_encstr_8EA42808A3DFA5610AF545591D7099E4CFEA81F6FA634848E3C54BB31291303667C23B3943DF1640FAB4", _encstr_8D1548208A2213CB1BA34069984E50CB0A134A2853B191666BDDFCD165FBD08B72790831CB57FDD8EFD8685C79F7C1271D92D9C8D3ED33B19BD70ECE55EF2B2BC26A08901B43FD09E713::main);
      level._id_142A6 = 275;
      level._id_142A7 = 2.25;
      thread _id_13D6D();
    }
  }

  if(var_1 == "_encstr_AC1F058B9EABE0") {
    var_2 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2896, 1480, 16), (0, 35, 0));
    scripts\mp\spawnlogic::bdiedonce([var_2]);
    register_create_script_arrays("_encstr_ACE5239DD3169B698E1078F80DBBD1CFD2D58F5B6B312041EBC06A0141CBE531F18BCFE8AD", "_encstr_A6332480EB39191E336534397DC3C6D1DAC26810710A6BD147B74E2E55CFEB4B428A48B01B23", _phonemorsesinglescriptableused::main);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    thread setupsoccerball();
    var_3 = getEntArray("_encstr_B467106BF150B77BD928A55ADBFF0370B699", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_5 in var_3)
    var_5 delete();

    thread _id_11DEC();
  }
}

setupsoccerball() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEnt("_encstr_8B1E11ED62E2F0BEF8B98D4092C89937F89A30", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getentitylessscriptablearrayinradius("_encstr_9B100BC45ACE7D19BDB727AFB1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getentitylessscriptablearrayinradius("_encstr_8B100B4C5A3BFA327BF627EBC9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_88FB0EB747F77057E86989396945BBA8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEnt("_encstr_8DDE0F8CF6DB931BBD36C6FA4EA5CE0DE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_1[0] setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_B2A210EDC8B3EFA1A991730B5881A2B749A5");
  var_2[0] setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_B1241001D763117F5A395870F2F71D299F45");
  waitframe();

  while(var_3.origin != var_1[0].origin && var_4.origin != var_2[0].origin) {
    var_3.origin = (var_1[0].origin[0], var_1[0].origin[1], var_1[0].origin[2]);
    var_4.origin = (var_2[0].origin[0], var_2[0].origin[1], var_2[0].origin[2]);
    waitframe();
  }
}

_id_11DEC() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEntArray("_encstr_A1FD101B7B738EB0A53795397D6BED235936", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_B685146CBD73D12CA5DC9593F5C67B8DC64BCDA5B7B9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_0) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 clonebrushmodeltoscriptmodel(var_1);
  }
}

_id_11DDA() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-21478, 25049, -338), (0, 0, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  level._id_13D5B = 1;
  register_create_script_arrays("_encstr_A3282FC06B175DF04507B3A321AAB8A36F23D989826716F8DE069BFF5C92B8670B6911136A9FCDF879E9DFDF737AF0B7B3", "_encstr_A55C1698F3211B53877A36AB7FFB7B93169AF081ABC67769", _setclientkillstreakindexes::main);
}

_id_11DE1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-1108, -88, -84), (0, 28, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-906.97, 138.623, -5.5239), (0, 271, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_ADED3C2B372098408BE9F3031E233818963E5E8D98BE91E946A91393C292B2D39F2632C2AD53EBC1FAF32A63727603C35B08FBE3BA2D48C7EF36028218EF");
  init_nuke_vault((-923.97, 202.123, -54.7739), (345, 180, 0.000108306), undefined, undefined, "_encstr_8EF4120387DA5772B528A25C906463B05F38F38F");
  init_nuke_vault((-909.97, 132.123, -27.7739), (286.245, 316.609, -46.8203), undefined, undefined, "_encstr_AFAB29F4436AF793A8273F2F59C0FF580A096EBA7B409FFBFD0F3727B1F8A720A211E642F3C85DD2580B33");
  init_nuke_vault((-905.72, 147.123, 2.9761), (359.382, 271.507, -13.7324), undefined, undefined, "_encstr_B48F26CC7B52CFBBB33FF7D3AB66922110CB924398F8B9E316493FA3B9982A68E88BBDDCC9FA12AF");
  init_nuke_vault((-909.97, 148.123, -29.2739), (288.531, 318.307, -48.1768), undefined, undefined, "_encstr_91925AEA9363FF5AF82FEBCB4FF8E703EEC94633D81FF39278A7E0CD7F402CDF9BE14BAB815A3F4D30AFFBEF3F58F2FF35FBC302204F0F02B097ECDF15607A62C5F66B2AB3ABF73A78F353A2CBC0424B80CB93D11B72D734E8FD02A9");
  init_nuke_vault((-909.22, 166.623, -29.7739), (287.755, 321.101, -51.1163), undefined, undefined, "_encstr_AB2B3F28DB30F1BF3367E3FF97FAF0F257A431A1C0DFB065AB7FDBE7EFA2C83A8F1CB939AA2B102C316FC7EBD37AAD5A3BE2E370166B50D1EAAFCB97DF72588A5F");
  init_nuke_vault((481.28, -380.877, -34.0239), (287.755, 321.101, -51.1163), undefined, undefined, "_encstr_BA090ED4634AD742CFC7BBABA36F5A77");
  thread _id_11DE2();
  register_create_script_arrays("_encstr_88B727B61CEBADF58EC959CD360DEB36932B85A395AF6EB19C961CA3BE9D5D9BCDEDCD36B473AC0B39", "_encstr_88B727B61CEBADF58EC959CD360DEB36932B85A395AF6EB19C961CA3BE9D5D9BCDEDCD36B473AC0B39", _onmatchstartbr::main);
  thread _id_13A69();
}

_id_11DE2() {
  level endon("_encstr_B8D80D131723B292AB2759B2975BA0");
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  level.player scripts\mp\equipment::giveequipment("_encstr_843D095F2B7D52B041D9A3", "_encstr_BA7F0830B3A7859B60B0");
  scripts\mp\trials\mp_trl_cleararea::_id_12A8E();
}

_id_11DD1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-596, 1455, 654), (0, 194, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  level._id_125CB = 1;
  level._id_13D83 = 120;
  thread _id_124A1();
  register_create_script_arrays("_encstr_AFAC26F5A351CD72A7475B2F6BC19903C0E96E3BB9F983EAFE635B53D77CF2778093E442F0504E02", "_encstr_AFAC26F5A351CD72A7475B2F6BC19903C0E96E3BB9F983EAFE635B53D77CF2778093E442F0504E02", _maphint_cheesescriptableused::main);
  thread _id_121EA();
  var_1 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-528.607, 1465.99, 608));
  var_2[10].angles = (0, 9.6, 0);
  var_2[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-523.27, 1434.44, 608));
  var_2[11].angles = (0, 9.6, 0);
  var_2[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-528.607, 1465.99, 672));
  var_2[12].angles = (0, 9.6, 0);
  var_2[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-523.27, 1434.44, 672));
  var_2[13].angles = (0, 9.6, 0);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);

  var_6 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = [];
  var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-606.269, 1493.43, 676));
  var_7[0].angles = (0, 9.6, 90);
  var_7[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-732.48, 1472.1, 676));
  var_7[1].angles = (0, 9.6, 90);
  var_7[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-588.936, 1390.89, 676));
  var_7[2].angles = (0, 9.6, 90);
  var_7[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-715.141, 1369.55, 676));
  var_7[3].angles = (0, 9.6, 90);

  foreach(var_4 in var_7)
  var_4 clonebrushmodeltoscriptmodel(var_6);

  var_10 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = [];
  var_11[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-561.497, 1468.55, 732));
  var_11[0].angles = (0, 9.6, 0);
  var_11[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-553.493, 1421.21, 732));
  var_11[1].angles = (0, 9.6, 0);
  var_11[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-632.484, 1456.54, 732));
  var_11[2].angles = (0, 9.6, 0);
  var_11[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-624.482, 1409.22, 732));
  var_11[3].angles = (0, 9.6, 0);
  var_11[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-695.597, 1445.87, 732));
  var_11[4].angles = (0, 9.6, 0);
  var_11[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-687.595, 1398.55, 732));
  var_11[5].angles = (0, 9.6, 0);
  var_11[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-758.695, 1435.21, 732));
  var_11[6].angles = (0, 9.6, 0);
  var_11[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-750.696, 1387.88, 732));
  var_11[7].angles = (0, 9.6, 0);

  foreach(var_4 in var_11)
  var_4 clonebrushmodeltoscriptmodel(var_10);

  var_14 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = [];
  var_15[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-218, -543, 713));
  var_15[0].angles = (0, 270, 0);
  var_15[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-248, -387, 713));
  var_15[1].angles = (0, 0, 0);
  var_15[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-440, -387, 713));
  var_15[2].angles = (0, 0, 0);

  foreach(var_4 in var_15)
  var_4 clonebrushmodeltoscriptmodel(var_14, 1);

  var_18 = getEnt("_encstr_83AF0AC0361ED0412A46EDE1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_19 = [];
  var_19[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-432, 451, 713));
  var_19[0].angles = (0, 0, 0);
  var_19[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-22, -2083, 705));
  var_19[1].angles = (0, 0, 0);
  var_19[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (50, -2128, 705));
  var_19[2].angles = (0, 270, 0);

  foreach(var_4 in var_19)
  var_4 clonebrushmodeltoscriptmodel(var_18, 1);

  var_22 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-790.916, 1433.82, 692));
  var_22.angles = (89.9991, 161.295, 151.702);
  var_22.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
  var_22 clonebrushmodeltoscriptmodel(var_10);
  var_23 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-781.584, 1378.61, 692));
  var_23.angles = (89.9991, 161.295, 151.702);
  var_23.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
  var_23 clonebrushmodeltoscriptmodel(var_10);
  thread _id_11DD0();
}

_id_121EA() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_A23112597B2207D89F1E83F9C38D0949FA8BE3E1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 clonebrushmodeltoscriptmodel(var_0);
  }
}

_id_11DD0() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  var_0 = getEntArray("_encstr_BD7A0E9B5140479B9AFF2FB162D8CB0D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = loadfx("_encstr_958334D999F0E5D2DD1CBEDA075ED1E44B16B1E65ECD0E2B95914C858DC6CBCE330FF51D2796C2C6DCEB4BDA07F536B12C9717ECCC3C");

  foreach(var_3 in var_0)
  var_3 thread setupstartweaponsattachments(var_1);

  thread get_dist_to_closest_player();
}

get_dist_to_closest_player() {
  while(!isDefined(level.cratedata.usablecrates))
    waitframe();

  while(isDefined(level.cratedata.usablecrates)) {
    foreach(var_1 in level.cratedata.usablecrates) {
      if(isDefined(var_1))
        var_1 scripts\cp_mp\killstreaks\airdrop::makecrateunusable();

      if(isDefined(var_1.headicon))
        var_1 scripts\cp_mp\killstreaks\airdrop::_destroyheadicon();

      if(isDefined(var_1.minimapid))
        var_1 scripts\cp_mp\killstreaks\airdrop::destroyminimapicon();
    }

    waitframe();
  }
}

setupstartweaponsattachments(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = scripts\engine\utility::get_target_ent();
  var_3 setCanDamage(1);
  var_3 waittill("_encstr_B2BE0788BAF573592F", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);
  playFX(var_0, var_7);
  playsoundatpos(var_7, "_encstr_B140237CED4056A3B87342ABDE05CFCA58BBF4CF4598DA67D68BE902C0D767492003996BE9");
  var_18 = scripts\cp_mp\killstreaks\airdrop::dropkillstreakcrate(undefined, level.player.team, undefined, var_1, var_2, undefined);
  var_18.nevertimeout = 1;
  self delete();
  var_3 delete();
}

_id_124A1() {
  _tablethide::waittill_player_isDefined();

  while(!isalive(level.player))
    waitframe();

  level.player scripts\mp\equipment::giveequipment("_encstr_92620B68531B9B432F2AE8D61B", "_encstr_BA7F0830B3A7859B60B0");

  while(isalive(level.player)) {
    var_0 = level.player scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");
    var_1 = level.player scripts\mp\equipment::getequipmentammo(var_0);

    if(var_1 != 1)
      level.player scripts\mp\equipment::setequipmentammo(var_0, 1);

    wait 0.5;
  }
}

_id_11DDB(var_0) {
  if(var_0 == "_encstr_83AD0559672E3A") {
    var_1 = getEntArray("_encstr_BDBB0616C6C186C2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && var_3.script_gameobjectname == "_encstr_8CA606F38878410D")
        var_3 delete();
    }

    var_5 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-1158.9, -233.964, 48.5), (0, 44.097, 0));
    scripts\mp\spawnlogic::bdiedonce([var_5]);
    var_6 = getEnt("_encstr_BE640C27815BCF8A9ACB0B8AA8D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1008.48, -122.919, 89.482));
    var_7.angles = (90, 226, 0);
    var_7.targetname = "_encstr_811118DB084BCE2366BDF20DDE0827579F4803E1182FC57B5EA9";
    var_7 clonebrushmodeltoscriptmodel(var_6);
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1049.24, -84.752, 89.411));
    var_8.angles = (90, 226, 0);
    var_8.targetname = "_encstr_921118A38613D2A426701337F0985F4AC790AA91E6B7BAFC4E28";
    var_8 clonebrushmodeltoscriptmodel(var_6);
    var_9 = getEnt("_encstr_A74C1173D3804F6727091A8211F4C78970A7E4", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_10 = [];
    var_10[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-842, 367, -2));
    var_10[0].angles = (0, 90, 0);
    var_10[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-598, 343, -2));
    var_10[1].angles = (0, 65, 0);
    var_10[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (113, -132, -2));
    var_10[2].angles = (0, 90, 0);
    var_10[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (118, -341, -2));
    var_10[3].angles = (0, 90, 0);
    var_10[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1632, -371, 295));
    var_10[4].angles = (0, 90, 0);
    var_10[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0.826, -522, -2));
    var_10[5].angles = (0, 90, 0);
    var_10[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-49.043, -520, -2));
    var_10[6].angles = (0, 90, 0);
    var_10[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-49.169, -520.725, 54));
    var_10[7].angles = (0, 90, 0);
    var_10[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-405.75, -1325.75, -4));
    var_10[8].angles = (0, 271, 0);
    var_10[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (219, -1298, 3));
    var_10[9].angles = (0, 223, 0);
    var_10[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (256, -1489, 3));
    var_10[10].angles = (0, 180, 0);
    var_10[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (256, -1539, 3));
    var_10[11].angles = (0, 180, 0);
    var_10[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (256, -1539, 58));
    var_10[12].angles = (0, 180, 0);
    var_10[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1017.97, -60.04, -10.566));
    var_10[13].angles = (15, 226.013, 0);
    var_10[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-985.725, -91.156, -10.564));
    var_10[14].angles = (15, 226.013, 0);
    var_10[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1124, -1146, 0.695871));
    var_10[15].angles = (0, 90, 0);

    foreach(var_12 in var_10)
    var_12 clonebrushmodeltoscriptmodel(var_9);

    var_14 = getEnt("_encstr_919109AA5148539DA0FDAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_15 = [];
    var_15[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1144.19, -305.643, 137));
    var_15[0].angles = (0, 225.756, 0);
    var_15[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1099.54, -259.762, 137));
    var_15[1].angles = (0, 225.756, 0);
    var_15[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1054.9, -213.881, 137));
    var_15[2].angles = (0, 225.756, 0);
    var_15[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1010.25, -168, 137));
    var_15[3].angles = (0, 225.756, 0);
    var_15[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1046.25, -92, 137));
    var_15[4].angles = (0, 315.756, 0);
    var_15[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1015.25, -122, 137));
    var_15[5].angles = (0, 315.756, 0);
    var_15[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-149.25, -524, 162));
    var_15[6].angles = (0, 90, 0);

    foreach(var_12 in var_15)
    var_12 clonebrushmodeltoscriptmodel(var_14, 1);

    if(_tablethide::_id_13D4C())
      thread _id_13D6D();

    register_create_script_arrays("_encstr_88CE2B2B7FF725668FE72E500ECAC7E8B9AF53BD420F9D2F911F9FBA06D5DF11D90212FA7DA2B6B21EDBD38194", "_encstr_8B252470C2BF8848DA4F1DDD9382AD485C91DB2B2CE9F8AFA26B2FD7EBC9E3E8CFB5E123565C", _maphint_phonescriptableused::main);
  } else {
    init_nuke_vault((-381.5, -1669, 41), (360, 327.999, -90.0002), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    var_5 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-542, -1731, 60), (0, 33, 0));
    scripts\mp\spawnlogic::bdiedonce([var_5]);
  }
}

_id_11DE8(var_0) {
  if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_A1790BD0BB7517785F6EB4BD6A") {
    var_1 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-79, 1355, -160), (0, 270, 0));
    scripts\mp\spawnlogic::bdiedonce([var_1]);
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
    register_create_script_arrays("_encstr_BD3F27ADE0AF1DC9D8EBECD5379B36A5DC9D5939AFB556D6BDE4CBF536932B85E8CA7DB9C64E4B381D", "_encstr_A3852950E25FA03ECA6FD7CB9303094B36BFD9CB41DCB0F6926FF9CF92A9C693D59663A1F92368AE2A23E1", _setclientkillstreakavailability::main);
    var_2 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_3 = [];
    var_3[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (55, 1316, -178));
    var_3[0].angles = (0, 90, -90);
    var_3[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-168, 1316, -178));
    var_3[1].angles = (0, 90, -90);
    var_3[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-105, 1259, -178));
    var_3[2].angles = (0, 0, -90);
    var_3[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (23, 1259, -178));
    var_3[3].angles = (0, 0, -90);

    foreach(var_5 in var_3)
    var_5 clonebrushmodeltoscriptmodel(var_2);

    var_7 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_8 = [];
    var_8[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-64.726, 1250.21, -230.99));
    var_8[0].angles = (0, 0, 0);
    var_8[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-96.726, 1250.21, -230.99));
    var_8[1].angles = (0, 0, 0);

    foreach(var_5 in var_8)
    var_5 clonebrushmodeltoscriptmodel(var_7);
  } else if(level.trial["_encstr_BDBB0ED696CD37D2F6B96AD84E2D38A3"] == "_encstr_AFDD05A6AB763B") {
    var_1 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-66, 190, -237), (0, 45, 0));
    scripts\mp\spawnlogic::bdiedonce([var_1]);
    var_11 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (102, 358, -237));
    var_11.angles = (0, 0, 0);
    var_11.targetname = "_encstr_A6D617A3395A858DFAA9AE3B9D5927E62CD53AFA6CE4161D59";
    init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  }
}

_id_11DC6() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-24702, -5429, -283), (1, 281, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  level.localeid = "_encstr_B234099C2FE8AE4B4DEE4F";
  register_create_script_arrays("_encstr_BA4318C863FF137D5259B6C8ED3A93793AABD120D7A7AB138AFF", "_encstr_9ADB1AD6E0EB31DE3756972C938CF5B3BBFA8E9C96851BAF4E0B6CAC", _proximitywatcher::main);
  var_1 = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = [];
  var_2[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27937, -4290, -249));
  var_2[0].angles = (0, 0, 90);
  var_2[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28065, -4290, -249));
  var_2[1].angles = (0, 0, 90);
  var_2[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28193, -4290, -249));
  var_2[2].angles = (0, 0, 90);
  var_2[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28314, -4325, -249));
  var_2[3].angles = (0, 32.299, 90);
  var_2[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28364, -4429, -249));
  var_2[4].angles = (0, 97.096, 90);
  var_2[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28349, -4555, -249));
  var_2[5].angles = (0, 97.096, 90);
  var_2[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28156, -6667, -33));
  var_2[6].angles = (359.997, 270.09, 90);
  var_2[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28169, -6795, -33));
  var_2[7].angles = (359.997, 258.19, 90);
  var_2[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28246, -7060, -10));
  var_2[8].angles = (0, 115.295, 90);
  var_2[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28228, -7177, -10));
  var_2[9].angles = (359.999, 76.392, 90);
  var_2[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28289, -7281, -10));
  var_2[10].angles = (359.997, 44.392, 90);
  var_2[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27391, -6955, 48));
  var_2[11].angles = (359.994, 346.289, 90);
  var_2[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27519, -6948, 48));
  var_2[12].angles = (359.995, 7.488, 90);
  var_2[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27568, -7018, 48));
  var_2[13].angles = (359.995, 280.19, 90);
  var_2[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27496, -7076, 48));
  var_2[14].angles = (359.995, 355.491, 90);
  var_2[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27369, -7086, 48));
  var_2[15].angles = (359.995, 355.491, 90);
  var_2[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27310, -7032, 48));
  var_2[16].angles = (359.995, 280.19, 90);
  var_2[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27115.6, -6828, 10.677));
  var_2[17].angles = (22.45, 90, -2.439);
  var_2[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26989.7, -6824.39, 15.419));
  var_2[18].angles = (22.45, 90, -2.439);
  var_2[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26710, -6607, 83));
  var_2[19].angles = (359.994, 286.688, 90.001);
  var_2[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26640, -6662, 83));
  var_2[20].angles = (359.996, 6.286, 90.001);
  var_2[21] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26459, -6950, 182));
  var_2[21].angles = (359.997, 280.19, -179.996);
  var_2[22] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26376, -6931, 182));
  var_2[22].angles = (359.997, 280.19, -179.996);
  var_2[23] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26377.4, -7490.33, 82.251));
  var_2[23].angles = (24.389, 276.924, -1.632);
  var_2[24] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26388.4, -7406.33, 121.349));
  var_2[24].angles = (24.389, 276.924, -1.632);
  var_2[29] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26401, -7329, 91));
  var_2[29].angles = (359.999, 7.688, 90);
  var_2[30] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25099, -7301, -112));
  var_2[30].angles = (359.997, 297.287, 90);
  var_2[31] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25092, -5424, -97));
  var_2[31].angles = (359.999, 304.389, 90);
  var_2[32] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24344, -5754, -262));
  var_2[32].angles = (359.997, 282.79, 90);
  var_2[33] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24300, -5870, -262));
  var_2[33].angles = (359.996, 300, 90);
  var_2[34] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24238, -5981, -262));
  var_2[34].angles = (0, 300, 90);
  var_2[35] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23664, -6961, -285));
  var_2[35].angles = (359.994, 291.99, 90);
  var_2[36] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23614, -7079, -285));
  var_2[36].angles = (359.994, 291.99, 90);
  var_2[37] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23575, -7168, -285));
  var_2[37].angles = (359.994, 291.99, 90);
  var_2[40] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27083.3, -8893.63, 7.683));
  var_2[40].angles = (359.288, 351.421, 90.068);
  var_2[41] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27066.3, -8913.63, 7.683));
  var_2[41].angles = (359.288, 351.421, 90.068);
  var_2[42] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23939.1, -7485.67, -256));
  var_2[42].angles = (359.288, 211.399, 90.068);
  var_2[43] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24720.7, -5348.8, -310));
  var_2[43].angles = (359.997, 10.9986, 4);
  var_2[44] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24693.3, -5473.4, -310));
  var_2[44].angles = (359.997, 10.9986, 4);
  var_2[45] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24652.1, -5466.65, -270));
  var_2[45].angles = (89.9974, 8.9699, -2.02922);
  var_2[46] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24676.6, -5341.02, -270));
  var_2[46].angles = (89.9974, 8.9699, -2.02922);
  var_2[47] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24767.2, -5356.59, -270));
  var_2[47].angles = (89.9974, 8.9699, -2.02922);
  var_2[48] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24732.7, -5284.8, -270));
  var_2[48].angles = (359.997, 10.9986, 89.9995);
  var_2[49] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24695.3, -5473.4, -212));
  var_2[49].angles = (359.997, 10.9986, 4);
  var_2[50] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24718.7, -5348.8, -212));
  var_2[50].angles = (359.997, 10.9986, 4);
  var_2[51] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24742.9, -5482.27, -270));
  var_2[51].angles = (89.9974, 8.9699, -2.02922);
  var_2[52] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24684.7, -5530.8, -270));
  var_2[52].angles = (359.997, 10.9986, 89.9995);
  var_2[52].targetname = "_encstr_B6ED09E248106379A867AC";
  var_2[55] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24750.9, -5482.27, -270));
  var_2[55].angles = (89.9974, 8.9699, -2.02922);
  var_2[56] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24775.2, -5356.59, -270));
  var_2[56].angles = (89.9974, 8.9699, -2.02922);
  var_2[57] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24648.1, -5466.65, -270));
  var_2[57].angles = (89.9974, 8.9699, -2.02922);
  var_2[58] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24672.6, -5341.02, -270));
  var_2[58].angles = (89.9974, 8.9699, -2.02922);

  foreach(var_4 in var_2)
  var_4 clonebrushmodeltoscriptmodel(var_1);

  var_6 = getEnt("_encstr_83170D7338BBBB0C13C8330F897C6C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_7 = [];
  var_7[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23745, -7335, -293));
  var_7[0].angles = (0, 242.697, 90);
  var_7[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23783.1, -7418.76, -293));
  var_7[1].angles = (0, 232.597, 90);
  var_7[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-23859.1, -7496.76, -268));
  var_7[2].angles = (344.471, 202.69, 87.974);
  var_7[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27502.1, -6962.76, 21));
  var_7[3].angles = (0, 242.697, 90);
  var_7[4] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28209.1, -6693.76, -62));
  var_7[4].angles = (0, 173.095, 90);
  var_7[5] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28218.1, -6813.76, -62));
  var_7[5].angles = (0, 168.296, 90);
  var_7[6] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28267.1, -7071.76, -42));
  var_7[6].angles = (0, 206.297, 90);
  var_7[7] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28224.1, -7140.76, -33));
  var_7[7].angles = (0, 257.797, 90);
  var_7[8] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28237.1, -7216.76, -33));
  var_7[8].angles = (0, 257.797, 90);
  var_7[9] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27877.1, -4693.76, -270));
  var_7[9].angles = (0, 263.996, 90);
  var_7[10] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27896.1, -4251.76, -273));
  var_7[10].angles = (0, 263.996, 90);
  var_7[11] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27964.1, -4251.76, -278));
  var_7[11].angles = (0, 263.996, 90);
  var_7[12] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28032.1, -4240.76, -278));
  var_7[12].angles = (0, 263.996, 90);
  var_7[13] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28166.1, -4240.76, -278));
  var_7[13].angles = (0, 263.996, 90);
  var_7[14] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28282.1, -4227.76, -278));
  var_7[14].angles = (0, 313.694, 90);
  var_7[15] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-28372.1, -4262.76, -278));
  var_7[15].angles = (0, 308.594, 90);
  var_7[16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26688.1, -6594.76, 50));
  var_7[16].angles = (0, 191.496, 90);
  var_7[17] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26581.1, -6651.76, 45));
  var_7[17].angles = (0, 219.896, 90);
  var_7[18] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-27140.1, -8950.76, 1));
  var_7[18].angles = (0, 219.896, 90);
  var_7[19] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25962.1, -7874.76, -6));
  var_7[19].angles = (0, 216.295, 90);
  var_7[20] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25047.1, -5431.76, -103));
  var_7[20].angles = (0, 210.658, 90);
  var_7[21] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-25057.1, -7311.76, -140));
  var_7[21].angles = (0, 206.358, 90);
  var_7[22] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-26581.1, -6651.76, 45));
  var_7[22].angles = (0, 219.896, 90);

  foreach(var_4 in var_7)
  var_4 clonebrushmodeltoscriptmodel(var_6);

  var_10 = getEnt("_encstr_96D00D8D63B41C99C8E1331987668C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_11 = [];
  var_11[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24736.2, -5370.59, -316));
  var_11[0].angles = (0, 11.098, 0);
  var_11[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24740.6, -5348.02, -316));
  var_11[1].angles = (0, 11.098, 0);
  var_11[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-24746.2, -5319.57, -316));
  var_11[2].angles = (0, 11.098, 0);

  foreach(var_4 in var_11)
  var_4 clonebrushmodeltoscriptmodel(var_10);

  var_14 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_15 = [];

  foreach(var_4 in var_15)
  var_4 clonebrushmodeltoscriptmodel(var_14);

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == level.trial["_encstr_A67009D77B23ABF02883D0"])
    thread _id_13D27();
}

_id_13D27() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEnt("_encstr_86D70AC81F2EE8E012E7BF8D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_A1DC0B152B72B391C801C81583", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_9A6E09F23882F75D615092", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_B6ED09E248106379A867AC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  while(!isalive(level.player))
    waitframe();

  wait 34;
  var_4 = scripts\mp\utility\outline::outlineenableforplayer(var_2, level.player, "_encstr_8294137D0BA3CC0AA05BF7539DDB7234B1103347A0", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
  var_2 setHintString(&"_encstr_BE0711ADD75F4047E4816777B19D1FB8F9C5E5");
  var_2 setCursorHint("_encstr_BA110C6847D07307ADF8103C97A0");
  var_2 sethintdisplayrange(200);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(120);
  var_2 sethintonobstruction("_encstr_BD1805CB69C063");
  var_2 setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  var_2 makeusable();
  var_2 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_2 makeunusable();
  scripts\mp\utility\outline::outlinedisable(var_4, var_2);
  var_3 notsolid();
  var_0 rotateby((0, 260, 0), 2.5);
  var_1 rotateby((0, -260, 0), 2.5);
  var_0 playsoundonmovingent("_encstr_99C61AE8392DB036EB6E66E1AF197BBD9CBEE89CEAB1D6BEB1AC33D1");
  var_1 playsoundonmovingent("_encstr_95D41B63465392E4660803435139AF3A3D48EB9AADEF8A0F2B300F0B60");
}

_id_11DF1() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-1222, -2462, 386), (0, 53, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((-998, -2305, 412), (0, 0, -93), "_encstr_9180182D6ABF31F9F14B38A8D21685EB0FE5B3A7DC7FBB3B25F2", "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  init_nuke_vault((-1015, -2284, 459), (0, 141, 0), "_encstr_9180182D6ABF31F9F14B38A8D21685EB0FE5B3A7DC7FBB3B25F2", undefined, "_encstr_87C119D277E0FAD80BD7B54BD6B2CCC8CA662C9BE89CACD8DE0B91");
  init_nuke_vault((-1025, -2280, 430), (297, 117, 125), "_encstr_9180182D6ABF31F9F14B38A8D21685EB0FE5B3A7DC7FBB3B25F2", undefined, "_encstr_8C71345448288727488FBEB63F2B272A609F6EF5D72368EB80E0806FD3D6300F6E12DFF0D7EEB1AE5293D17A1BC2A91BA242E240AD8B");
  init_nuke_vault((-998, -2302, 431), (290, 1.6, -163), "_encstr_9180182D6ABF31F9F14B38A8D21685EB0FE5B3A7DC7FBB3B25F2", undefined, "_encstr_BA090ED4634AD742CFC7BBABA36F5A77");
  init_nuke_vault((-1011, -2289, 432), (288.4, 116, 23), "_encstr_9180182D6ABF31F9F14B38A8D21685EB0FE5B3A7DC7FBB3B25F2", undefined, "_encstr_8AE738A5BB70EBDCA1F5C9BDDA95B783CD1865B5CA1B952BACA1BDD8B79995B947DED8D6DC95D99C5AC1D9569CA30E93B7951385E4B986ED4E3A");
  level._id_12489 = "_encstr_843D095F2B7D52B041D9A3";
  level._id_1248A = 1;
  level._id_124C9 = 1;
  level._id_13D3F = 1;
  level._id_13D41 = 1;
  thread scripts\mp\trials\mp_trl_cleararea::init_trap_room_debug();
  register_create_script_arrays("_encstr_B40527DA38AFCE2DB1B158CEAC647DD8B1562C4EE834B2C29395167D364E9516472B7D6ED89C5A07E8", "_encstr_889C1F6BE0EBD9B48D8DB03BB2C8F51D4EA516B1D7B1632B85C93AD056169CAC0B", _encstr_AA39475BEFB874F30D53B69A5BC8DF2E83778FDD21297B5F39A82A22C19E1EE558476E518118C65F554BC16A081D5F9A90B1F5A115080EF70EBB7A7213656F92902D613861BAD79F26::main);
}

_id_11DE3() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (1188, -1459, 872), (0, 209, 0));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  init_nuke_vault((0, 0, 0), (0, 0, 0), undefined, "_encstr_A97B16C923CC580459AB13DE56216B70A8F6D3D5CAAF987A", "_encstr_87610AB4EE83FAD6374B3395");
  level._id_13D2F = 1;
  register_create_script_arrays("_encstr_86FF18BDF726779C192822DA595F1217595D3D178E49DBA40970", "_encstr_86FF18BDF726779C192822DA595F1217595D3D178E49DBA40970", _ontabletgiven::main);
}

_id_11DEE() {
  if(_tablethide::_id_13D4C())
    thread _id_13D6D();

  if(level.trial["_encstr_B6A208B3C2275AC2B9E8"] == "_encstr_9B720BE3D59B3A44E8B00A5469") {
    var_0 = getEnt("_encstr_815E0C7F0B2A8702B0C0DA9BABC6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_1 = [];
    var_1[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1792, 852, 8));
    var_1[0].angles = (0, 0, 0);
    var_1[1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1906, 852, 8));
    var_1[1].angles = (0, 0, 0);
    var_1[2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1906, 1562, 8));
    var_1[2].angles = (0, 0, 0);
    var_1[3] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (1786, 1562, 8));
    var_1[3].angles = (0, 0, 0);

    foreach(var_3 in var_1)
    var_3 clonebrushmodeltoscriptmodel(var_0);
  }
}

_id_11DD2() {
  var_0 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-2470.23, 4496.36, 707.14), (359.983, 231.857, 0.0086689));
  scripts\mp\spawnlogic::bdiedonce([var_0]);
  level._id_13D5B = 1;
  register_create_script_arrays("_encstr_B23719B26BC8FFB268BBF0EDF5617E7B0DE19BBA16B6AFAA4B810C", "_encstr_B23719B26BC8FFB268BBF0EDF5617E7B0DE19BBA16B6AFAA4B810C", _encstr_998E3868C26A2BF3D37B98A150969883526B12108B497BAB57913FAD0AEEC06971927818325AA3CBCFBBC69531AB096F221AC8C0BBF37DB947A3::main);
}

register_create_script_arrays(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.scripted_spawner_func_strings[level.scripted_spawner_func_strings.size] = var_0;

  if(isDefined(var_1))
    level.scripted_spawner_map_strings[level.scripted_spawner_func_strings.size] = var_1;

  level.create_script_file_ids[var_0] = "_encstr_8A0703D983" + level.scripted_spawner_func.size;

  if(isDefined(var_2))
    level.scripted_spawner_func[level.scripted_spawner_func.size] = var_2;
}

init_nuke_vault(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);

  if(isDefined(var_1))
    var_5.angles = var_1;

  if(isDefined(var_2))
    var_5.script_gameobjectname = var_2;
  else
    var_5.script_gameobjectname = "_encstr_8CA606F38878410D";

  if(isDefined(var_3))
    var_5.script_noteworthy = var_3;

  var_5.targetname = "_encstr_811F0DF09B396191B1E3859F3AEACD";
  var_5.script_parameters = var_4;
  return var_5;
}

_id_13A69() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = scripts\engine\utility::getStructArray("_encstr_B83C0C8CA29A3D09A35BDAFD7F23", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in level.course_targets) {
    var_3 = scripts\engine\utility::getclosest(var_2.origin, var_0, 32);

    if(isDefined(var_3)) {
      var_4 = strtok(var_3.script_noteworthy, "_encstr_BE4C0295");

      foreach(var_6 in var_4) {
        var_7 = strtok(var_6, "_encstr_AB4C0246");

        switch (var_7[0]) {
          case "_encstr_B2CE0BA1D0FB19FDC54613D9BF":
            var_2.targetname = var_7[1];
            break;
          case "_encstr_A5770D6369C5044F315953997BF082":
            var_2.script_speed = float(var_7[1]);
            break;
          default:
            break;
        }
      }
    }
  }
}

target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking))
    waitframe();

  var_0 = ["_encstr_8AE12A8D20CF571B40BB044815B77693D367B705D8C298087226A84C2BDFB290D1A3C5C19F3865A56A0EF12F", "_encstr_85E12A56B2EBAD4B1B5AD1C2C95EF59B86BDBD1D4B37CEFA4E589BD9ACEBE0C60BD1CAF5B2E695B52FD76023", "_encstr_ADE12A7982AF7980DDA95173DAC0693EDB9AB0C3AA93A4F972B91D67F5A1D809A743492EF23BED5048AFA9C7", "_encstr_B4E12AAC2BBE6B9636D2A3589CBC7D9B1ADEBD1DA5B9CEFA3958DCB32BBE071B2C1DB2F5CA73AC6BCBF50C0D", "_encstr_B6E12AA19520E09BD9C7345FCDB10EA809AAE7248073AC76C6AF58DF7B49C7D5C163F99060866D2D79F712FE", "_encstr_A6E12A5659BEB6A5C6B44785E4F2EBCD1ADBBDD196DCD9BEC985B93BB2EB1CB1583A59FAB2DCCAAD2FEB1863"];
  var_1 = ["_encstr_959F2DE7BBC0BA0163704B160BF06F1323D7473B0BF0C2FF1859C59F81E9881A0F49171F87AB9BB1D0A03EA5FE6AF1", "_encstr_A29F2D562BF55B5AC6963A169C5E7D9BA1B77B1D4B73ECF5E458373BB2FA1C8D2C8EACEB6C5A6796C65A16B9FA8191", "_encstr_B19F2D59CABE5B4BD8A5D158C9CBF5CD347BB7D15A9BB37D4E58E6D92BF51CD8B0E8AC7D365A9D4BD8B42CB9AF6033"];
  var_2 = ["_encstr_87CE289595BE6B968D2D1DB093F2F5E634B7F6A32DDC9DEBE416B93B2BBE8336851DCAAF2657631BACD1", "_encstr_A3AC2B0D9DC192EBF2DBE3B00383998F509F0F63BA25BF2E3D8705C16767131307A838BE12C36DCB5213B90B87", "_encstr_ACAC2BE36F312769F83B70C3F2712F4FEAF85863FA48B0D7EA4F4678AA50B189D22BA50721BB39CC3F9308290A", "_encstr_91AC2B2DC76943B8FC2F2070BB11B6B7C2ED902D5C122F26CA27F848CF1F2BD1FAD31D20F61BF188856B69EA8E"];

  if(istrue(level._id_13D87)) {
    var_0 = [];
    var_1 = [];
    var_0 = ["_encstr_B2B42D48DAB8551C3C480B6E5B10811A788D2209EA024A81B057558F3A3FB092A914CD36713AA03D33BF21EA612B2B", "_encstr_84BA2DF08A093BC85B99CD4F7AF7F6CF2CB228C0E21D57460BB9D8B445475BA9D6EBE0115AB59BD87F9FFF1667F3E3", "_encstr_8DC42D6FA290FBC83D727337AB9A0FFE6BF7C753204E720973E9356FE25903928993BFA0E7C04A118947575221BA22", "_encstr_918A2D9559BEB6B41BA5A3C239CBAF3786BDDE8E4BB93BBE9C16DC9D95BEC11BB0D1CABECAB9565B97F5C086D79137", "_encstr_A3902DAF875FCA398AA3CCA14DF229F34858DF09E3A03731327ABDA7AFE18B78C3F18D11399BF2F9A0D9871DF1EB9B", "_encstr_8B9A2D5956D75B5A1BD2472C932FF5B934DBBDD14BE63B7D39589BEC59EBE0B158472B7D2BE659DABCFA031BF5C8E6"];
    var_1 = ["_encstr_A71330C778BE35CAB9D3732E467B61D3A0C0770BA03077D1DDFFFDA7250FCB842980D71F9888BE7AC983061DAFB9176FD110", "_encstr_8E0D30957FD1FB3074B7A80833890E3F4A6518A5D49AA7BE32AF60C07797A349624B85B82E425DA004E71080B79033F75A32", "_encstr_8F0530CA59D76B96364B1D169397AFDC34ED7BD1A537CEAFC98573EC2BFA38D8B04759BED85AD95A8DD2C2B9FA1833D7C89B"];
  }

  var_3 = scripts\engine\utility::array_randomize(level.enemy_targets);
  var_4 = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(var_6 in var_3) {
    var_6.bullet_decal = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.plate.origin);
    var_6.bullet_decal.angles = var_6.plate.angles;
    var_6.bullet_decal linkTo(var_6.plate);

    if(isDefined(var_6.script_parameters))
      var_6.plate setModel(var_6.script_parameters);
  }

  foreach(var_6 in var_3) {
    var_9 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(var_3, var_6));
    var_10 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9));
    var_11 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9), var_10));
    var_12 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_2, var_9.bullet_decal.model), var_10.bullet_decal.model), var_11.bullet_decal.model);

    if(!isDefined(var_6.script_parameters)) {
      var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_0, var_9.plate.model), var_10.plate.model), var_11.plate.model);
      var_6.plate setModel(scripts\engine\utility::random(var_13));
    }

    var_6.bullet_decal setModel(scripts\engine\utility::random(var_12));
  }

  foreach(var_16 in var_4) {
    var_9 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(var_4, var_16));
    var_10 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_4, var_16), var_9));

    if(isDefined(var_16.script_parameters)) {
      var_16.plate setModel(var_16.script_parameters);
      continue;
    }

    var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_1, var_9.plate.model), var_10.plate.model);
    var_16.plate setModel(scripts\engine\utility::random(var_13));
  }
}

mindia_exterior_sfx() {
  while(!isDefined(level.struct_class_names))
    waitframe();

  var_0 = getEnt("_encstr_B4DA12D235D3336CF6109BB7A8E923A9814EDC4F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_BEAA0C9B582723BB1F24BB1FAB51", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A");
  var_2 = 0;

  for(;;) {
    foreach(var_4 in var_1) {
      if(isDefined(var_4.script_noteworthy)) {
        if(int(var_4.script_noteworthy) == var_2) {
          var_4 playSound("_encstr_81AB1D61BC027FE33BE8AB72C013DDC780A8E3E556D337AFF90BD38A3949D3");
          playFXOnTag(level._id_14297, var_4, "_encstr_91080625AFF390DF");
        }
      }
    }

    wait 0.5;
    var_2++;
  }
}

player_isusingtacmap(var_0, var_1, var_2) {
  level._effect["_encstr_82C70C43753B9AE479132DB50870"] = loadfx("_encstr_A2F02785F3EBF86817E22968CDD0D206321B2BAFDB721BC1367D51DBF797D8C9EAE7E7B3235EE43050");
  level._effect["_encstr_A2690CA383FC6B20CFDE8977A24F"] = loadfx("_encstr_A3BE32E3B7484A834B9E1789CF03DD18FB5D091B5AB7684FE6F38DA90FDA1D398926B15106F688688AA3FB851F41C78216FB59CA");

  while(!isDefined(level.struct_class_names))
    waitframe();

  var_3 = scripts\engine\utility::getStructArray("_encstr_AC860D4BB0F9AA8A5F5EF36A45CF53", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
    var_6.angles = var_5.angles;
    var_6 setModel("_encstr_AFB6134733B07113B9C3BB2B4FD41AB15019714B28");
    var_5.player_is_at_buy_station = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
    var_5.player_is_at_buy_station.angles = var_5.angles;
    var_5.player_is_at_buy_station setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_5.player_is_at_buy_station linkTo(var_6, "_encstr_AD830C4716EC7D334B4E56D7CC3C", (0, 0, -1.75), (0, 180, 0));

    if(istrue(var_1)) {
      var_5._id_1341F = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.origin);
      var_5._id_1341F.angles = var_5.angles;
      var_5._id_1341F setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_5._id_1341F linkTo(var_6, "_encstr_AD830C4716EC7D334B4E56D7CC3C", (1, 0, 0), (90, 0, 0));
    }
  }

  for(;;) {
    if(istrue(var_2)) {
      _tablethide::waittill_player_isDefined();

      while(level.player getvelocity() == 0)
        waitframe();
    } else
      level waittill(var_0);

    foreach(var_5 in var_3) {
      playFXOnTag(level._effect["_encstr_A2690CA383FC6B20CFDE8977A24F"], var_5.player_is_at_buy_station, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      if(istrue(var_1))
        playFXOnTag(level._effect["_encstr_82C70C43753B9AE479132DB50870"], var_5._id_1341F, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }

    if(istrue(var_2))
      level waittill("_encstr_ABA008615A631510C7EA");

    _tablethide::trial_ui_waittill_retry();

    foreach(var_5 in var_3) {
      stopFXOnTag(level._effect["_encstr_A2690CA383FC6B20CFDE8977A24F"], var_5.player_is_at_buy_station, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

      if(istrue(var_1))
        stopFXOnTag(level._effect["_encstr_82C70C43753B9AE479132DB50870"], var_5._id_1341F, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  }
}

_id_13D6D() {
  level._effect["_encstr_979611CC5DF0E67368A183DB0EDC4B5E78EB43"] = loadfx("_encstr_8B5731ECBE3B38333B6F099003C5F16B972179E65F4F3B73E582787A7BAFA1865BF770D1719F43A34E49D068220543703B7603");
  level._effect["_encstr_B2A117D37BFFE730993B9BFB5C3DE1BED7F30E19023729A0AA"] = loadfx("_encstr_AAF22DB38843B214C7E0FA414063E154C019309B17D38AFFE08B80C1CFFE137750B8317F936B8924371E8886CB3673");
  level._effect["_encstr_A99C168E932DB0B1BEE834CA395BB4A356EB3139EDE6D32B"] = loadfx("_encstr_9AFD36CECC3CCBB4EE70FAD6E05E1DC95AC21BE65E6EABB6AD2B27CBD9330F7D8EFAD8561BB289F599B1C2B656EB98E4B7E64FAC5C9D331E");
  level._effect["_encstr_A6E416D8DA275AB8C1B44BEF2348AB039DC0A8AC748B6533"] = loadfx("_encstr_A37B361B0D834ED108AA71C59BF2F453D39BFBF777AE539DB069325DB35030D9354F5F2749DD6A773050EED5C9C163728165CFE3A5FCF218");
  level._effect["_encstr_8A6C143AE496C2B1BE8E432B935B5AE8ACEBCE7BC646"] = loadfx("_encstr_8202340BB1F03FDF0397B04113B5056571F35BAB2F6B2DE73FF5902ADE80E079D3D81ABB1CEF0286D6335F7A0A6E1A07DD2D08F30231");
  level._effect["_encstr_AF0D18BDFA2FA14941AA88C8E2262DF9339948387FABC89BF2D2"] = loadfx("_encstr_9A282FEC3387F22DDD07F55B385EE8C9D2C2C69BE59BAEDA5B569C97D93387FA1D7DB0377695C66636B027CA6E716766C3");
  level._effect["_encstr_BED10CDEF387B922F9781FB34072"] = loadfx("_encstr_81A92E7E340ABEA4173219C2488F1F3FAD2DE0ECDF72F6ABEDC801FA501717C3790E7DA76E183F73AD286A12DA6DCFCB");
  level._id_13D6C = 1;

  while(!isDefined(level.player))
    waitframe();

  while(!isalive(level.player))
    waitframe();

  thread get_wave_spawn_count();
  level._id_13D9B = getEntArray("_encstr_97080D8E394B2C63EB99C6C2DACA9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_13D9B)) {
    wait 5;

    foreach(var_1 in level._id_13D9B) {
      if(istrue(level._id_13D68))
        playFXOnTag(scripts\engine\utility::getfx("_encstr_B2A117D37BFFE730993B9BFB5C3DE1BED7F30E19023729A0AA"), var_1, "_encstr_91080625AFF390DF");
      else
        playFXOnTag(scripts\engine\utility::getfx("_encstr_979611CC5DF0E67368A183DB0EDC4B5E78EB43"), var_1, "_encstr_91080625AFF390DF");

      var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  }
}

get_wave_spawn_count() {
  level._id_13D2A = getEntArray("_encstr_911C19447342666D56A8AB82F93AB231534B473510E2543A1ABF4B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13D3C = getEntArray("_encstr_A99E118E932DB0B1BECA37C8AF99360B27ACB9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(level._id_142A6))
    level._id_14298 = level._id_142A6;
  else
    level._id_14298 = 750;

  if(isDefined(level._id_142A7))
    level._id_142AB = level._id_142A7;
  else
    level._id_142AB = 1.75;

  for(;;) {
    level._id_13D7F = undefined;
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");

    if(istrue(level._id_13D2E)) {
      level._id_13D7F = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");

      if(level._id_13D7F == 0) {
        level.player playsoundtoplayer("_encstr_8182144A40DFE1BF6390577CA04947355FB032838875", level.player);
        level._id_13D7F = 0;
        continue;
      }
    } else {
      while(!isDefined(level.score["_encstr_BE7D0633C08849E2"]))
        waitframe();

      if(level.trial["_encstr_95480A37B1ED9C5915BC1C95"] == "_encstr_84EF055338A18F") {
        if(level.score["_encstr_BE7D0633C08849E2"] <= level.trial["_encstr_966C066BF011B2F7"])
          level._id_13D7F = 3;
        else if(level.score["_encstr_BE7D0633C08849E2"] <= level.trial["_encstr_876C06B1FF0A66F2"])
          level._id_13D7F = 2;
        else if(level.score["_encstr_BE7D0633C08849E2"] <= level.trial["_encstr_816C069599555DA7"])
          level._id_13D7F = 1;
        else {
          level.player playsoundtoplayer("_encstr_8182144A40DFE1BF6390577CA04947355FB032838875", level.player);
          level._id_13D7F = 0;
          continue;
        }
      } else if(level.score["_encstr_BE7D0633C08849E2"] >= level.trial["_encstr_966C066BF011B2F7"])
        level._id_13D7F = 3;
      else if(level.score["_encstr_BE7D0633C08849E2"] >= level.trial["_encstr_876C06B1FF0A66F2"])
        level._id_13D7F = 2;
      else if(level.score["_encstr_BE7D0633C08849E2"] >= level.trial["_encstr_816C069599555DA7"])
        level._id_13D7F = 1;
      else {
        level.player playsoundtoplayer("_encstr_8182144A40DFE1BF6390577CA04947355FB032838875", level.player);
        level._id_13D7F = 0;
        continue;
      }
    }

    foreach(var_1 in level._id_13D2A) {
      if(isDefined(var_1.script_noteworthy) && float(var_1.script_noteworthy) <= level._id_13D7F)
        var_1 thread _id_13D58(var_1.script_noteworthy);
    }

    if(level._id_13D7F == 3) {
      wait 3;
      level.player playsoundtoplayer("_encstr_A9ED10D7309B162BD8F7D3D5F7D698A8C043", level.player);

      foreach(var_4 in level._id_13D3C)
      var_4 thread movequestcircle();
    }

    wait 4;

    foreach(var_1 in level._id_13D2A) {
      if(istrue(var_1.player_is_exposed))
        var_1 stoploopsound();
    }
  }
}

movequestcircle() {
  if(isDefined(self.script_noteworthy))
    wait(float(self.script_noteworthy) * 0.5);

  if(isDefined(self.target)) {
    if(self.target == "_encstr_BED10CDEF387B922F9781FB34072") {
      var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_91080625AFF390DF") + (0, 0, 25));
      var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_0.angles = self.angles;
      waitframe();
      playFXOnTag(scripts\engine\utility::getfx("_encstr_BED10CDEF387B922F9781FB34072"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_0 moveTo(var_0.origin + (0, 0, level._id_14298), level._id_142AB);
      var_0 playsoundonmovingent("_encstr_B4BF18ECDBE6AF99D2C9B2BBB7395BFA9BD8272BC2ADFA37CCE1");
      self playSound("_encstr_84891787C7AEE176404BA72BED70B3390D4163235FC06B2EF0");
      wait 4;
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_BED10CDEF387B922F9781FB34072"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  } else {
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AF0D18BDFA2FA14941AA88C8E2262DF9339948387FABC89BF2D2"), self, "_encstr_91080625AFF390DF");
    self playSound("_encstr_B1F41110871769A12AEE1B95C972D1D1827748");
  }
}

_id_13D58(var_0) {
  if(isDefined(var_0))
    wait(float(var_0));

  if(isDefined(self.target))
    wait(float(self.target));

  playFXOnTag(scripts\engine\utility::getfx(proptiebreaker()), self, "_encstr_91080625AFF390DF");
  self playSound("_encstr_84891787C7AEE176404BA72BED70B3390D4163235FC06B2EF0");
  self.player_is_exposed = 1;

  if(isDefined(var_0) && var_0 == "_encstr_934C0218" && level._id_13D7F >= 3) {
    wait 2;
    playFXOnTag(scripts\engine\utility::getfx(proptiebreaker()), self, "_encstr_91080625AFF390DF");
  }
}

proptiebreaker() {
  switch (level._id_13D7F) {
    case 1:
      var_0 = "_encstr_A99C168E932DB0B1BEE834CA395BB4A356EB3139EDE6D32B";
      break;
    case 2:
      var_0 = "_encstr_A6E416D8DA275AB8C1B44BEF2348AB039DC0A8AC748B6533";
      break;
    case 3:
      var_0 = "_encstr_8A6C143AE496C2B1BE8E432B935B5AE8ACEBCE7BC646";
      break;
    default:
      var_0 = "_encstr_A99C168E932DB0B1BEE834CA395BB4A356EB3139EDE6D32B";
      break;
  }

  return var_0;
}