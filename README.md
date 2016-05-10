# Toolchain: Terraform Modules
These modules are generic AWS Terraform state files which can be freely used for setting up various parts of your infrastructure, or all of it.

The modules are heavily documented in my open source book, [Tools & Architectures](https://www.gitbook.com/book/mrcrilly/toolchain/details).

## Submodules
Remember, Terraform supports using sub directories in git repositories, hence why we've rolled everything up into one repository. Here is an example:

```hcl
module "consul" {
    source = "github.com/user/terraform_repo//some/module"
    servers = 3
}
```

The `//` is important in the path as it tells Terraform that we want to reference a sub directory within the repository's structure.

## Subnetting
The networking layout here has been predetermined as per the book, listed above. They follow this pattern, which is designed to be generic. You can adjust the code accordingly if you want different subnets.

You should review the book to understand the subnet layouts, and the code included in this repository to see how they're implemented. The key is to find the calls to the `cidrsubnet()` function in the `main.tf` file of each subnet.

# Licence
MIT. See the file `LICENCE`.