# Projet application Shiny : Visualisation des données épidémiologiques et génomiques du SARS-CoV-2 et de ses différentes introductions au Cameroun

## Introduction

Du début de l’année 2020 jusqu’en 2024, le Cameroun a été confronté à la pandémie de Covid-19, provoquée par le virus SARS-CoV-2. Durant cette période, le Ministère de la Santé Publique a déployé un plan national de riposte visant à identifier, suivre et prendre en charge les cas de Covid-19 sur l’ensemble du territoire. La coordination opérationnelle de cette riposte a été assurée par le **Centre de Coordination des Opérations d’Urgence de Santé Publique (CCOUSP)**, une structure rattachée à la **Direction de la Lutte contre la Maladie, les Épidémies et les Pandémies (DLMEP)** et le **Laboratoire National de Santé Publique (LNSP)**.

Le CCOUSP était organisé en plusieurs unités spécialisées, notamment la logistique, la gestion des données, le laboratoire, la communication des risques, la prise en charge médicale et la surveillance épidémiologique. Dans le cadre de l’identification des cas, un **algorithme de détection** avait été mis en place, allant du repérage des cas suspects (selon une définition standardisée des symptômes et des facteurs de risque) à la confirmation par test de biologie moléculaire (RT-PCR). Ce dispositif a permis non seulement de détecter rapidement les infections, mais aussi de suivre l’évolution de l’épidémie à travers le pays.

Cette crise sanitaire a particulièrement mis en évidence le **rôle central des laboratoires** dans le système de surveillance. En effet, au-delà des tests diagnostiques, plusieurs laboratoires de référence ont été progressivement intégrés dans un réseau national, renforçant la capacité du pays en matière de **surveillance épidémiologique et génomique**. Cela a conduit à la mise en place d’un système plus robuste, capable de suivre non seulement la dynamique de propagation du virus, mais aussi l’émergence de nouveaux variants préoccupants (Variants of Concern, VOC) et variants d’intérêt (Variants of Interest, VOI).

Au regard de ce qui précède, une question essentielle se pose : **quel a été l’apport concret de ces laboratoires agréés en termes de production d’informations fiables et exploitables pour la riposte nationale contre la Covid-19 ?**

Pour y répondre, nous proposons de combiner les données épidémiologiques et génomiques du SARS-CoV-2 afin d’analyser la dynamique d’introduction et de diffusion du virus au Cameroun. Cette analyse permettra d’illustrer comment les données de laboratoire peuvent éclairer les décisions de santé publique.

Enfin, afin de rendre ces résultats accessibles et interactifs, nous développerons une **application Shiny** de visualisation, facilitant l’exploration des données par les acteurs de santé publique, les chercheurs et les décideurs politiques.

------------------------------------------------------------------------

## Objectifs

### 1. Objectif général

Analyser la **dynamique d’introduction et de propagation** du SARS-CoV-2 au Cameroun, à partir de l’intégration conjointe des données épidémiologiques et génomiques produites par les laboratoires agréés durant la pandémie.

### 2. Objectifs spécifiques

De manière plus précise, il s’agira de :

-   décrire la **dynamique spatio-temporelle de propagation** du virus à travers les différentes régions du pays,
-   identifier et caractériser les **événements d’introduction** du SARS-CoV-2 et de ses variants (VOC et VOI) sur le territoire national,
-   mettre en évidence la **circulation locale et inter-régionale** des lignages viraux afin de comprendre les chaînes de transmission,
-   valoriser ces résultats à travers une **application Shiny interactive** permettant la visualisation et l’exploration des données.

------------------------------------------------------------------------

## Méthodologie

La réalisation de ce projet s’est effectuée en plusieurs étapes :

### 1. Collecte et nettoyage des données

Les données provenaient de deux principales sources :

| Source | Description | Données collectées | Période | Localisation |
|----|----|----|----|----|
| **LNSP / Unité gestion de données** | Informations sur la confirmation des cas dans les laboratoires agréés Covid-19 compilées par l’unité gestion de données du LNSP et l’unité laboratoire du CCOUSP. | \- date d’analyse<br>- région<br>- laboratoire agréé<br>- nombre de cas testés (RT-PCR)<br>- nombre de cas positifs (RT-PCR) | 2020–2024 | 10 régions du Cameroun |
| **GISAID** | Données WGS du Covid-19 partagées par la communauté scientifique. | \- séquences complètes SARS-CoV-2 (fasta)<br>- date de collecte<br>- sexe patient<br>- âge patient<br>- symptômes<br>- géolocalisation (continent/pays/région) | 2019–2024 | Monde entier |

Les données ont ensuite été **nettoyées, harmonisées et normalisées** pour constituer une base consolidée.

------------------------------------------------------------------------

### 2. Étude épidémiologique

Analyse de la **dynamique spatio-temporelle** de la pandémie au Cameroun :

-   vagues épidémiques successives,
-   variants et lignées prédominants,
-   répartition géographique et temporelle.

Outils principaux :

-   **Nextclade** pour la classification en variant, sous-lignées,
-   **tidyverse** et **plotly** pour les analyses et visualisations interactives.

Résultats :

-   **courbes épidémiologiques nationales**,\
-   **cartes dynamiques** (propagation et laboratoires agréés),\
-   **évolution des variants et sous-lignées** dans le temps.

------------------------------------------------------------------------

### 3. Analyse phylogénétique des variants

Étude des **relations de parenté et de similarité** entre souches camerounaises et internationales.

Outils :

-   **Mafft** (alignement multiple),
-   **IQTree** (ML phylogeny),
-   **ggtree** (visualisation).

------------------------------------------------------------------------

### 4. Analyse des introductions

Analyse des **événements d’introduction du SARS-CoV-2** au Cameroun avec **Treetime**, afin de :

-   estimer le **nombre d’introductions indépendantes**,
-   identifier les **sources probables** (pays/régions),
-   décrire la **diffusion locale** après introduction.

------------------------------------------------------------------------

### 5. Application Shiny

Une **application Shiny interactive** a été développée pour :

-   visualiser les courbes épidémiologiques,
-   explorer les **cartes dynamiques** (propagation et laboratoires),
-   suivre l’évolution des **variants et lignées**,
-   consulter les **arbres phylogénétiques interactifs**.

------------------------------------------------------------------------

## Résultats
