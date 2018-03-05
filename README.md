**<span style="font-size: 16.0pt; font-family: 'Times New Roman','serif';">Devoir 4</span>**

**<span style="font-size: 16.0pt; font-family: 'Times New Roman','serif';">CSI2520 Paradigmes de programmation</span>**

**<span style="font-family: 'Times New Roman','serif';">Hiver 2018</span>**

**<span style="font-family: 'Times New Roman','serif';">A remettre le 6 Mars (Q1+Q2) et le 2 Avril (Q3+Q4) avant 23:00 sur le Campus Virtuel</span>**

**<span style="font-size: 16.0pt; font-family: 'Times New Roman','serif';">[12 points]</span>**

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

<span style="font-family: 'Times New Roman','serif';">La Ville d’Ottawa doit maintenir et inspecter de nombreuses infrastructures. Les inspecteurs de la Ville doivent ainsi régulièrement visiter différentes installations à travers la Ville. Votre mission est donc de les aider à établir un parcours de visite. Nous recherchons ici un parcours raisonnable, c’est-à-dire un parcours pas trop long permettant de visiter tous les sites. Nous ne demandons pas de trouver le chemin optimal.</span><span style="font-family: 'Times New Roman','serif';"></span>

<span style="font-family: 'Times New Roman','serif';"> </span>

<span style="font-family: 'Times New Roman','serif';">Notre solution simplifiée procèdera donc comme suit :</span>

*   <span style="font-family: 'Times New Roman','serif';">Construction d’un arbre général (nombre arbitraire d’enfants par noeud) :</span>
    *   <span style="font-family: 'Times New Roman','serif';">Trier les emplacements à visiter d’ouest en est.</span>
    *   <span style="font-family: 'Times New Roman','serif';">L’emplacement le plus à l’ouest sera à la racine de l’arbre.</span>
    *   <span style="font-family: 'Times New Roman','serif';">Chaque emplacement est ajouté à l’arbre comme enfant du nœud géographiquement le plus proche.</span>
    *   <span style="font-family: 'Times New Roman','serif';">Pour ce faire, il faut donc calculer la distance (en km) entre un emplacement à ajouter  et tous les nœuds se trouvant dans l’arbre courant. Utiliser la distance à vol d’oiseau, i.e. ignorer les routes.</span>
*   <span style="font-family: 'Times New Roman','serif';">Construction du parcours</span>
    *   <span style="font-family: 'Times New Roman','serif';">Parcourir l’arbre résultant de facon pré-ordre.</span>
    *   <span style="font-family: 'Times New Roman','serif';">La liste des noeuds ainsi parcourus constitue donc le parcours recherché. Calculer la distance cumulative de la visite de noeuds en nœuds.</span>

<span style="font-family: 'Times New Roman','serif';"> </span>

<span style="font-family: 'Times New Roman','serif';">Utiliser le fichier JSON ci-joint afin de tester cette approche. Ce fichier contient l’emplacement de toutes les pataugeoires de la Ville. Ces emplacements sont specifiés par leur coordonnées GPS (longitude et latitude).</span>

<span style="font-family: 'Times New Roman','serif';">Votre programme doit sauvegarder la solution trouvée dans un fichier texte donnant la liste des emplacements à visiter (leur nom et la distance cumulative), telle que montré ci-dessous (les valeurs montrées sont arbitraires et ne correspondent pas à la solution cherchée)</span>

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

<span style="font-family: 'Courier New';">Crestview 0</span>

<span style="font-family: 'Courier New';">Bellevue Manor 3.5</span>

<span style="font-family: 'Courier New';">…</span>

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

<span style="font-family: 'Times New Roman','serif';">Voir le devoir 1 pour obetnir la formule permettant de calculer la distance entre deux lieux specifiés par leur latitude et longitude.</span>

<span style="font-family: 'Times New Roman','serif';"></span><span style="font-family: 'Times New Roman','serif';"></span><span style="font-size: 11.0pt; line-height: 115%; font-family: 'Calibri','sans-serif';"></span><span style="font-family: 'Times New Roman','serif';"> </span>

**_<u><span style="font-family: 'Times New Roman','serif';">Question 0\. Pré-traitement du fichier d’entrée (Python ou Java)</span></u>_**

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

Le fichier contient la description des installations dans un fichier JSON. Vous pouvez utiliser soit Java ou Python afin de lire ce fichier et produire un fichier texte plus simple qui sera utilisé comme entrée par vos différentes solutions. Par exemple, dans le cas du paradigme logique, vous pouvez produire un fichier contenant une base de faits d’emplacements.

<span style="font-family: 'Times New Roman','serif';">Pour ce faire, vous pouvez utiliser la librairie de lecture JSON de votre choix ou écrire votre propre fonction. Simplement spécifier quelle est la librairie utilisée et fournir au besoin le module pour compilation.</span>

**<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>**

**_<u><span style="font-family: 'Times New Roman','serif';">Question 1\. Solution orientée-objet (Java)</span></u>_** <span style="font-family: 'Times New Roman','serif';">[3 points]</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-family: 'Times New Roman','serif';">Créer les classes nécessaires pour résoudre ce problème. Votre programme doit être une application appelée</span> <span style="font-family: 'Courier New';">findRoute</span> <span style="font-family: 'Times New Roman','serif';"></span> <span style="font-family: 'Times New Roman','serif';">prenant en argument le fichier de données d’entrée.</span>

<span style="font-family: 'Times New Roman','serif';">En plus du code source, vous devez aussi remettre un diagramme de classe UML montrant toutes les classes, leur attributs, méthodes et associations. Vous ne pouvez pas utiliser de méthodes statiques (à l’exception du</span> <span style="font-family: 'Courier New';">main</span><span style="font-family: 'Times New Roman','serif';">).</span>

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

**_<u><span style="font-family: 'Times New Roman','serif';">Question 2\. Solution logique (Prolog)</span></u>_** <span style="font-family: 'Times New Roman','serif';">[3 points]</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-family: 'Times New Roman','serif';">Écrire un prédicat Prolog</span> <span style="font-family: 'Courier New';">findRoute/1</span> <span style="font-family: 'Times New Roman','serif';">(et tous les autres prédicats requis) retournant la solution dans une liste. Les données d’entrée sont simplement contenues dans une base de faits. Vous devez aussi définir un prédicat</span> <span style="font-family: 'Courier New';">saveRoute/2</span> <span style="font-family: 'Times New Roman','serif';">avec comme premier argument la liste solution et comme second argument le nom du fichier texte à produire.</span>

<span style="font-family: 'Times New Roman','serif';">En plus du code source, vous devez aussi remettre la liste des prédicats accompagnés d’une courte description de leur fonctionnement.</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

**_<u><span style="font-family: 'Times New Roman','serif';">Question 3\. Solution fonctionnelle (Scheme)</span></u>_** <span style="font-family: 'Times New Roman','serif';">[3 points]</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-family: 'Times New Roman','serif';">Écrire une fonction Scheme</span> <span style="font-family: 'Courier New';">findRoute</span> <span style="font-family: 'Times New Roman','serif';">(et toutes les autres fonctions requises) prenant le nom d’un fichier de données comme entrée et retournant la liste solution. Vous devez aussi fournir une fonction</span> <span style="font-family: 'Courier New';">saveRoute</span> <span style="font-family: 'Times New Roman','serif';">prenant en argument la solution et le nom du fichier texte à produire. A noter que pour produire votre solution vous ne pouvez pas utiliser les fonctions Scheme dont le nom se termine par un</span><span style="font-size: 11.0pt; font-family: 'Courier New';"> !</span>

<span style="font-size: 11.0pt; font-family: 'Courier New';">(findRoute "pools.txt")</span>

*   <span style="font-size: 11.0pt; font-family: 'Courier New';">'(("Crestview" 0) ("Bellevue Manor" 3.5) … )</span>

<span style="font-family: 'Times New Roman','serif';"> </span>

<span style="font-size: 11.0pt; font-family: 'Courier New';">(saveRoute (findRoute "pools.txt") "solution.txt")</span>

*   <span style="font-size: 11.0pt; font-family: 'Courier New';">#t</span>

<span style="font-family: 'Times New Roman','serif';"> </span>

<span style="font-family: 'Times New Roman','serif';">En plus du code source, vous devez aussi remettre  la liste des fonctions créées et une courte description de celles-ci.</span>

**_<u><span style="font-family: 'Times New Roman','serif';"><span style="text-decoration: none;"> </span></span></u>_**

**_<u><span style="font-family: 'Times New Roman','serif';">Question 4\. Solution concurrente (Go)</span></u>_** <span style="font-family: 'Times New Roman','serif';">[3 points]</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-family: 'Times New Roman','serif';">Écrire un programmea Go contenant une fonction</span> <span style="font-family: 'Courier New';">findRoute</span> <span style="font-family: 'Times New Roman','serif';">prenant en paramètre le nom du fichier d'entrée. Votre solution doit utiliser la programmation concurrente en faisant usage d’un certain nombre de Go routines. Vous devez aussi fournir la function</span> <span style="font-family: 'Courier New';">saveRoute</span> <span style="font-family: 'Times New Roman','serif';">prenant en argument la solution trouvée et le nom du fichier texte à produire.</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-size: 10.0pt; font-family: 'Courier New'; color: windowtext;">func findRoute( filename string, num int) route []Edge</span>

<span style="font-size: 10.0pt; font-family: 'Courier New'; color: windowtext;">func saveRoute( route []Edge, filename string) bool</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

<span style="font-family: 'Times New Roman','serif';">En plus du code source, vous devez aussi expliquer quelle est la stratégie utilisée dans le design de votre solution concurrente.</span>

**<span style="font-family: 'Times New Roman','serif';"> </span>**

**_<u><span style="font-family: 'Times New Roman','serif';">Remise de votre travail</span></u>_**

Soumettre un fichier zip sur le campus virtuel. Ce répertoire compressé doit inclure les fichiers suivants:

*   *   <span style="font-family: 'Courier New';">Preprocessing.py ou .java</span>
    *   <span style="font-family: 'Courier New';">FindRoute.jar</span> (incluant le code source)
    *   <span style="font-family: 'Courier New';">findroute.pl</span>
    *   <span style="font-family: 'Courier New';">findroute.scm</span>
    *   <span style="font-family: 'Courier New';">findroute.go</span>
*   Documentation
    *   Un document pdf incluant la description de vos solutions
    *   Tous les fichiers textes utilisés en entréee
    *   Tous les fichiers texte produits par vos solutions, e.g. solution.pl.txt, solution.scm.txt etc.

<span style="font-family: 'Courier New';"> </span>
