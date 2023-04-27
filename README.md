THIS REPO/WEBSITE is NOW ARCHIVED, head to https://github.com/euctrl-pru/aiu-portal/ for the new one.


# website

This is the source repository of the [PRU web site](https://ansperformance.eu).

This site is automatically built and deployed by Netlify:

* branches named like `<YYYY><MM>-release*` are development branches for upcoming release


# Development

The configuration is such that the site will be generated in
`../pru-portal-generated`

You can build it via

```
rmarkdown::render_site(encoding = 'UTF-8')
```

You can preview it by serving the page with

```
blogdown::serve_site(.site_dir = "../pru-portal-generated")
```

and then browsing at http://localhost:4321

