# 30 Day Chart challenge 2021
# 16th April 2021: Tree
# Data Source: rotl r package for Open Tree of Life
# Clipart using phylopic http://phylopic.org/
library(rotl)     # to get phylogenetic data
library(ggtree)   # to plot phylogenetic tree
library(ggplot2)
library(ggimage)  # needed for phylopic
library(extrafont)

# Define the species to look at and tnrs_match_names will find their id to use in creating tree
taxa <- tnrs_match_names(names = c("Ornithorhynchus anatinus", # platypus
                                   "Tachyglossus aculeatus",   # echidna
                                   "Phascolarctos cinereus",   # koala
                                   "Macropus giganteus",       # kangaroo   
                                   "Ailuropoda melanoleuca",   # panda
                                   "Carcharodon carcharias",   # great white
                                   "Megaptera novaeangliae",   # humpback
                                   "Eudyptula minor",          # little penguin
                                   "Tiliqua scincoides",       # blue tongue lizard
                                   "Notechis scutatus",        # tiger snake
                                   "Dromaius novaehollandiae", # emu
                                   "Dacelo novaeguineae",      # kookaburra
                                   "Myrmecia gulosa",          # bull ant
                                   "Musca domestica"           # fly
                                   ))

# Create tree nodes from Open Tree Life data
# this will return a newick type format which can be passed to ggtree
tree_data <- tol_induced_subtree(ott_ids = ott_id(taxa))

# Search for animals on phylopic website and copy their image id
phylopic_info <- data.frame(node = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14),
                            common_name = c('Humpback Whale','Panda','Kangaroo', 'Koala','Echidna','Platypus',
                                            'Kookaburra','Little Penguin','Emu','Tiger Snake',
                                            'Blue Tongue Lizard','Great White Shark','House Fly','Bull Ant'),
                            phylopic = c("ce70490a-79a5-47fc-afb9-834e45803ab4",
                                         "3d259941-f8c2-48cb-843b-af4a178031e9",
                                         "c306572a-fae1-41e3-8208-c2bce972e0ef",
                                         "7fb9bea8-e758-4986-afb2-95a2c3bf983d",
                                         "6885c062-5deb-4ebf-a481-752186819108",
                                         "61932f57-1fd2-49d9-bb86-042d6005581a",
                                         "2a330379-b5e6-4132-aca4-cb19ff7b88d0",
                                         "00cccd9b-0cd7-4677-9918-eddeac5cf1c6",
                                         "35947c43-1e5c-4003-bbaa-d352530b5af7",
                                         "5d0b92da-001a-4014-8bfa-05eb457b8e40",
                                         "83ba27dd-ad53-45e4-acf4-d75bf74105a6",
                                         "36d54b94-35a6-4a66-a41e-b8f28534e70c",
                                         "7252c46a-6bf1-42dd-ac5a-1018f404dfc8",
                                         "e5330b43-bd85-43af-b5bf-4e960975cd55"))

ggtree(tree_data) %<+% phylopic_info +
  geom_tiplab(aes(image=phylopic), geom="phylopic", alpha=.5, color='blue3', offset=.1) +
  geom_tiplab(aes(label=common_name), family='Goudy Stout', offset = .75, col='gray50') + 
  xlim(NA, 10) +
  geom_text(aes(x=2, y=13.5, label='Phylogenetic\nTree'), colour='gray50', size=6, family='Goudy Stout') +
  labs(caption='Data Source: rotl package from Open Tree of Life\nClipart: phylopic\nCreated by: dosullivan019') +
  theme(plot.caption=element_text(size=10, face='italic'))

ggsave('plots/day16_phylogenetic_tree.png')
