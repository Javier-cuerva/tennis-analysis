# Data Analysis of The Big Three players.

Data Analysis on The Big Three in the Australian Open Tournament.

The actual analysis is performed in the jupyter notebook file analysis.ipynb inside the analysis folder. 

To automatically create the datasets, it is necessary to execute *database-setup.sh* in a linux machine. The two bash script were created for connecting to [this database](https://hub.docker.com/r/mcekovic/uts-database) and fetch the datasets. More information about the databate can be found inside the link. Running *database-setup.sh* will setup the docker container, trigger *psql-script* inside its terminal to query the datasets and bring them as CSV files to host machine.

There is no need to go through the previous process every time if the folder *dataset* already contains the files.

REMARK: [The Big Three](https://en.wikipedia.org/wiki/Big_Three_(tennis)) references the Tennis players Rafael Nadal, Novak Djokovic and Roger Federer.
