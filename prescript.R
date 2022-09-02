

l <- readLines("rxode2/R/rxsolve.R")

w <- which(regexpr("@param", l) != -1)

l <- l[-seq(1, w[1] - 1)]

w <- which(regexpr("@return", l) != -1)
l <- l[seq(1, w[1] - 1)]

l <- sub("#+' *", "", l)

l <- gsub("@param *([^ ]*)", "### \\1\n`\\1`", l)

w <- which(regexpr("@inheritParams", l) != -1)

if (length(w) > 0) l <- l[-w]

l[1] <- paste0("## General Solving Options\n\n", l[1])

w <- which(regexpr("atol", l) != -1)
if (length(w) > 0){
  w <- w[1]
  l[w] <- paste0("## lsoda/dop solving options\n\n", l[w])
}

w <- which(regexpr("indLinMatExpType", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Inductive Linerization Options\n\n", l[w])
}

w <- which(regexpr("minSS", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Steady State Solving Options\n\n", l[w])
}

w <- which(regexpr("maxAtolRtolFactor", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## rxode2 numeric stability options\n\n", l[w])
}

w <- which(regexpr("sensType", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Linear compartment model sensitivity options\n\n", l[w])
}

w <- which(regexpr("iCov", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Covariate Solving Options\n\n", l[w])
}

w <- which(regexpr("seed", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Simulation options\n\n", l[w])
}

w <- which(regexpr("returnType", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## rxode2 output options\n\n", l[w])
}

w <- which(regexpr("nDisplayProgress", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Internal rxode2 options\n\n", l[w])
}

w <- which(regexpr("cores", l) != -1)
if (length(w) > 0) {
  w <- w[1]
  l[w] <- paste0("## Parallel/Threaded Solve\n\n", l[w])
}

l2 <- readLines("07-solving.Rmd")

w <- which(regexpr("below", l2) != -1)
l2 <- l2[1:w]

writeLines(c(l2, "", "", l), "07-solving.Rmd")

for (f in list.files("rxode2/vignettes/",pattern="\\.png$")) {
  file.copy(file.path("rxode2/vignettes/", f), f)
}
