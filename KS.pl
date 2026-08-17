% Systima Diagnosis Sakxarodi Diabiti Me Proteinomeni Therapeia 

% Metaxioti Maria TP4324 

% Knowledge System - Systima Gnosis  

 

%Gia na treksoume to programma mas kaloume ?-server(8000). 

 

%Libraries 

:- use_module(library(http/thread_httpd)).											                             

:- use_module(library(http/http_dispatch)). 

:- use_module(library(http/http_session)).											                             

:- use_module(library(http/http_error)).											                               

:- use_module(library(http/html_write)).                                                    

:- use_module(library(http/http_client)). 

:- use_module(library(http/http_parameters)). 

 

%IMPORTANT: Change Path! 

%:- working_directory(CWD,'/Users/mariametaxioti/Desktop/'). 

 

%Handlers 

:- http_handler('/', main_page,[]).   

:- http_handler('/diagnosis', diagnosis,[]).  

:- http_handler('/update', update,[]).  

:- http_handler('/result', result,[]). 

:- http_handler('/add', add,[]). 

:- http_handler('/added', addedR,[]). 

:- http_handler('/edit', edit,[]). 

:- http_handler('/edited', editedR,[]). 

:- http_handler('/delete', deleteR,[]). 

:- http_handler('/deleted', deletedR,[]). 

:- http_handler('/save', saveR,[]). 

 

%IMPORTANT: Change Path! 

%Onoma tou arxeiou pou periexei tin vasi gnosis 

:-['/Users/mariametaxioti/Desktop/kb.pl']. 

:-style_check(-singleton).     

 

%Server 

server(Port) :-                                                                              

  http_server(http_dispatch, [port(Port)]). 

 

%Main Page 

main_page(_Request) :-    					 

reply_html_page(		                                                                       

    title('Σύστημα Διάγνωσης Σακχαρώδους Διαβήτη - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Καλώς ορίσατε στο Σύστημα Διάγνωσης Σακχαρώδους Διαβήτη(ΔιαΘεΣΔια).'), 

h3('Μενού: '), 

form([action='/diagnosis', method='GET'], 					                            

[ p([], input([name=submit, type=submit, value='Διάγνωση'], [])) ]), 

form([action='/update', method='GET'], 					                            

[ p([], input([name=submit, type=submit, value='Ενημέρωση Βάσεως      Γνώσης'], [])) ]) 

  ] 

). 

 

%Diagnosis Page 

diagnosis(Request) :- 					                                       

  reply_html_page(		                                                                       

    title('Διάγνωση - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Διάγνωση Σακχαρώδους Διαβήτη: '), 

form([action='/result', method='POST'], 						                             

[ p([], [label([for=a],'Υπάρχουν αισθητά συμπτώματα; (yes/no) : '),				select([id=a,name=symptomata],[option(yes),option(no)])]),	                                                 

p([], [label([for=b],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει πολυουρία;      [yes/no/καμία απάντηση(unknown)] : '), select([id=b,name=polyouria],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=c],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει πολυδιψία; [yes/no/καμία απάντηση(unknown)] : '), 

        select([id=c,name=polydipsia],[option(unknown),option(yes), option(no)]) ]), 

p([], [ label([for=d],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει απρόσμενη απώλεια βάρους; [yes/no/καμία απάντηση(unknown)] : '),   select([id=d,name=apoleiavarous],[option(unknown),option(yes), option(no)]) ]), 

p([], [						                                           

       label([for=e],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει κόπωση; [yes/no/καμία απάντηση(unknown)] : '),			                         select([id=e,name=koposi],[option(unknown),option(yes), option(no)])]),		                                                 

p([], [ label([for=f],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει θολή όραση; [yes/no/καμία απάντηση(unknown)] : '), select([id=f,name=tholiorasi],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [  label([for=g],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχει αίσθηση μουδιάσματος ή μυρμήγκιασμα στα πόδια ή τα χέρια; [yes/no/καμία απάντηση(unknown)] : '),   select([id=g,name=moudiasma],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=h],'Εάν υπάρχουν αισθητά συμπτώματα, υπάρχουν πληγές που δεν επουλώνονται; [yes/no/καμία απάντηση(unknown)] : '),    select([id=h,name=pliges],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=i],'Εάν δεν υπάρχουν αισθητά συμπτώματα, είναι το εξεταζόμενο άτομο υπέρβαρο ή παχύσαρκο; | Υπολογισμός: {βάρος(kg)/[ύψος(cm)]^2}*10.000  Υπέρβαρος: 25,0=<Αποτέλεσμα=<29,9  Παχύσαρκος: Αποτέλεσμα>=30,0 |  [yes/no/καμία απάντηση(unknown)] : '),						                          select([id=i,name=ypervarospaxisarkos],[option(unknown),option(yes), option(no)])]),									                                             p([], [label([for=j],'Εάν δεν υπάρχουν αισθητά συμπτώματα, είναι το εξεταζόμενο άτομο 45 ετών και άνω; [yes/no/καμία απάντηση(unknown)] : '),  select([id=j,name=hlikiaanw45],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=k],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο οικογενειακό ιστορικό Σακχαρώδους Διαβήτη; [yes/no/καμία απάντηση(unknown)] : '),  select([id=k,name=oikogeneiakoistoriko],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=l],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο υψηλή αρτηριακή πίεση; [yes/no/καμία απάντηση(unknown)] : '),  select([id=l,name=ypsiliartiriakipiesi],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=m],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο χαμηλά επίπεδα HDL(«καλής») χοληστερόλης ή υψηλά επίπεδα από τριγλυκερίδια; [yes/no/καμία απάντηση(unknown)] : '), select([id=m,name=xamilihdlypsilatriglykeridia],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=n],'Εάν δεν υπάρχουν αισθητά συμπτώματα, είναι το εξεταζόμενο άτομο σωματικά μη ενεργό; (yes/no/καμία απάντηση) : '),   select([id=n,name=swmatikamienergos],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=o],'Εάν δεν υπάρχουν αισθητά συμπτώματα και εάν το εξεταζόμενο άτομο είναι γένους θηλυκού, υπάρχει ιστορικό Διαβήτη κύησης ή έχει γεννήσει μωρό που να ζύγιζε 4 κιλά και άνω; [yes/no/καμία απάντηση(unknown)] : '),	                     select([id=o,name=istorikodiavitikiisisimwropanwapo4kila],[option(unknown),option(yes), option(no)])]),							 

p([], [ label([for=p],'Εάν δεν υπάρχουν αισθητά συμπτώματα και εάν το εξεταζόμενο άτομο είναι γένους θηλυκού, έχει Σύνδρομο Πολυκιστικών Ωοθηκών; [yes/no/καμία απάντηση(unknown)] : '),      select([id=p,name=syndromopolykistikwnoothikwn],[option(unknown),option(yes), option(no)]) ]), 

p([], [ label([for=q],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο ιστορικό καρδιακών παθήσεων ή εγκεφαλικού; [yes/no/καμία απάντηση(unknown)] : '), select([id=q,name=istorikokardiakwnpathisewniegkefaliko],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=r],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο κατάθλιψη; [yes/no/καμία απάντηση(unknown)] : '),  select([id=r,name=katathlipsi],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=s],'Εάν δεν υπάρχουν αισθητά συμπτώματα, έχει το εξεταζόμενο άτομο μελανίζουσα ακάνθωση; [yes/no/καμία απάντηση(unknown)] : '), select([id=s,name=melanizousaakathonsi],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [   label([for=t],'Προβείτε στην διεξαγωγή εξετάσεων πλάσματος γλυκόζης νηστείας. Σε ποιά κατηγορία ανήκουν οι τιμές των αποτελεσμάτων; 

        	 [first(Αποτελέσματα=<99) / second(100=<Αποτελέσματα=<125) / third(126=<Αποτελέσματα)  / καμία απάντηση(unknown)] : '), select([id=t,name=prwtoselegxos],[option(unknown),option(first), option(second), option(third)]) 

            ]), 

p([], [ label([for=x],'Προβείτε στην διεξαγωγή εξετάσεων πλάσματος γλυκόζης νηστείας για επαλήθευση. Σε ποιά κατηγορία ανήκουν οι τιμές των αποτελεσμάτων; 

        	 [first(Αποτελέσματα=<99) / second(100=<Αποτελέσματα=<125) / third(126=<Αποτελέσματα) / καμία απάντηση(unknown)] : '), select([id=x,name=deuteroselegxos],[option(unknown),option(first), option(second), option(third)]) 

            ]), 

p([], [  label([for=y],'Προβείτε στην διεξαγωγή εξετάσεων παρουσίας κετόνων στα ούρα. Είναι έντονη (δείκτης>=2+); [yes/no/καμία απάντηση(unknown)] : '),  select([id=y,name=entoniparousiaketonwnoura],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], [ label([for=z],'Προβείτε στην διεξαγωγή εξετάσεων παρουσίας αυτοαντισωμάτων νησίδων Αυτά είναι: ICA, GADA, IA-2A και ZnT8A. Υπάρχουν ενδείξεις για την παρουσία τους ή έστω ένος απο τα παραπάνω; [yes/no/καμία απάντηση(unknown)] : '),    select([id=z,name=parousiaautoantiswmatwnnisidwn],[option(unknown),option(yes), option(no)]) 

            ]), 

p([], input([name=submit, type=submit, value='Διάγνωση'], [])) ]), 

form([action='/', method='GET'], 	                            

[ p([], input([name=submit, type=submit, value='Άκυρο'], [])) ]) 

  	] 

). 

 

%Reply for Diagnosis page 

result(Request) :-  

reply_html_page(title('Αποτελέσματα - ΔιαΘεΣΔια'), []), 

       format('<p><h3><center>'), 

member(method(post), Request), !, 

http_read_data(Request, Data, []), 

getAnswer(values((Data.symptomata, Data.polyouria, Data.polydipsia, Data.apoleiavarous, Data.koposi,	Data.tholiorasi, Data.moudiasma, Data.pliges, Data.ypervarospaxisarkos, Data.hlikiaanw45,				Data.oikogeneiakoistoriko, Data.ypsiliartiriakipiesi, Data.xamilihdlypsilatriglykeridia, 							Data.swmatikamienergos, Data.istorikodiavitikiisisimwropanwapo4kila, Data.syndromopolykistikwnoothikwn,						Data.istorikokardiakwnpathisewniegkefaliko, Data.katathlipsi, Data.melanizousaakathonsi,						Data.prwtoselegxos, Data.deuteroselegxos,						Data.entoniparousiaketonwnoura, Data.parousiaautoantiswmatwnnisidwn)), Answer), 

write(Answer), 

            format('<br/><br/>'), 

            format('<a href="/"><button>Αρχικό Μενού</button></a>'), 

            format('</center></p></h3>'). 

 

%Predicate for Diagnosis Result 

getAnswer(values((Symptomata, Polyouria, Polydipsia, ApoleiaVarous, Koposi, TholiOrasi, Moudiasma, Pliges, YpervarosPaxisarkos, HlikiaAnw45, OikogeneiakoIstoriko, YpsiliArtiriakiPiesi, XamiliHDLYpsilaTriglykeridia, SwmatikaMiEnergos, IstorikoDiavitiKiisisIMwroPanwApo4Kila, SyndromoPolykistikwnOothikwn, IstorikoKardiakwnPathisewnIEgkefaliko, Katathlipsi, MelanizousaAkanthosi, PrwtosElegxos, DeuterosElegxos, EntoniParousiaKetonwnOura, ParousiaAutoantiswmatwnNisidwn)), Answer):- 

rule(Rid, values((Symptomata, Polyouria, Polydipsia, ApoleiaVarous, Koposi, TholiOrasi, Moudiasma, Pliges, YpervarosPaxisarkos, HlikiaAnw45, OikogeneiakoIstoriko, YpsiliArtiriakiPiesi, XamiliHDLYpsilaTriglykeridia, SwmatikaMiEnergos, IstorikoDiavitiKiisisIMwroPanwApo4Kila, SyndromoPolykistikwnOothikwn, IstorikoKardiakwnPathisewnIEgkefaliko, Katathlipsi, MelanizousaAkanthosi, PrwtosElegxos, DeuterosElegxos, EntoniParousiaKetonwnOura, ParousiaAutoantiswmatwnNisidwn)), Answer); 

    % No rule can be applied 

 (Answer='Τα αποτελέσματα της συγκεκριμένης περίπτωσης δεν υποστηρίζονται απο την τρέχουσα έκδοση. / The results to this case are currently not supported by this version.'). 

 

%Update KB Menu Page 

update(_Request) :-   					                                       

  reply_html_page(		                                                                       

    title('Ενημέρωση Βάσεως Γνώσης - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Μενού Ενημέρωσης Βάσεως Γνώσης: '), 

form([action='/add', method='GET'], 								[ p([], input([name=submit, type=submit, value='Προσθήκη Κανόνα'], [])) ]), 

form([action='/edit', method='GET'], 						                            

[ p([], input([name=submit, type=submit, value='Επεξεργασία Κανόνα'], [])) ]), 

form([action='/delete', method='GET'], 	                            

[ p([], input([name=submit, type=submit, value='Διαγραφή Κανόνα'], [])) ]), 

form([action='/save', method='GET'], 							[ p([], input([name=submit, type=submit, value='Αποθήκευση'], [])) ]), 

form([action='/', method='GET'],                       

[ p([], input([name=submit, type=submit, value='Άκυρο'], [])) ])] 

). 

 

%Add Rule Page 

add(Request):- 					                                       

  reply_html_page(		                                                                       

    title('Προσθήκη Κανόνα - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Προσθήκη Νέου Κανόνα: '), 

form([action='/added', method='POST'], 						                           

[  

p([], [ 

        label([for=a],'Δώστε τα δεδομένα του κανόνα : '),  

input([name=rdata, type=textarea]) 

            ]),	 

p([], [ 

        label([for=c],'Δώστε την απάντηση του κανόνα : '), 

        input([name=answer, type=textarea]) 

            ]), 

p([], input([name=submit, type=submit, value='Προσθήκη'], [])) ]), 

form([action='/update', method='GET'], 						                            

[ p([], input([name=submit, type=submit, value='Άκυρο'], [])) ]) 

  ] 

). 

 

%Add Rule Reply Page 

addedR(Request):- 

  reply_html_page(title('Προσθήκη Κανόνα - ΔιαΘεΣΔια'), []), 

member(method(post), Request), !, 

http_read_data(Request, Data, []), 

addRule(Data.rdata, Data.answer), 

format('Η Προσθήκη Κανόνα ολοκληρώθηκε με επιτυχία! '), 

format('<a href="/update"><button>Επιστροφή</button></a>'). 

 

%Edit Rule Page 

edit(Request) :-    									                                       

  reply_html_page(		                                                                       

    title('Επεξεργασία Κανόνα - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Επεξεργασία υπάρχοντος κανόνα: '), 

form([action='/edited', method='POST'], 						  

[  

p([], [							                                           

        label([for=a],'Δώστε το ID του κανόνα : '),				                                 

input([name=id, type=textarea])				                                   

]), 

p([], [ 

        label([for=b],'Δώστε τα νέα δεδομένα του κανόνα : '), 

        input([name=rdata, type=textarea]) 

            ]),			 

p([], [ 

        label([for=d],'Δώστε την νέα απάντηση του κανόνα : '), 

        input([name=answer, type=textarea]) 

            ]), 

p([], input([name=submit, type=submit, value='Επεξεργασία'], [])) ]), 

form([action='/update', method='GET'], 	                            

[ p([], input([name=submit, type=submit, value='Άκυρο'], [])) ]) 

  ] 

). 

 

%Edit Rule Reply Page	 

editedR(Request):- 

  reply_html_page(title('Επεξεργασία Κανόνα - ΔιαΘεΣΔια'), []), 

member(method(post), Request), !, 

http_read_data(Request, Data, []), 

editRule(Data.id, Data.rdata, Data.answer), 

format('Ο κανόνας ενημερώθηκε με επιτυχία! '), 

format('<a href="/update"><button>Επιστροφή</button></a>').	 

 

%Delete Rule Page 

deleteR(Request) :- 					                                       

  reply_html_page(		                                                                       

    title('Διαγραφή Κανόνα - ΔιαΘεΣΔια'),	                                                                     

    [	 

h2('Διαγραφή κανόνα: '), 

form([action='/deleted', method='POST'], 						                             

[ p([], [											                                           

        label([for=a],'Δώστε το ID του κανόνα: '),						                                 

input([name=id, type=textarea])						                                   

]),									                                                 

p([], input([name=submit, type=submit, value='Διαγραφή'], [])) ]), 

form([action='/update', method='GET'], 				                            

[ p([], input([name=submit, type=submit, value='Άκυρο'], [])) ]) 

  ] 

). 

 

%Delete Rule Reply Page 

deletedR(Request):- 

 reply_html_page(title('Διαγραφή Κανόνα - ΔιαΘεΣΔια'), []), 

member(method(post), Request), !, 

http_read_data(Request, Data, []), 

deleteRule(Data.id), 

format('Ο κανόνας διαγράφτηκε επιτυχώς! '), 

format('<a href="/update"><button>Επιστροφή</button></a>'). 

 

%Save Rule Reply Page	 

saveR(Request):- 

  http_parameters(Request, [], [form_data(Form) ]),			 

      style_check(-singleton), 

      	saveKB, /*kaleitai gia na apothikeusei ta nea apotelesmata*/ 

  reply_html_page(title('Αποθήκευση Βάσεως Γνώσης - ΔιαΘεΣΔια'), 

  format('Το αρχείο της Βάσεως Γνώσης αποθηκεύτηκε επιτυχώς! ')  

   ), 

  format('<a href="/update"><button>Επιστροφή</button></a>'). 

 

%!!!!! IMPORTANT!!!!!!! Change Destination before consulting! 

/** 

 * saveKB/0 

 */ 

saveKB :-  

          tell('/Users/mariametaxioti/Desktop/kb.pl'), 

listing(rules/1), 

listing(max_ruleID/1), 

listing(rule/3), 

          told. 

 

%Delete rule predicate 

deleteRule(RID) :-  

                % Delete rule 

                Head = rule(RID, Data, Answer), 

                clause(Head, Body), 

                retract((Head :- Body)), 

                % Update Rids list 

                rules(RIDs), 

                deleteFromList(RID, RIDs, NewRIDs), 

                retract(rules(RIDs)), 

                asserta(rules(NewRIDs)). 

 

%Add Rule predicate 

addRule(Data, Answer) :-  

           max_ruleID(ID),	 

           NewID is ID+1, 

           atom_concat('rID', NewID, RID), 

           retract(max_ruleID(ID)),	 

           asserta(max_ruleID(NewID)),	 

           % Update Rids list 

           rules(RIDs), 

           append(RIDs, [RID], NewRIDs), 

           retract(rules(RIDs)), 

           asserta(rules(NewRIDs)), 

           % Load new rule to memory 

term_string(AData, Data),	 

           assertz(rule(RID, values(AData), Answer)). 

 

%Edit Rule Predicate 

editRule(RID, NewData, NewAnswer) :-  

                % Delete existing rule 

                Head = rule(RID, Data, Answer), 

                clause(Head, Body), 

                retract((Head :- Body)), 

                % New data 

                term_string(UData, NewData), 

                assertz((rule(RID, values(UData), NewAnswer))). 

 

 

/** 

 * deleteFromList/3 

 * deleteFromList(+X, +L, -NewL). 

 * 

 * Delete X from list L and generate list NewL. 

 */ 

deleteFromList(_, [], []). 

 

deleteFromList(H, [H|T], L) :- deleteFromList(H, T, L). 

 

deleteFromList(X, [H|T1], [H|T2]) :- deleteFromList(X, T1, T2), 

                                     X \== H. 