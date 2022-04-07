using { sap.capire.bookshop as my } from '../db/schema';

service CatalogService @(requires: 'authenticated-user'){
    entity Books as projection on my.Books
    entity Authors as projection on my.Authors
}

annotate CatalogService.Books with @(restrict: [
    { grant: ['READ'], to: 'Viewer', where: 'author.ID = $user.AuthorID'},
    { grant: ['*'], to: 'Admin'}
    ]){
    
    ID          @title: 'ID';
	title       @title: 'Title';
	descr       @title: 'Description';
	author      @title: 'Author';
    genre       @title: 'Genres';
    stock       @title: 'Stock';
    price       @title: 'Price';
    currency    @title: 'Currency';
};

annotate CatalogService.Authors with {
  name         @title: 'Name';
  dateOfBirth  @title: 'Date of Birth';
  dateOfDeath  @title: 'Date of Death';
};

annotate CatalogService.Books with @(
    UI: {
        HeaderInfo: {
            TypeName: 'Book',
            TypeNamePlural: 'Books',
            Title: { Value: ID },
            Description: { Value: title }
        },
        SelectionFields: [ ID, title, author.name ],
        LineItem: [
            { Value: ID },
            { Value: title },
            { Value: author.name },
            { Value: price },
            { Value: currency_code }               
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Book Info',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Main', Label: 'Main Facet'}
                ]
            }
        ],        
        FieldGroup#Main: {
            Data: [
                { Value: ID },
                { Value: title },
                { Value: author_ID },
                { Value: price },
                { Value: currency_code }               
            ]
        }
    }
);
annotate CatalogService.Authors with @(
    UI: {
        HeaderInfo: {
            TypeName: 'Author',
            TypeNamePlural: 'Authors',
            Title: { Value: ID },
            Description: { Value: name }
        },
        SelectionFields: [ ID, name ],
        LineItem: [
            { Value: ID },
            { Value: name },
            { Value: dateOfBirth },
            { Value: dateOfDeath }               
        ],
        Facets: [
            {
                $Type: 'UI.CollectionFacet',
                Label: 'Author Info',
                Facets: [
                    {$Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Main', Label: 'Main Facet'}
                ]
            }
        ],        
        FieldGroup#Main: {
            Data: [
                { Value: ID },
                { Value: name },
                { Value: dateOfBirth },
                { Value: dateOfDeath }       
            ]
        }
    }
);