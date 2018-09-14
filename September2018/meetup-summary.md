# RLadies Philly Meetup 9/13

Information and resources from the RLadies Philadelphia meetup September 13 2018 on building a website with blogdown

## Workflow

We started by first creating a directory for the foles (I made a new floder on my desktop as an example). Then we installed the blogdown pacakge and installed hugo with ``blogdown::install_hugo()``. Then we chose a theme from https://themes.gohugo.io/ and found the github repo for that theme. For example the hugo-academic theme can be found at https://github.com/gcushen/hugo-academic so we need the repo: "gcushen/hugo-academic".

Then we started a New Project > Existing directory, choosing the empty directory we just created. Then we use ``blogdown::new_site(theme="gcushen/hugo-academic")`` to create our website! Using the Addins menu in RStudio, we clicked on Serve Site to preview our website in the viewer pane.

Now that we had a template site built, we started customizing it, mainly focusing on the config.toml file and all of the files in content > home.

To continue, just keep replacing the template content with your own. Then you can start creating new content of your own! There are many resources to help you figure out how to customize your sites, I like https://bookdown.org/yihui/blogdown/ but you can browse many people's blogs and tips for blogdown just by getting on the old google.

Once you are happy with the website you have built locally on your machine, you need to take it live!! The first step is getting git running with RStudio so you can upload your files and easily update your website in the future. Jenny Bryan's book for installing git http://happygitwithr.com/ is a great resource starting from scratch! RLadies Philly also had a meetup on git, you can check out the files here: https://github.com/rladies/meetup-presentations_philadelphia/tree/master/May2018

The easiest way to do this may be to start a new project linked to a github repo. Then you can recreate your site with ``blogdown::new_site()`` and just copy your files (config.toml, content folder, etc) to the new directory.

Once you have pushed your files to a github repo, you can use a service to deploy your website. There are a bunch of choices, an easy one is netlify https://www.netlify.com/ Sign up for a free account online and source your files from your github repo. One trick is that you might need to specify the version of hugo you are using. You can use the environmental variable ``HUGO_VERSION ‘0.40.2’`` (or whichever version of hugo was used to build the site locally on your machine - use blogdown::hugo_version() to find the correct version).

## Resources

Blogdown Book

https://bookdown.org/yihui/blogdown/

Setting up git

http://happygitwithr.com/

Deploying your website!

https://www.netlify.com/




