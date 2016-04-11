module Ontology {

    typedef structure {
        string format_version;
        string data_version;
        string date;
        string saved_by;
        string auto_generated_by;
        list<string> import;
        list<string> subsetdef;
        list<string> synonymtypedef;
        list<string> default_namespace;
        list<string> namespace_id_rule;
        list<string> idspace;
        list<string> treat_xrefs_as_equivalent;
        list<string> treat_xrefs_as_genus_differentia;
        list<string> treat_xrefs_as_relationship;
        list<string> treat_xrefs_as_is_a;
        list<string> remark;
        string ontology;
    } OntologyHeader;

    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> builtin;
        list<string> property_value;
        list<string> is_a;
        list<string> intersection_of;
        list<string> union_of;
        list<string> equivalent_to;
        list<string> disjoint_from;
        list<string> relationship;
        string created_by;
        string creation_date;
        string is_obsolete;
        list<string> replaced_by;
        list<string> consider;
    } OntologyTerm;

    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> property_value;
        list<string> domain;
        list<string> range;
        list<string> builtin;
        list<string> holds_over_chain;
        string is_anti_symmetric;
        string is_cyclic;
        string is_reflexive;
        string is_symmetric;
        string is_transitive;
        string is_functional;
        string is_inverse_functional;
        list<string> is_a;
        list<string> intersection_of;
        list<string> union_of;
        list<string> equivalent_to;
        list<string> disjoint_from;
        list<string> inverse_of;
        list<string> transitive_over;
        list<string> equivalent_to_chain;
        list<string> disjoint_over;
        list<string> relationship;
        string is_obsolete;
        string created_by;
        string creation_date;
        list<string> replaced_by;
        list<string> consider;
        list<string> expand_assertion_to;
        list<string> expand_expression_to;
        string is_metadata_tag;
        string is_class_level;
    } OntologyTypedef;

    typedef structure {
        string id;
        string is_anonymous;
        string name;
        string namespace;
        list<string> alt_id;
        list<string> def;
        list<string> comment;
        list<string> subset;
        list<string> synonym;
        list<string> xref;
        list<string> instance_of;
        list<string> property_value;
        list<string> relationship;
        string created_by;
        string creation_date;
        string is_obsolete;
        list<string> replaced_by;
        list<string> consider;
    } OntologyInstance;

    typedef structure {
        OntologyHeader header;
        mapping<string, OntologyTerm> term_hash;
        mapping<string, OntologyTypedef> typedef_hash;
        mapping<string, OntologyInstance> instance_hash;
    } OntologyDictionary;

};
