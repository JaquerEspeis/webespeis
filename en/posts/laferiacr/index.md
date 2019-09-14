.. title: laferia.cr
.. slug: laferiacr
.. date: 2015-10-11 13:04:31 UTC-06:00
.. tags: 
.. link: 
.. description: Proyecto sobre agricultura libre.
.. type: text

# Necesidad #

En este momento de la historia, en la mayoría de los casos el consumidor no conoce el origen de los productos. Con una plataforma que brinde la posibilidad de compartir información entre productores y consumidores, se pueden solucionar varios problemas que presenta esta cadena de consumo.

# Plataforma #

Una plataforma, diseñada para compartir información entre productores, proveedores y consumidores, fue creada en Australia por la fundación Open Food Network.

Esta plataforma permite conocer el origen de los productos, la situación del productor, métodos de producción y otros factores que pueden tener alto impacto en la decisión del consumidor de orientarse a un producto o a otro.


<p><a href="http://www.youtube.com/watch?feature=player_embedded&amp;v=q1S2DfuiEh4" target="_blank"><img src="http://img.youtube.com/vi/q1S2DfuiEh4/0.jpg" alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10"></a> </p>

# Avance #

Por el momento lo que hemos logrado:

* Comprar el dominio
* Configurar ofn en ubuntu 14.04
* Necesitamos alguien con experiencia en ruby y rails para que revise
* Tenemos un ambiente de pruebas

# Instalación


## Ambiente de Producción

1. Agregar el "Host" a la configuración de la Base de datos en `config/database.yml`:
```
production:
  adapter: postgresql
  encoding: unicode
  database: open_food_network_prod
  pool: 5
  host: localhost
  username: ofn_user
  password: toor
```

2. Crear la base de datos:
```
/opt/openfoodnetwork/www# RAILS_ENV=production rake db:schema:load db:seed
```


3. Precompilar los activos en el ambiente de producción:
```
/opt/openfoodnetwork/www# RAILS_ENV=production rake assets:clean
/opt/openfoodnetwork/www# RAILS_ENV=production rake assets:precompile
```

4. Correr Unicorn en producción manualmente
```
 cd /opt/openfoodnetwork/www && bundle exec unicorn -c ../shared/config/unicorn.rb -E production -D
```

# Solucion de Problemas

- Información del Log de Unicorn:
```
$ tail -f /opt/openfoodnetwork/shared/log/unicorn.log
```

- Encontrar la ubicación del Unix Socket en /opt/openfoodnetwork/shared/config/unicorn.rb

- Verificar que el Unix socket se encuentre creado:
```
$ ls -lah /tmp/unicorn.openfoodnetwork.sock
```


- Verificar que Unicorn esté corriendo:
```
$ ps aux | grep unicorn
```




# Referencias

(1) http://teotti.com/use-of-rails-environments/
(2) https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04

