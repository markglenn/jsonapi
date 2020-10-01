defmodule JsonAPI.ParserTest do
  use ExUnit.Case

  alias JsonAPI.Parser

  describe "parse/1" do
    test "full document" do
      doc = Parser.parse(full_payload())

      assert [
               %{
                 type: "articles",
                 id: "1"
               }
             ] = doc.data
    end

    test "error document" do
      doc = Parser.parse(error_payload())

      assert [
               %JsonAPI.Structure.Error{
                 detail: "First name must contain at least three characters."
               }
             ] = doc.errors

      assert is_nil(doc.data)
    end
  end

  defp full_payload do
    """
    {
      "links": {
        "self": "http://example.com/articles",
        "next": "http://example.com/articles?page[offset]=2",
        "last": "http://example.com/articles?page[offset]=10"
      },
      "jsonapi": {
        "version": "1.0"
      },
      "data": [{
        "type": "articles",
        "id": "1",
        "attributes": {
          "title": "JSON:API paints my bikeshed!"
        },
        "relationships": {
          "author": {
            "links": {
              "self": "http://example.com/articles/1/relationships/author",
              "related": "http://example.com/articles/1/author"
            },
            "data": { "type": "people", "id": "9" }
          },
          "comments": {
            "links": {
              "self": "http://example.com/articles/1/relationships/comments",
              "related": "http://example.com/articles/1/comments"
            },
            "data": [
              { "type": "comments", "id": "5" },
              { "type": "comments", "id": "12" }
            ]
          }
        },
        "links": {
          "self": "http://example.com/articles/1"
        }
      }],
      "included": [{
        "type": "people",
        "id": "9",
        "attributes": {
          "firstName": "Dan",
          "lastName": "Gebhardt",
          "twitter": "dgeb"
        },
        "links": {
          "self": "http://example.com/people/9"
        }
      }, {
        "type": "comments",
        "id": "5",
        "attributes": {
          "body": "First!"
        },
        "relationships": {
          "author": {
            "data": { "type": "people", "id": "2" }
          }
        },
        "links": {
          "self": "http://example.com/comments/5"
        }
      }, {
        "type": "comments",
        "id": "12",
        "attributes": {
          "body": "I like XML better"
        },
        "relationships": {
          "author": {
            "data": { "type": "people", "id": "9" }
          }
        },
        "links": {
          "self": "http://example.com/comments/12"
        }
      }]
    }
    """
  end

  defp error_payload do
    """
    {
      "errors": [
        {
          "status": "422",
          "source": { "pointer": "/data/attributes/firstName" },
          "title":  "Invalid Attribute",
          "detail": "First name must contain at least three characters."
        }
      ]
    }
    """
  end
end
