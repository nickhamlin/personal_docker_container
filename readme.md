# Nice docker containers for python data work

Virtual environments are great, but sometimes you want to work in a totally padded room in which to work. This repo extends the standard jupyter docker notebook image to allow for easy customization alongside some better processes (like notebook templates).

## Setup instructions

1. Clone this repo
2. Fill in this template where indicated by the TODOs

    ```bash
    docker_notebook() {
    docker run -itd --rm \
        -v $PWD:/mnt \

        # TODO: Add paths to any hidden directories you want to have available
        -v <LOCAL_PATH_TO_AWS_CREDENTIALS>:/home/jovyan/.aws \
        -v <LOCAL_PATH_TO_OTHER_CONFIGS>:/home/jovyan/.config \
        -v <LOCAL_PATH_TO_SSH_KEYS>:/home/jovyan/.ssh \

        # TODO: Add any environment variables you want to expose
        -e MYSQL_USER=$MYSQL_USER \
        -e MYSQL_PWD=$MYSQL_PWD \

        # Other housekeeping - do not modify
        -w /mnt \
        -p "$1":8888 \
        --name ${PWD##*/} \
        --user root \

        # TODO: Give your image a name
        <MY_IMAGE_NAME>

        sleep 2 # Give jupyter a chance to start
        url=$(docker logs --tail 1 ${PWD##*/})
        echo "${url/8888/$1}"
    }
    ```

3. Delete all the comments and line breaks in the `docker run` command  
4. Add the whole result to your `bash_profile`, `profile`, or `bash_rc`  
5. Source whatever file you added it to  
6. (Optional): Make modifications to specific components as desired  
    a. Modify `setup/main.js` to change the notebook template.  
    b. Add any other packages you want installed to `requirements.txt`  
    c. Modify `Dockerfile` to change the nbextensions that will be enabled on startup or install any non-pip packages  
7. Build the container: `docker build -t <MY_IMAGE_NAME> .`  
8. `cd` to whatever directory you want to start the container from. The container's name will be the same as whatever directory you're in when you start it.  
9. Start the container and indicate which port you want to use: `docker_notebook <PORT>`  
10. Open the URL that appears (in OSX terminal, right click -> Open URL; in vscode, cmd+click)  
11. Make stuff! New notebooks created in this container will be. created using the template  
12. When finished, save your work and stop the container: `docker stop <MY_CONTAINER>`  

## Resources

- [Jupyter docker images](https://jupyter-docker-stacks.readthedocs.io/en/latest/)
- Will Koehrsen's advice on notebook extensions and templates are the basis for lots of this
  - [templating article](https://towardsdatascience.com/set-your-jupyter-notebook-up-right-with-this-extension-24921838a332)
  - [templating repo](https://github.com/WillKoehrsen/Data-Analysis/tree/master/setup)
  - [suggested extensions](https://towardsdatascience.com/jupyter-notebook-extensions-517fa69d2231)
