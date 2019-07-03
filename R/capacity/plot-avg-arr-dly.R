apt_arrival_dly <- function(airport, since, to){
  
  all_details_apt <- all_details %>%
    filter(apt_name == airport) %>%
    filter(yyyy >= since & yyyy <= to) %>%
    group_by(yyyy, delay_group) %>%
    summarise(delay = sum(delay)) 
  
  all_summaries_apt <- all_summaries %>%
    filter(apt_name == airport) %>%
    filter(yyyy >= since & yyyy <= to) %>%
    group_by(yyyy) %>%
    summarise(arrival_delay = sum(arrival_delay), num_arrivals = sum(num_arrivals))
  
  all_apt <- inner_join(all_details_apt, all_summaries_apt, by = "yyyy")
  
  all_apt <- all_apt %>%
    mutate(avg = arrival_delay/num_arrivals,
           dly = delay/num_arrivals) %>%
    select(- delay)
  
  all_apt$yyyy <- as.character(all_apt$yyyy)
  
  g <- ggplot(all_apt, aes(x = yyyy, y = dly, fill = delay_group))
  
  apt_arr_dly_plot <- g + 
    geom_bar(stat = "identity") +
    theme_pru() +
    scale_fill_manual(values = c("#FBC294", "#92D24A", "#C0504E", "#BFBFBF"),
                      #values = pru_pal()(9)[c(2,4,7,9)],
                      name = "",
                      breaks = c("ATC attributed", "W", "G", "Other"),
                      labels = c(
                         "ATC attributed [C, S, I, T]",
                         "Weather [W, D]",
                         "Airport Capacity [G]",
                         "Other [all other codes]")) +
    labs(x = "",
         y = "Avg. airport ATFM arrival delay per arrival (min)",
         title = paste("Average airport arrival ATFM delay -", airport, "airport"),
         subtitle = "") +
    #ylim(0,1) +
    theme(legend.position = "bottom")
  
  apt_arr_dly_plot
}