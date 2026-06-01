# Potentiel Monitoring

Cette application permet le monitoring de l'application Potentiel.

La stack de monitoring est basée sur https://github.com/MTES-MCT/qualicharge-logs : 
- une base de donnée Postgres avec l'extension [timescaleDB](https://github.com/timescale/timescaledb) pour stocker les logs
- un serveur [Vector](https://github.com/vectordotdev/vector) pour ingérer les logs. 
- (à venir) une application de visualisation des logs. En attendant, voir "Lire les logs"

L'application Potentiel émet les logs via un "log drain" (cf https://doc.scalingo.com/platform/app/log-drain#scalingo-hosted-elk-stack).



## Lire les logs
En attendant de mettre en place la visualisation, les logs peuvent être visualisés en suivant ces instructions :
- ouvrir un tunnel sur la DB de monitoring : 
```bash
scalingo db-tunnel --app potentiel-monitoring --region osc-secnum-fr1 SCALINGO_POSTGRESQL_URL
```

- se connecter à la DB avec un client Postgres et requêter la table logs :
```sql
select * from logs
order by ts desc
limit 100;
```

## Déploiement
Chaque commit sur `main` met à jour l'application. 

Pour mettre à jour Postgres, voir la documentation de Scalingo.

Pour mettre à jour Vector, mettre à jour le buildpack (cf [.buildpacks](.buildpacks))

## Tester les transformations VRL

Un jeu de tests unitaires Vector est disponible pour valider `transforms.vrl`.

```bash
./test-vrl.sh
```

Ce script exécute `vector test` dans l'image Docker utilisée par le projet et lance les cas définis dans `tests/vector-tests.yaml`.