package main

import (
	"html/template"
	"log"
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	homePageHits = promauto.NewCounter(prometheus.CounterOpts{
		Name: "myapp_processed_home_page_total",
		Help: "The total number of GETs to the home page",
	})
	pageNotFound = promauto.NewCounter(prometheus.CounterOpts{
		Name: "myapp_page_not_found_total",
		Help: "The total number of GETs against non existing pages (routes)",
	})
	internalServerError = promauto.NewCounter(prometheus.CounterOpts{
		Name: "myapp_internal_server_error_total",
		Help: "The total number of http 500 responses",
	})
)

func health(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(200)
}

func home(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/" {
		http.NotFound(w, r)
		pageNotFound.Inc()
		return
	}

	files := []string{
		"./ui/html/home.page.tmpl",
		"./ui/html/base.layout.tmpl",
		"./ui/html/footer.partial.tmpl",
	}
	ts, err := template.ParseFiles(files...)
	if err != nil {
		log.Println(err.Error())
		http.Error(w, "Internal Server Error", 500)
		internalServerError.Inc()
		return
	}

	err = ts.Execute(w, nil)
	if err != nil {
		log.Println(err.Error())
		http.Error(w, "Internal Server Error", 500)
		internalServerError.Inc()
		return
	}
	homePageHits.Inc()
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", home)
	mux.HandleFunc("/healthz", health)
	mux.Handle("/metrics", promhttp.Handler())

	log.Println("Starting server on :4000")
	err := http.ListenAndServe(":4000", mux)
	log.Fatal(err)
}
